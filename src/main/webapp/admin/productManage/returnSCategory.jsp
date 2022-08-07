<%@page import="category.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>


<%
	int lno = Integer.parseInt(request.getParameter("lno"));

	CategoryDao cdao = CategoryDao.getInstance();
	ArrayList<CategoryBean> scateList = cdao.getOnlySmallCategory(lno);
	
	JSONObject jsonList = new JSONObject();
	JSONArray itemList = new JSONArray();
	
	for(CategoryBean cbean : scateList){
		JSONObject tempJson = new JSONObject();
		tempJson.put("sno", cbean.getSno());
		tempJson.put("sname", cbean.getSname());
		itemList.add(tempJson);
	}
	
	jsonList.put("ITEMS", itemList);
	out.print(jsonList);
	//System.out.println(jsonList);
%>