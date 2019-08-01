package com.springmvc.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.hibernate.Criteria;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.springmvc.model.Claim;

@Repository("claimDao")
public class ClaimDaoImpl extends AbstractDao<Integer, Claim> implements ClaimDao {

	@Override
	public Claim findById(int claimId) {
		Claim claim = getByKey(claimId);
		return claim;
	}

	@Override
	public void save(Claim claim) {
		persist(claim);

	}

	@Override
	public void deleteById(int claimId) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("claimId", claimId));
		Claim claim = (Claim)crit.uniqueResult();
		delete(claim);
	}

	@Override
	public List<Claim> findAllClaims() {
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("claimStartDate"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Claim> claims = (List<Claim>) criteria.list();
		
		return claims;
	}

	@Override
	public List<Claim> findAllClaims(int policyId) {
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("claimStartDate"));
		criteria.add(Restrictions.eq("policyId", policyId));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Claim> claims = (List<Claim>) criteria.list();
		
		return claims;
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
	    
		
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("claimStartDate"));
		criteria.add(Restrictions.ge("claimStartDate", minDate));
		criteria.add(Restrictions.le("claimStartDate", maxDate));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<Claim> claims = (List<Claim>) criteria.list();
		
		return claims.size();
	}

}

