package com.springmvc.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.springmvc.model.Claim;
import com.springmvc.model.Policy;
import com.springmvc.model.User;
import com.springmvc.model.UserProfile;
import com.springmvc.service.ClaimService;
import com.springmvc.service.PolicyService;
import com.springmvc.service.UserProfileService;
import com.springmvc.service.UserService;



@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class AppController {

	@Autowired
	UserService userService;
	
	@Autowired
	UserProfileService userProfileService;
	
	@Autowired
	PolicyService policyService;
	
	@Autowired
	ClaimService claimService;
	
	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;
	
	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;
	
	
	/**
	 * This method will list all existing users.
	 */
	@RequestMapping(value = { "/", "/list" }, method = RequestMethod.GET)
	public String listUsers(ModelMap model) {

		List<User> users = userService.findAllUsers();
		model.addAttribute("users", users);
		model.addAttribute("loggedinuser", getPrincipal());
		List<Policy> policies = policyService.findAllPolicies(getPrincipal()); 
		List<Claim> claims = new ArrayList<Claim>();
		for(Policy policy: policies) {
			claims.addAll(policy.getClaims());
		}
		model.addAttribute("allpolicies", policies);
		model.addAttribute("allclaims", claims);
		model.addAttribute("allpoliciescount", policies.size());
		model.addAttribute("allclaimscount", claims.size());
		model.addAttribute("activepoliciescount",activePolicies(policies));
		model.addAttribute("activeclaimscount",activeClaims(claims));
		return "home";
	}


	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.GET)
	public String newUser(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "registration";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result,
			ModelMap model) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*
		 * Preferred way to achieve uniqueness of field [sso] should be implementing custom @Unique annotation 
		 * and applying it on field [sso] of Model class [User].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you can fill custom errors outside the validation
		 * framework as well while still using internationalized messages.
		 * 
		 */
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}
		
		userService.saveUser(user);

		model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " registered successfully");
		//return "success";
		return "registrationsuccess";
	}


	/**
	 * This method will provide the medium to update an existing user.
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.GET)
	public String editUser(@PathVariable String ssoId, ModelMap model) {
		User user = userService.findBySSO(ssoId);
		model.addAttribute("user", user);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "registration";
	}
	
	/**
	 * This method will be called on form submission, handling POST request for
	 * updating user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result,
			ModelMap model, @PathVariable String ssoId) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*//Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in UI which is a unique key to a User.
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}*/


		userService.updateUser(user);

		model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " updated successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		return "registrationsuccess";
	}

	
	/**
	 * This method will delete an user by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-user-{ssoId}" }, method = RequestMethod.GET)
	public String deleteUser(@PathVariable String ssoId) {
		userService.deleteUserBySSO(ssoId);
		return "redirect:/list";
	}
	

	/**
	 * This method will provide UserProfile list to views
	 */
	@ModelAttribute("roles")
	public List<UserProfile> initializeProfiles() {
		return userProfileService.findAll();
	}
	
	/**
	 * This method handles Access-Denied redirect.
	 */
	@RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
	public String accessDeniedPage(ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		return "accessDenied";
	}

	/**
	 * This method handles login GET requests.
	 * If users is already logged-in and tries to goto login page again, will be redirected to list page.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage() {
		if (isCurrentAuthenticationAnonymous()) {
			return "login";
	    } else {
	    	return "redirect:/list";  
	    }
	}

	/**
	 * This method handles logout requests.
	 * Toggle the handlers if you are RememberMe functionality is useless in your app.
	 */
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			//new SecurityContextLogoutHandler().logout(request, response, auth);
			persistentTokenBasedRememberMeServices.logout(request, response, auth);
			SecurityContextHolder.getContext().setAuthentication(null);
		}
		return "redirect:/login?logout";
	}

	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private String getPrincipal(){
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		return userName;
	}
	
	/**
	 * This method returns true if users is already authenticated [logged-in], else false.
	 */
	private boolean isCurrentAuthenticationAnonymous() {
	    final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    return authenticationTrustResolver.isAnonymous(authentication);
	}

	/**
	 * This method will list all existing policies.
	 */
	@RequestMapping(value = { "/allpolicies" }, method = RequestMethod.GET)
	public String listPolicies(ModelMap model) {

		model.addAttribute("loggedinuser", getPrincipal());
		List<Policy> policies = policyService.findAllPolicies(getPrincipal()); 
		model.addAttribute("allpolicies", policies);
		return "policydetails";
	}
	
	/**
	 * This method will list all existing claims.
	 */
	@RequestMapping(value = { "/allclaims" }, method = RequestMethod.GET)
	public String listClaims(ModelMap model) {

		model.addAttribute("loggedinuser", getPrincipal());
		List<Policy> policies = policyService.findAllPolicies(getPrincipal()); 
		List<Claim> claims = new ArrayList<Claim>();
		for(Policy policy: policies) {
			claims.addAll(policy.getClaims());
		}
		model.addAttribute("allpolicies", policies);
		model.addAttribute("allclaims", claims);
		return "claimsdetails";
	}

	/**
	 * This method will provide the medium to add a new claim.
	 */
	@RequestMapping(value = { "/newclaim" }, method = RequestMethod.GET)
	public String newClaim(ModelMap model) {
		Claim claim = new Claim();
		model.addAttribute("claim", claim);

		List<Policy> policies = policyService.findAllPolicies(getPrincipal()); 
		model.addAttribute("allpolicies", policies);
		
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "newclaim";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving claim in database. It also validates the user input
	 */
	@RequestMapping(value = { "/newclaim" }, method = RequestMethod.POST)
	public String saveClaim(@Valid Claim claim, BindingResult result,
			ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		if (result.hasErrors()) {
			return "newclaim";
		}
		
		claimService.save(claim);

		model.addAttribute("success", "claim registered successfully");
		return "redirect:/allclaims";
	}

	/**
	 * This method will provide the medium to add a new claim.
	 */
	@RequestMapping(value = { "/newpolicy" }, method = RequestMethod.GET)
	public String newPolicy(ModelMap model) {
		Policy policy = new Policy();
		model.addAttribute("policy", policy);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "newpolicy";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving claim in database. It also validates the user input
	 */
	@RequestMapping(value = { "/newpolicy" }, method = RequestMethod.POST)
	public String savePolicy(@Valid Policy policy, BindingResult result,
			ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		if (result.hasErrors()) {
			return "newpolicy";
		}
		
		policyService.save(policy);

		model.addAttribute("success", "policy registered successfully");
		return "redirect:/allpolicies";
	}
	

	private String activeClaims(List<Claim> claims) {
		Integer activeClaims = 0; 
		for(Claim claim:claims) {
			if(claim.getStatus().equalsIgnoreCase("settled") || claim.getStatus().equalsIgnoreCase("settled")) {
				
			}else {
				activeClaims++;
			}
		}
		return activeClaims.toString();
	}

	private String activePolicies(List<Policy> policies) {
		Integer activePolicies = 0; 
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		for(Policy policy:policies) {
			if(policy.getPolicyEndDate().before(date)) {
				
			}else {
				activePolicies++;
			}
		}
		return activePolicies.toString();
	}
	
	@RequestMapping(value = { "/payment-{policyIdNumber}" }, method = RequestMethod.GET)
	public String paymentPage(@Valid Policy policy, BindingResult result,
			ModelMap model, @PathVariable String policyIdNumber) {
		model.addAttribute("loggedinuser", getPrincipal());
		if(policyIdNumber != null & policyIdNumber.trim().length() > 0) {
			List<Policy> policies = new ArrayList<>();
			if(policyIdNumber.equalsIgnoreCase("all")) {
				policies = policyService.findAllPolicies(getPrincipal());
			}else {
				int policyNumber;
				try {
					policyNumber = Integer.parseInt(policyIdNumber);
				}catch(Exception e) {
					return "redirect:/list";
				}
				Policy policyDetails = policyService.findById(policyNumber);
				policies.add(policyDetails);
			}
		model.addAttribute("policies", policies);
		model.addAttribute("loggedinuser", getPrincipal());
		return "paymentpage";
		}
		else {
			return "redirect:/list";
		}
	}
		
	
}