import 'package:flutter/material.dart';
import 'package:shopping_adminpage/provider/product.dart';
import 'package:provider/provider.dart';
class EditProductScreen extends StatefulWidget {
  static const routerName="/editScreen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final priceFocusNode=FocusNode();
  final descriptionFocusNode=FocusNode();
  final imageUrlController=TextEditingController();
  final imageUrlFocusNode=FocusNode();
  final pecularitiesFocusNode=FocusNode();
  final formKey=GlobalKey<FormState>();
  var _islodaing=false;
  var editproductScreen=Product(id: null, select: "", price: 0, decription: "", imageUrl: "", title: "");
  bool dependies=true;
  var initilaVlues={
    "tittle":"",
    "imageuRL":"",
    "select":"",
    "decription":"",
    "price":"",
  };

  @override
  void initState() {
    // TODO: implement initState
    print("init");
    imageUrlController.addListener(listener);
    super.initState();
  }
  void listener(){
    if(!imageUrlFocusNode.hasFocus){
      setState(() {
      });
    }
  }

  @override
  void didChangeDependencies() {
    if(dependies){
      final productId=  ModalRoute.of(context).settings.arguments as String ;
      if(productId !=null){
        editproductScreen=Provider.of<Products>(context).findById(productId);
        print(editproductScreen.select);
        initilaVlues={
          "tittle":editproductScreen.title,
          "selct":editproductScreen.select.toString(),


          "decription":editproductScreen.decription,
          "price":editproductScreen.price.toString(),
          "imageuRL":""
        };
        imageUrlController.text=editproductScreen.imageUrl;
      }

    }
    dependies=false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  Future _saveForm() async{
    var validator=formKey.currentState.validate();
    print(validator);
    if(!validator){
      return ;
    }
    formKey.currentState.save();
    setState(() {
      _islodaing=true;
    });
    if(editproductScreen.id!=null){
      setState(() {
        _islodaing=true;
      });
      await Provider.of<Products>(context,listen: false).updateItem(editproductScreen.id, editproductScreen);

      print("check the id");
    }else{
      try{
        await Provider.of<Products>(context,listen: false).addProducts(editproductScreen);

      }catch(error){
        await showDialog(context: context, builder: (ctx)=>Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
            ),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      children: [
                        Text('Network Problem Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 5,),
                        Text('You can not add this product', style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                          color: Colors.redAccent,
                          child: Text('Okay', style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 60,
                      child: Icon(Icons.assistant_photo, color: Colors.white, size: 50,),
                    )
                ),
              ],
            )
        ),
        );


      }

    }
    setState(() {
      _islodaing=false;
    });
    Navigator.of(context).pop();


  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(listener);
    priceFocusNode.dispose();
    imageUrlController.dispose();
    descriptionFocusNode.dispose();
    pecularitiesFocusNode.dispose();  print("dispose");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed:_saveForm),
        ],
        title: Text("EditScreen "),
      ),
      /// form is used ofr the valodation valodate on the form and TextfORMfIELD HAVE MORE ATTRIBUTES AnD DECORATION FOCUSNODE IS USED FOR THE NEXTLINE FOCUS
      /// THJE DISPOSE IS USED FOR THE DATA WAS REMOVED IN THE LAST SCREEN IS ENDING
      body: _islodaing?Center(child: CircularProgressIndicator(),):Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                initialValue: initilaVlues["tittle"],
                decoration: InputDecoration(
                    labelText: "tittle"
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "enter the text";
                  }
                  return null;
                },

                onSaved: (value){
                  editproductScreen=Product(id: editproductScreen.id
                      , select: editproductScreen.select,
                      price: editproductScreen.price, decription: editproductScreen.decription, imageUrl: editproductScreen.imageUrl, title: value,isFavorite: editproductScreen.isFavorite);
                },

                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(priceFocusNode);

                },
              ),
              TextFormField(
                initialValue: initilaVlues["price"],
                decoration: InputDecoration(
                    labelText: "Price"
                ),
                keyboardType: TextInputType.number,
                onSaved: (value){
                  editproductScreen=Product(id: editproductScreen.id, select: editproductScreen.select,
                      price:double.parse(value), decription: editproductScreen.decription, imageUrl: editproductScreen.imageUrl, title: editproductScreen.title,isFavorite: editproductScreen.isFavorite);
                },
                validator: (value){
                  if(value.isEmpty){
                    return"entr the price";
                  }
                  if(double.tryParse(value)==null){
                    return "enter the valid price";
                  }
                  if(double.parse(value)<=0){
                    return"enter the graterthan 0";
                  }
                  return null;
                },

                focusNode:priceFocusNode ,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Description"
                ),
                initialValue: initilaVlues["decription"],
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(pecularitiesFocusNode);
                },
                onSaved: (value){
                  editproductScreen=Product(id: editproductScreen.id, select: editproductScreen.select,
                      price:editproductScreen.price, decription: value, imageUrl: editproductScreen.imageUrl, title: editproductScreen.title,isFavorite: editproductScreen.isFavorite);
                },
                validator: (value){
                  if(value.isEmpty){
                    return "enter the dexription";
                  }
                  if(value.length<10){
                    return "enter the more than 10 characters";
                  }
                  return null;
                },

                focusNode:descriptionFocusNode ,


              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Define Size or pecularities"
                ),
                initialValue: initilaVlues["selct"],

                focusNode: pecularitiesFocusNode ,
                onSaved: (value){
                  editproductScreen=Product(id: editproductScreen.id, select: value,isFavorite: editproductScreen.isFavorite,
                      price:editproductScreen.price, decription: editproductScreen.decription, imageUrl: editproductScreen.imageUrl, title: editproductScreen.title);
                },
                validator: (value){
                  if(value.isEmpty){
                    return"enter the properties";
                  }
                  return null;
                },

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(right: 10,top: 18),

                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: imageUrlController.text.isEmpty?Text("Enter The Url"):Image.network(imageUrlController.text),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Image url",

                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "enter the url";
                        }
                        if(!value.startsWith("https")&& !value.startsWith("http")){
                          return"enter the valid url";
                        }
                        if(!value.endsWith(".png")&&!value.endsWith(".jpeg") && !value.endsWith("jpg")){
                          return "enter the valid url";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: imageUrlController,

                      focusNode: imageUrlFocusNode,
                      onSaved: (value){
                        editproductScreen=Product(id: editproductScreen.id, select: editproductScreen.select,isFavorite: editproductScreen.isFavorite,
                            price:editproductScreen.price, decription: editproductScreen.decription, imageUrl:value, title: editproductScreen.title);
                      },

                      onFieldSubmitted: (_){
                        _saveForm();
                      },

                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
