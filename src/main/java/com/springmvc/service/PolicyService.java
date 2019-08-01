package com.springmvc.service;

import java.util.List;

import com.springmvc.model.Policy;

public interface PolicyService {

	Policy findById(int policyId);
	
	void save(Policy policy);
	
	void deleteById(int policyId);
	
	List<Policy> findAllPolicies();
	
	List<Policy> findAllPolicies(String userId);
	
}
