import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_adminpage/provider/order.dart';
import 'package:intl/intl.dart';
import 'package:shopping_adminpage/screens/fullDetailOrder.dart';

class OrderScreen extends StatelessWidget {
  final OrderItem order;
  OrderScreen(this.order);

  @override

  Widget build(BuildContext context)
  {
    final scafold=Scaffold.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Container(
        child:GestureDetector(
          onTap:(){
            Navigator.of(context).pushNamed(OrderDetails.routerName,arguments:order.id);
          } ,
          child: Card(
            elevation: 10,
            child: ListTile(
              title: Text(order.price.toString(),style: TextStyle(fontSize: 16,color: Colors.red),),
              leading:Text( DateFormat("EE-dd-MM-yyyy").format(order.dateTime),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              trailing: Container(
                width: 148,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: 100,
                      height: 30,

                      decoration: BoxDecoration(
                          color: order.orderConfirmed=="Checking"?Colors.red:Colors.lightBlue[300],
                          borderRadius: BorderRadius.all(Radius.circular(13))
                      ),
                      child: Center(child: Text("${order.orderConfirmed}",textAlign: TextAlign.center,style: TextStyle(

                          fontSize: 15,
                          color:Colors.white,
                      ),)),
                    ),
                    IconButton(icon: Icon(Icons.delete), onPressed: ()async{
                      if(order.orderConfirmed=="Checking"){
                        scafold.showSnackBar(SnackBar(content: Text("this order is not conform")));
                      }else{
                        await Provider.of<Orders>(context,listen: false).deletingItem(order.id);
                      }


                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );


  }
}
