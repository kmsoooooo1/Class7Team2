package team2.board.action;

import java.io.File;
import java.util.Arrays;


public class createFileAndDir{
		  public static void main(String[] args){
		    //해당 경로에 있는 파일에 대한 정보를 담는다.
		    //객체의 인자인 문자열은 디렉토리로 파일을 생성하거나,
		    //원하는 위치의 디렉토리를 설정하면 된다.
		    File fileDir = new File("D:\\workspace_jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Team2\\upload\\board");
		    //위의 folder는 파일이 아닌 디렉토리이기 때문에
		    //.list() 함수를 사용하면 해당 디렉토리의 파일, 디렉토리 정보를 모두 볼 수 있다.
		    String fileList[] = fileDir.list();
		    Arrays.stream(fileList).forEach(System.out::println);
		  }
		}

