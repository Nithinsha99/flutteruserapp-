import 'package:flutter/material.dart';
import 'package:shopping_adminpage/provider/product.dart';
import 'package:shopping_adminpage/screens/editProductScreen.dart';
import 'package:provider/provider.dart';


class UserProductItem extends StatelessWidget {
  final String imageurl;
  final String tittle;
  final String id;
  UserProductItem(this.tittle,this.imageurl,this.id);
  @override
  Widget build(BuildContext context) {
    final scafold=Scaffold.of(context);
    return ListTile(

      title: Text(tittle),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),radius: 30,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routerName,arguments: id);
            }),
            IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: () async{
              try{
               await Provider.of<Products>(context,listen: false).deleteItem(id);
              }catch(error){
                scafold.showSnackBar(SnackBar(content: Text("Deleting Failed !!")));
              }
             
            })

          ],
        ),
      ),
    );
  }
}
