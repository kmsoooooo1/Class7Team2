function insertCommenctCheck(){
	var fr = document.fr;
	if(fr.comment.value==""){
		alert("답글 내용을 작성하세요");
		return false;
	}
	fr.submit();
}

function updateCommentCheck(cnt){
	var fr = document.updatefr[cnt];
	if(fr.comment.value==""){
		alert("답글 내용을 작성하세요");
		return false;
	}
	fr.submit();
}