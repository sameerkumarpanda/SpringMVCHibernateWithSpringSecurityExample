package com.springmvc.service;

import java.util.List;

import com.springmvc.model.Claim;

public interface ClaimService {

	Claim findById(int claimId);
	
	void save(Claim claim);
	
	void deleteById(int claimId);
	
	List<Claim> findAllClaims();
	
	List<Claim> findAllClaims(int policyid);
	
}
