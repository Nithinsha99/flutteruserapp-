import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:provider/provider.dart';
class Product {
  final String title;
  final double price;
  final String id;
  final String imageUrl;
  final select;
  final String decription;
  bool isFavorite;
  Product({this.id,this.select,this.imageUrl,this.price,this.title,this.isFavorite=false,this.decription});

}
class Products with ChangeNotifier{
 List<Product> _item=[];
 List<Product> get items{
   return[..._item];
 }
 Future<void>addProducts(Product product)async{
   Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//products.json");
   try{
     final response=await http.post(url,body: json.encode({
       "tittle":product.title,
       "description":product.decription,
       "imageUrl":product.imageUrl,
       "price":product.price,
       "selct":product.select,
       "isfavorite":product.isFavorite,
     }));
     final newProduct=Product(id: json.decode(response.body)["name"],price: product.price,title: product.title,isFavorite: product.isFavorite,imageUrl: product.imageUrl,decription: product.decription,select: product.select);
     _item.add(newProduct);
     notifyListeners();
   }catch(error){
     print(error);
     throw error;

   }





 }
 Product findById(String id){
   return _item.firstWhere((element) => id==element.id);

 }
 Future<void> updateItem(String id,Product product) async{
   var index=_item.indexWhere((element) => element.id==id);
   Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//products/$id.json");
   try{
     await http.patch(url,body: json.encode({
       "tittle":product.title,
       "description":product.decription,
       "imageUrl":product.imageUrl,
       "price":product.price,
       "selct":product.select,
       "isfavorite":product.isFavorite,

     }));


     _item[index]=product;
     notifyListeners();

   }catch(error){
     print(error);
    throw error;
   }

 }
 Future<void> fetchData() async{
   Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//products.json");
   try{
     final response=await  http.get(url);
     final loadingProducts=json.decode(response.body)as Map<String,dynamic>;
     List<Product> loadingItem=[];
     print(loadingItem);
     if(loadingProducts==null){
       print("null");
       return;
     }
     loadingProducts.forEach((key, value) {
       loadingItem.add(Product(isFavorite:value["isfavorite"] ,id: key,select: value["selct"],imageUrl: value["imageUrl"],title: value["tittle"],price: value["price"],decription: value["description"]));
     });
     _item=loadingItem;

   }catch(error){
     throw error;
   }
   notifyListeners();



 }
 Future<void> deleteItem(String id) async{
   Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//products/$id");
   var deleteIndex=_item.indexWhere((element) => element.id==id);
   var delteingItem=_item[deleteIndex];
   _item.removeAt(deleteIndex);
   notifyListeners();
  final value=await http.delete(url);
     if(value.statusCode >=400){
       _item.insert(deleteIndex, delteingItem);
       notifyListeners();
       throw HttpException("the message ha not delted");

     }
     delteingItem=null;

 }
 // void updateItem(String productid,Product updaterProduct){
 //   final product=_item.indexWhere((element) => element.id==productid);
 //   _item[product]=updaterProduct;
 //   notifyListeners();
 // }
 // void delete(String id){
 //   _item.removeWhere((element) => element.id==id);
 //   notifyListeners();
 // }

}