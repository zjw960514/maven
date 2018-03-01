<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title> - 商品列表</title>
</head>
<body>
	<div class="demoTable">
		  搜索ID：
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="searchName" autocomplete="off">
		  </div>
		  子标题：
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="searchsubtitle" autocomplete="off">
		  </div>
		  <button class="layui-btn" data-type="reload">搜索</button>
	</div>
	<table class="layui-hide" id="dataGrid" lay-fiter="dataGrid"></table>
	<script type="text/html" id="toolbar">
  		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  		<a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<script>
	layui.use('table', function(){
	  var table = layui.table;
	  
	  table.render({
	    elem: '#dataGrid',//绑定要渲染的表格
	    url:'${ctx}/manager/product/pageList.action',//进行异步请求的地址
	    cellMinWidth:80,//列宽自动分配
	    cols: [[
			{field:'id', title: 'ID', sort: true},
			{field:'name', title: '名称', sort: true},
			{field:'subtitle', title: '标题', sort: true},
			{field:'mainImage', title: '商品主图', templet: '#imgTpl'},
			{field:'price', title: '价格', sort: true},
			{field:'stock', title: '库存', sort: true},
			{field:'status', title: '状态', sort: true},
			{field:'createTime', title: '创建时间', sort: true},
			{fixed: 'right', width : 170, toolbar: '#toolbar'} //这里的toolbar值是模板元素的选择器
	    ]],
	     id:'listReload',
	     page: true 
	  });
	  active = {
		    reload: function(){
		      var demoReload = $('#searchName');
		      var demoReload = $('#searchsubtitle');
		      //执行多条件搜索重载数据表格
		      table.reload('listReload', {
		    	  where: {//设定一部数据接口的额外参数，可以进行随意的设置
		    		  name : $('#searchName').val(),
		    		  subtitle : $('#searchsubtitle').val(),
			        },
		        page: {
		          curr: 1 //重新从第 1 页开始
		        }
		      });
		    }
		  };
	  	
		//监听工具条
		  table.on('tool(dataGrid)', function(obj){ //注：tool是工具条事件名，dataGrid是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data; //获得当前行数据
		    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		    var tr = obj.tr; //获得当前行 tr 的DOM对象
		   
		    if(layEvent === 'detail'){ //查看
		      //do somehing
		    } else if(layEvent === 'del'){ //删除
		      layer.confirm('真的删除行么', function(index){
		    	  $.ajax({
		    		  url : '${ctx}/manager/product/deleteByid.action',
		    		  date : {'id': data.id},
		    		  dataType : 'json',
		    		  success : function(jsonData){
		    			  if(jsonData.code == util.SUCCESSS){
		    				  mylayer.success("删除成功");
		    				  active.reload();
		    			  }else{
		    				  mylayer.success("删除成功");
		    			  }
		    			  maylayer.close(index);
		    		  }
		    	  });
		      });
		    } else if(layEvent === 'edit'){ //编辑
		      //do something
		    }
		  });
	  		
	  	//触发搜索按钮的点击事件
		  $('.demoTable .layui-btn').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		  });
	});
	</script>
</body>
</html>