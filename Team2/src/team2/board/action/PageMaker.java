package team2.board.action;

public class PageMaker {
	
	private Criteria cri;
	private int totalCount; //전체 페이지 수 
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 5;
	
	//현재 페이지 번호
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
		
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		CalcData();
	}
	
	private void CalcData() {
		
		// 끝 페이지 번호 = (현재 페이지 정보 / 화면에 보여질 페이지 개수) * 화면에 보여질 페이지 개수 
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		
		// 시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 개수) + 1;
		startPage = (endPage - displayPageNum) + 1;
		if(startPage < 0) startPage = 1;
		
		
		//마지막 페이지 번호 = 총 게시글 수 / 한페이지당 보여질 페이지 개수
		int tempEndPage = (int) (Math.ceil(totalCount/ (double) cri.getPerpageNum()));		
		if(endPage>tempEndPage){
			endPage = tempEndPage;
		}
		
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerpageNum() < totalCount ? true : false;
		
		
	}
	
	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	@Override
	public String toString() {
		return "PageMaker [cri=" + cri + ", totalCount=" + totalCount + ", startPage=" + startPage + ", endPage="
				+ endPage + ", prev=" + prev + ", next=" + next + ", displayPageNum=" + displayPageNum + "]";
	}
	
	
}
