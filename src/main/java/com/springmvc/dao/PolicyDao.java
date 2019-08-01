package com.springmvc.dao;

import java.text.ParseException;
import java.util.List;

import com.springmvc.model.Policy;

public interface PolicyDao {

	Policy findById(int policyId);
	
	void save(Policy policy);
	
	void deleteById(int policyId);
	
	List<Policy> findAllPolicies();
	
	List<Policy> findAllPolicies(String userId);
	
	int findTodayCount() throws ParseException;
}
