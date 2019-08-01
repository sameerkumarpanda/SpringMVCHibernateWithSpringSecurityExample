package com.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="APP_CLAIM")
public class Claim implements Serializable{

	@Id 
	@Column(name="CLAIMID", unique=true, nullable=false)
	private Integer claimId;

	@NotEmpty
	@Column(name="CLAIMTYPE", unique=true, nullable=false)
	private String claimType;
	
	@NotNull
	@Column(name="CLAIMAMOUNT", nullable=false)
	private BigDecimal claimAmount;
	
	@Column(name="APPROVEDAMOUNT")
	private BigDecimal approvedAmount;

	@NotNull
	@Column(name="CLAIMSTARTDATE", nullable=false)
	private Date claimStartDate;
	
	@NotNull
	@Column(name="CLAIMENDDATE", nullable=false)
	private Date claimEndDate;

	
	@NotEmpty
	@Column(name="CLAIMDESCRIPTION")
	private String claimDescription;

	@NotEmpty
	@Column(name="REMARKS")
	private String remarks;
	
	@NotEmpty
	@Column(name="STATUS", nullable=false)
	private String status;
	
	@NotNull
	@Column(name="POLICYID", nullable=false)
	private Integer policyId;
	
	public Integer getClaimId() {
		return claimId;
	}

	public void setClaimId(Integer claimId) {
		this.claimId = claimId;
	}

	public String getClaimType() {
		return claimType;
	}

	public void setClaimType(String claimType) {
		this.claimType = claimType;
	}

	public BigDecimal getClaimAmount() {
		return claimAmount;
	}

	public void setClaimAmount(BigDecimal claimAmount) {
		this.claimAmount = claimAmount;
	}

	public BigDecimal getApprovedAmount() {
		return approvedAmount;
	}

	public void setApprovedAmount(BigDecimal approvedAmount) {
		this.approvedAmount = approvedAmount;
	}

	public Date getClaimStartDate() {
		return claimStartDate;
	}

	public void setClaimStartDate(Date claimStartDate) {
		this.claimStartDate = claimStartDate;
	}

	public Date getClaimEndDate() {
		return claimEndDate;
	}

	public void setClaimEndDate(Date claimEndDate) {
		this.claimEndDate = claimEndDate;
	}

	public String getClaimDescription() {
		return claimDescription;
	}

	public void setClaimDescription(String claimDescription) {
		this.claimDescription = claimDescription;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getPolicyId() {
		return policyId;
	}

	public void setPolicyId(Integer policyId) {
		this.policyId = policyId;
	}

	@Override
	public String toString() {
		return "Claim [claimId=" + claimId + ", claimType=" + claimType + ", claimAmount=" + claimAmount
				+ ", approvedAmount=" + approvedAmount + ", claimStartDate=" + claimStartDate + ", claimEndDate="
				+ claimEndDate + ", claimDescription=" + claimDescription + ", remarks=" + remarks + ", status="
				+ status + ", policyId=" + policyId + "]";
	}


}
