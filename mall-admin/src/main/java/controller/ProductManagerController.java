package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/manager/product")
public class ProductManagerController {
	@Autowired
	private IProductService productService;
	
	@RequestMapping("/pageList")
	@ResponseBody
	public ServerResponse<List<Product>> pageList(Integer page, Integer limit, Product product) {
		return productService.pageList(page, limit, product);
	}
	
	@RequestMapping("/deleteByid")
	@ResponseBody
	public ServerResponse<List<Product>> pageList(Integer id) {
		return productService.deleteByid(id);
	}
	
	
	@RequestMapping("/getProductPage")
	public String getProductPage(){
		return "product_list";
	}
}
