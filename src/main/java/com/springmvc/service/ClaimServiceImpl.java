package com.springmvc.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.dao.ClaimDao;
import com.springmvc.model.Claim;

@Service("claimService")
@Transactional
public class ClaimServiceImpl implements ClaimService {

	@Autowired
	private ClaimDao dao;
	
	@Override
	public Claim findById(int claimId) {
		return dao.findById(claimId);
	}

	@Override
	public void save(Claim claim) {
		claim.setClaimId(getNextId());
		dao.save(claim);

	}

	@Override
	public void deleteById(int claimId) {
		dao.deleteById(claimId);
	}

	@Override
	public List<Claim> findAllClaims() {
		return dao.findAllClaims();
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate update explicitly.
	 * Just fetch the entity from db and update it with proper values within transaction.
	 * It will be updated in db once transaction ends. 
	 */
	public void updateClaim(Claim claim) {
		Claim entity = dao.findById(claim.getClaimId());
		if(entity!=null){
			entity.setClaimType(claim.getClaimType());
			entity.setApprovedAmount(claim.getApprovedAmount());
			entity.setClaimAmount(claim.getClaimAmount());
			entity.setClaimDescription(claim.getClaimDescription());
			entity.setClaimEndDate(claim.getClaimEndDate());
			entity.setRemarks(claim.getRemarks());
			entity.setStatus(claim.getStatus());

		}
	}

	@Override
	public List<Claim> findAllClaims(int policyid) {
		return dao.findAllClaims(policyid);
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

