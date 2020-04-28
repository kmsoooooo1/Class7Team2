package team2.member.db;

import java.sql.Date;

public class MemberDTO {
	private String id;
	private String pass;
	private String name;
	private String phone;
	private String m_addr1;
	private String m_addr2;
	private String m_addr3;
	private String m_addr4;
	private String email;
	private Date regdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getM_addr1() {
		return m_addr1;
	}
	public void setM_addr1(String m_addr1) {
		this.m_addr1 = m_addr1;
	}
	public String getM_addr2() {
		return m_addr2;
	}
	public void setM_addr2(String m_addr2) {
		this.m_addr2 = m_addr2;
	}
	public String getM_addr3() {
		return m_addr3;
	}
	public void setM_addr3(String m_addr3) {
		this.m_addr3 = m_addr3;
	}
	public String getM_addr4() {
		return m_addr4;
	}
	public void setM_addr4(String m_addr4) {
		this.m_addr4 = m_addr4;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", phone=" + phone + ", m_addr1=" + m_addr1
				+ ", m_addr2=" + m_addr2 + ", m_addr3=" + m_addr3 + ", m_addr4=" + m_addr4 + ", email=" + email
				+ ", regdate=" + regdate + "]";
	}
	
}
