import 'package:flutter/material.dart';
import 'package:shopping_adminpage/provider/order.dart';

class IndividualOrder extends StatelessWidget {
  final CartItem items;
  IndividualOrder({this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: ListTile(

        title: Text(items.tittle),
        leading: Image.network(items.imageUrl,width: 50,),
        trailing: Container(width: 160,child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(" ${items.quanity} x ${items.price}  ",style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),),
            Text("\$ ${items.price*items.quanity}",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),


          ],
        ),),
      ),
    );


  }
}
