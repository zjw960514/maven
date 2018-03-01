package service;

import java.util.List;

import entity.Product;

public interface IProductService {

	ServerResponse<List<Product>> pageList(Integer page, Integer limit, Product product);

	ServerResponse<List<Product>> deleteByid(Integer id);

}
