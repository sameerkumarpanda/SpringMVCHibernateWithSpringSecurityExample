package com.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="APP_POLICY")
public class Policy implements Serializable{

	@Id 
	@Column(name="POLICYID", unique=true, nullable=false)
	private Integer policyId;

	@NotEmpty
	@Column(name="POLICYTYPE", unique=true, nullable=false)
	private String policyType;
	
	@NotNull
	@Column(name="POLICYAMOUNT", nullable=false)
	private BigDecimal policyAmount;
	
	@Column(name="RENEWALAMOUNT")
	private BigDecimal renewalAmount;

	@NotNull
	@Column(name="POLICYSTARTDATE", nullable=false)
	private Date policyStartDate;
	
	@NotNull
	@Column(name="POLICYENDDATE", nullable=false)
	private Date policyEndDate;

	
	@NotEmpty
	@Column(name="POLICYDESCRIPTION")
	private String policyDescription;
	
	@NotEmpty
	@Column(name="SSO_ID", unique=true, nullable=false)
	private String ssoId;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "POLICYID")
	private List<Claim> claims = new ArrayList<>();
	

	public Integer getPolicyId() {
		return policyId;
	}


	public void setPolicyId(Integer policyId) {
		this.policyId = policyId;
	}


	public String getPolicyType() {
		return policyType;
	}


	public void setPolicyType(String policyType) {
		this.policyType = policyType;
	}


	public BigDecimal getPolicyAmount() {
		return policyAmount;
	}


	public void setPolicyAmount(BigDecimal policyAmount) {
		this.policyAmount = policyAmount;
	}


	public BigDecimal getRenewalAmount() {
		return renewalAmount;
	}


	public void setRenewalAmount(BigDecimal renewalAmount) {
		this.renewalAmount = renewalAmount;
	}


	public Date getPolicyStartDate() {
		return policyStartDate;
	}


	public void setPolicyStartDate(Date policyStartDate) {
		this.policyStartDate = policyStartDate;
	}


	public Date getPolicyEndDate() {
		return policyEndDate;
	}


	public void setPolicyEndDate(Date policyEndDate) {
		this.policyEndDate = policyEndDate;
	}


	public String getPolicyDescription() {
		return policyDescription;
	}


	public void setPolicyDescription(String policyDescription) {
		this.policyDescription = policyDescription;
	}


	public List<Claim> getClaims() {
		return claims;
	}


	public void setClaims(List<Claim> claims) {
		this.claims = claims;
	}


	public String getSsoId() {
		return ssoId;
	}


	public void setSsoId(String ssoId) {
		this.ssoId = ssoId;
	}


	@Override
	public String toString() {
		return "Policy [policyId=" + policyId + ", policyType=" + policyType + ", policyAmount=" + policyAmount
				+ ", renewalAmount=" + renewalAmount + ", policyStartDate=" + policyStartDate + ", policyEndDate="
				+ policyEndDate + ", policyDescription=" + policyDescription + ", ssoId=" + ssoId + ", claims=" + claims
				+ "]";
	}
	
	
}
