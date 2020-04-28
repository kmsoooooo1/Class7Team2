package team2.board.action;

public class Criteria {
	
	private int page; //currentPage 현재 페이지 정보
	private int perpageNum; //pageSize 한 페이지 당 보여줄 게시글 개수
	
	//getPageStart 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
	public int getPageStart() {
		return (page-1)*perpageNum+1;
	}
	
	public Criteria() {
		this.page = 1;
		this.perpageNum = 10;
	
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page <= 0){
			this.page = 1;
			
		} else {
			this.page = page;
		}
	}

	public int getPerpageNum() {
		return perpageNum;
	}

	public void setPerpageNum(int pageCount) {
		
		this.perpageNum = pageCount;
		
		
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perpageNum=" + perpageNum + "]";
	}
	
	
}
