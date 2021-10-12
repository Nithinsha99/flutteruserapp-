import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_adminpage/provider/product.dart';
import 'package:shopping_adminpage/screens/editProductScreen.dart';
import 'package:shopping_adminpage/widget/userProductItem.dart';
class UserProductScreen extends StatefulWidget {

  static const routerName="/userScrenn";

  @override
  _UserProductScreenState createState() => _UserProductScreenState();
}

class _UserProductScreenState extends State<UserProductScreen> {
  var _isLoading=true;
  var _spinner=false;
  @override
  void didChangeDependencies() {
    try{
      if(_isLoading){
        setState(() {
          _spinner=true;
        });
        Provider.of<Products>(context).fetchData().then((_) {
          setState(() {
            _spinner=false;
          });
        } );
      }
      _isLoading=false;

    }catch(eroor){
      print(eroor);
    }


    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override

  Widget build(BuildContext context) {
    final products=Provider.of<Products>(context);
    return Scaffold(

        appBar: AppBar(
          title: Text("UserProductScreen"),


          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routerName);

            })
          ],
        ),
        body: _spinner?Center(child: CircularProgressIndicator(),):ListView.builder(itemBuilder: (ctx,i)=>Column(
          children: [
            UserProductItem(products.items[i].title, products.items[i].imageUrl,products.items[i].id),
            Divider(),
          ],
        ),itemCount: products.items.length,)
    );
  }
}