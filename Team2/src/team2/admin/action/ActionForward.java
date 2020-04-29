package team2.admin.action;

public class ActionForward {
	//	페이지 이동마다 이동정보를 저장하는 객체
	//	이동할 페이지 주소, 이동할 방식 결정
	
	private String path;		//	이동할 페이지 주소
	private boolean isRedirect;	//	이동할 방삭
	//	true -> sendRedirect 이동		>>	주소창 정보 변경
	//	false-> forward 이동			>>	주소창 변경X
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
}
