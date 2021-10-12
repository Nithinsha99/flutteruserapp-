import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_adminpage/provider/order.dart';
import 'package:shopping_adminpage/screens/orderScreen.dart';
import 'package:shopping_adminpage/screens/productDetaiilScreen.dart';
class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        actions: [
          IconButton(icon: Icon(Icons.shopping_bag), onPressed: (){
            Navigator.of(context).pushNamed(UserProductScreen.routerName);

          })
        ],
      ),
      // ignore: missing_return
      body:FutureBuilder(future: Provider.of<Orders>(context).fetchItems(),builder: (ctx,connection){
        if(connection == ConnectionState.waiting){
            Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),);


        }else if(connection.error!=null){
          ///TODO TO SET tHE eRROR mESSAGE
        }else{
          return Consumer<Orders>(builder: (ctx,orders,child)=> ListView.builder(itemBuilder: (ctx,i)=>OrderScreen(orders.items[i]),itemCount: orders.items.length,),);

        }

      },)
      );
  }
}
