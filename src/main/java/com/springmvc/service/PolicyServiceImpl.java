package com.springmvc.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.dao.PolicyDao;
import com.springmvc.model.Policy;

@Service("policyService")
@Transactional
public class PolicyServiceImpl implements PolicyService {

	@Autowired
	private PolicyDao dao;
	
	@Override
	public Policy findById(int policyId) {
		return dao.findById(policyId);
	}

	@Override
	public void save(Policy policy) {
		policy.setPolicyId(getNextId());
		dao.save(policy);

	}

	@Override
	public void deleteById(int policyId) {
		dao.deleteById(policyId);
	}

	@Override
	public List<Policy> findAllPolicies() {
		return dao.findAllPolicies();
	}

	@Override
	public List<Policy> findAllPolicies(String userId) {
		return dao.findAllPolicies(userId);
	}

	private int getNextId() {
		Date date = new Date();
		SimpleDateFormat  sdf = new SimpleDateFormat("MMyydd");
		String dateFormat = sdf.format(date);
		int todayCount = 0;
		try {
			todayCount = dao.findTodayCount();
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		String formatted = String.format("%03d", todayCount);
		int nextId = Integer.parseInt(dateFormat+formatted);
		return nextId++;
	}
}
