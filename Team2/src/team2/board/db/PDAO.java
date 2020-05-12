package team2.board.db;

import java.util.ArrayList;
import java.util.List;

import team2.animal.db.AnimalDTO;
import team2.goods.db.GoodsDTO;

public class PDAO {
	
	public static List<ProductDTO> getProduct(List<GoodsDTO> gList, List<AnimalDTO> aList){
		List<ProductDTO> list = new ArrayList<>();
		ProductDTO pdto = null;
		if(gList!=null && gList.size()>0){
			for(GoodsDTO dto:gList){
				pdto = new ProductDTO(dto.getG_code());
				list.add(pdto);
			}
		}
		if(aList!=null && aList.size()>0){
			for(AnimalDTO dto : aList){
				pdto = new ProductDTO(dto.getA_code());
				list.add(pdto);
			}
		}
		return list;
	}
	
	public static List<ProductDTO> getProduct(List<ProductDTO>... lists){
		
		List<ProductDTO> result = new ArrayList<>();
		
		for(List<ProductDTO> list : lists){
			result.addAll(list);
		}
		
		return result;
	}
	
}
