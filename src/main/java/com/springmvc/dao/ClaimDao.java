package com.springmvc.dao;

import java.text.ParseException;
import java.util.List;

import com.springmvc.model.Claim;

public interface ClaimDao {

	Claim findById(int claimId);
	
	void save(Claim claim);
	
	void deleteById(int claimId);
	
	List<Claim> findAllClaims();
	
	List<Claim> findAllClaims(int policyid);
	
	int findTodayCount() throws ParseException;
}
