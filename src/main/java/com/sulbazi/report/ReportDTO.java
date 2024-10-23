package com.sulbazi.report;

import java.util.Date;

public class ReportDTO {
	private int report_idx;
	private String reported_id;
	private String reporting_id;
	private String report_category;
	private int reported_idx;
	private String report_content;
	private Date report_date;
	private int report_state;
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public String getReported_id() {
		return reported_id;
	}
	public void setReported_id(String reported_id) {
		this.reported_id = reported_id;
	}
	public String getReporting_id() {
		return reporting_id;
	}
	public void setReporting_id(String reporting_id) {
		this.reporting_id = reporting_id;
	}
	public String getReport_category() {
		return report_category;
	}
	public void setReport_category(String report_category) {
		this.report_category = report_category;
	}
	public int getReported_idx() {
		return reported_idx;
	}
	public void setReported_idx(int reported_idx) {
		this.reported_idx = reported_idx;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public int getReport_state() {
		return report_state;
	}
	public void setReport_state(int report_state) {
		this.report_state = report_state;
	}
}
