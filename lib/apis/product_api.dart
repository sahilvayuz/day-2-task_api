
import 'dart:convert';
import 'dart:developer';
import 'package:day_2/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductApiService with ChangeNotifier{

  ProductModel? productModel;
    final dio = Dio();


 List <Products> productList=[];
 bool loading=false;

  Future<dynamic> fetchProducts() async {
    productList.clear();

  loading=true;
  notifyListeners();

  try {
    Response response = await Dio().get('https://dummyjson.com/products');



    if (response.statusCode == 200) {

      // Decode JSON data into a list of Product objects
      var  responseData = jsonDecode(response.toString());
      
        productModel=  ProductModel.fromJson(responseData);
        for(int i=0;i<productModel!.products!.length;i++){
           productList.add(productModel!.products![i]);
        }
        log(productList.toString());
        loading=false;
        notifyListeners();
     
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }

    
  } catch (e) {
    throw Exception('Error fetching products: $e');
  }


 notifyListeners();


}



}



