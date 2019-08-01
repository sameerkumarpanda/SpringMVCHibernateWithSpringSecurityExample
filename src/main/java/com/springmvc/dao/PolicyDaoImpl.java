package com.springmvc.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.springmvc.model.Policy;

@Repository("policyDao")
public class PolicyDaoImpl extends AbstractDao<Integer, Policy> implements PolicyDao {

	@Override
	public Policy findById(int policyId) {
		Policy policy = getByKey(policyId);
		if(policy != null) {
			Hibernate.initialize(policy.getClaims());
		}
		return policy;
	}

	@Override
	public void save(Policy policy) {
		persist(policy);

	}

	@Override
	public void deleteById(int policyId) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("policyId", policyId));
		Policy policy = (Policy)crit.uniqueResult();
		delete(policy);
	}

	@Override
	public List<Policy> findAllPolicies() {
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("policyStartDate"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Policy> policies = (List<Policy>) criteria.list();
		for(Policy policy :policies) {
			Hibernate.initialize(policy.getClaims());
		}
		return policies;
	}

	@Override
	public List<Policy> findAllPolicies(String userId) {
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("policyStartDate"));
		criteria.add(Restrictions.eq("ssoId", userId));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Policy> policies = (List<Policy>) criteria.list();
		
		for(Policy policy :policies) {
			Hibernate.initialize(policy.getClaims());
		}
		
		return policies;
	}

	@Override
	public int findTodayCount() throws ParseException {
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-YYYY");
	    String myDate = formatter.format(date);
	    // Create date 17-04-2011 - 00h00
	    Date minDate = formatter.parse(myDate);
	    // Create date 18-04-2011 - 00h00 
	    // -> We take the 1st date and add it 1 day in millisecond thanks to a useful and not so known class
	    Date maxDate = new Date(minDate.getTime() + TimeUnit.DAYS.toMillis(1));
	    
		
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("policyStartDate"));
		criteria.add(Restrictions.ge("policyStartDate", minDate));
		criteria.add(Restrictions.le("policyStartDate", maxDate));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Policy> policies = (List<Policy>) criteria.list();
		return policies.size();
	}

	
}
