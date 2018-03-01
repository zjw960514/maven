package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import entity.Product;
import mapper.ProductMapper;
import service.IProductService;

@Service
public class ProductServiceImpl implements IProductService {
	@Autowired
	private ProductMapper productMapper;

	@Override
	public ServerResponse<List<Product>> pageList(Integer page, Integer limit, Product product) {
		// 1.设置分页
		PageHelper.startPage(page, limit);
		// 2、执行查询(分页之后的数据)
		List<Product> list = productMapper.pageList(product);
		// 3、得到count
		//第一种：分页时，实际返回的结果list类型是Page<T>,如果想取出分页信息，需要强制转换为Page<T>
		//Integer count = (int) ((Page) list).getTotal();
		//用PageInfo对结果进行包装
		PageInfo pageInfo = new PageInfo<>(list);
		Integer count = (int) pageInfo.getTotal();
		return ServerResponse.createSuccess("查询成功", count, list);
	}

	@Override
	public ServerResponse deleteByid(Integer id) {
		int count = productMapper.deleteByPrimaryKey(id);
		if (count > 0) {
			return ServerResponse.createSuccess("删除成功");
		}
		return ServerResponse.createError("删除失败");
	}

}
