import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shopping_adminpage/models/httpExecption.dart';
class OrderItem{
  final String id;
  final String productId;
  final DateTime dateTime;
  final double price;
  final List<CartItem> products;
  String orderConfirmed;
  final String address;
  final String name;
  final String city;
  final String zipCode;
  final String landMark;
  final String phoneNumber;
  OrderItem({@required this.price,@required this.id,@required this.products,@required this.dateTime,
    this.orderConfirmed="Checking",this.productId,this.landMark,this.city,this.zipCode,this.phoneNumber,this.address,this.name
  });

}
class CartItem{
  final String tittle;
  final String id;
  final int quanity;
  final double price;
  final String imageUrl;
  CartItem({
    @required this.tittle,
    @required this.id,
    @required this.price,
    @required this.quanity,
    this.imageUrl,
  }
      );
}
class Orders with ChangeNotifier{
  List<OrderItem>_items=[];
  List<OrderItem> get items{
    return[..._items];
  }
  Future<void>fetchItems()async{

    List <OrderItem>loading=[];
    Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//orders.json");
    var responseData=await http.get(url);
    final datas=json.decode(responseData.body) as Map<String,dynamic>;
    if(datas==null){
      return;
    }
    try{
      datas.forEach((key, value) {
        loading.add(OrderItem(price: value["price"], id: key,orderConfirmed: value["orderConfirmed"],address:value["address"],city:value["city"],
            landMark:value["landMark"],name:value["name"],phoneNumber:value["phoneNumber"],zipCode:value["zipCode"],productId: value["productId"], products: (value["products"]as List<dynamic>).map((e) =>
                CartItem(tittle: e["tittle"], id: e["id"], price: e["price"], quanity: e["quanity"],imageUrl: e["imageUrl"])).toList(), dateTime: DateTime.parse(value["DateTime"])));
      });

    }catch(error){
      print(error);
    }

    _items=loading.reversed.toList();
    notifyListeners();


  }
  OrderItem getProduct(String id){
    return _items.firstWhere((element) => element.id==id);


  }
  Future <void>updateItem( String id,String productid)async{
    Uri url=Uri.parse("https://shoppingproject-ec2a6-default-rtdb.firebaseio.com/Orders/$productid.json");
    Uri url1=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//orders/$id.json");
    await http.patch(url,body: json.encode({
      "orderConfirmed":"conformed",

    }));
    await http.patch(url1,body: json.encode({
      "orderConfirmed":"conformed",

    }));
    var index=_items.indexWhere((element) => element.id==id);
    _items[index].orderConfirmed="conformed";
    notifyListeners();


  }
  Future<void> deletingItem(String id)async{
    Uri url=Uri.parse("https://admin-second-ad1eb-default-rtdb.firebaseio.com//orders/$id.json");
    var deletinfIndex=_items.indexWhere((element) => element.id==id);
    var deletingItem=_items[deletinfIndex];
    items.removeAt(deletinfIndex);
    notifyListeners();

      final statusCode=await http.delete(url);
      if(statusCode.statusCode>=400){
        items.insert(deletinfIndex, deletingItem);
        notifyListeners();
        HttpException("is message is deleted");
      }
      deletingItem=null;
  }

}