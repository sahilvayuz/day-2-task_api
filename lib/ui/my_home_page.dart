import 'dart:developer';

import 'package:day_2/apis/product_api.dart';
import 'package:day_2/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

late ProductApiService controller;


@override
  void initState() {
    controller = Provider.of(context,listen: false);

  getProduts();
    // TODO: implement initState
    super.initState();
  }
  getProduts()async{
    await controller.fetchProducts();
  }


  @override
  Widget build(BuildContext context) {

controller= context.watch<ProductApiService>();


    return Scaffold(
      appBar: AppBar( title: Text("Api Tesponce"),
      backgroundColor: Colors.blue,
      ),
      body:SafeArea(
        child: controller.loading?Center(child: CircularProgressIndicator()): Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (context, ind){
              log("items counts: ${controller.productList.length}");
          
              List<Products> productModelList=controller.productList;
          
              return productModelList.isEmpty? CircularProgressIndicator() :
          
          
          

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                 decoration: BoxDecoration(
              
              color: Color.fromARGB(255, 243, 242, 242), // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0), // Border color
                width: 2, // Border width
              ),
                 ),
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                
                      Image.network("${productModelList[ind].thumbnail}"),

                      SizedBox(height:  10,),




                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${productModelList[ind].title}"),
                             Text("brand: ${productModelList[ind].brand}"),
                          ],),
                      ),






                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(
                            children: [
                             Icon(Icons.star, color: Color.fromARGB(255, 248, 202, 0),),
                              Text("${productModelList[ind].rating}"),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Text(" \$ ${productModelList[ind].price}"),
                          ],
                          ),
                      ),






                        SizedBox(height: 5,),
                        Text(" ${productModelList[ind].description}"),



                
                
                    ]),
                ),
              );
          
            }),
        ),
      )
    );


  }
}