import 'package:flutter/material.dart';
import 'package:shopping_adminpage/provider/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shopping_adminpage/widget/individualScreen.dart';
class OrderDetails extends StatelessWidget {
  static const routerName="/router name";

  @override
  Widget build(BuildContext context) {
  final products=ModalRoute.of(context).settings.arguments as String;
  final item=Provider.of<Orders>(context).getProduct(products);
  void tableRow(String one){




  }

    return Scaffold(
      appBar: AppBar(),
      body:Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
             Color(0xffe7f0fd ),
              Color(0xffe6e9f0 ),
              Color(0xffeef1f5 ),
              Color(0xffe2ebf0 )
            ],
          ),
        ),

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),

              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),

              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Created",style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,

                        ),),
                        Text(DateFormat("EE-dd-mm-yyyy").format(item.dateTime),style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600

                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total",style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,

                        ),),
                        Text(item.price.toString(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600

                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quanity",style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,

                        ),),
                        Text("x ${item.products.length}",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600

                        ),),
                      ],
                    ),
                   ListView.builder(shrinkWrap:true,physics: ClampingScrollPhysics(),itemBuilder: (ctx,i)=>IndividualOrder(items: item.products[i],),itemCount: item.products.length,)



                  ],
                ),
              ),

            ),

            SizedBox(height: 20,),


            Container(
              padding: EdgeInsets.only(left: 20,top: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              height: MediaQuery.of(context).size.height/2.7,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                      Text(" Order Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Name",style: TextStyle(color: Colors.blueGrey,fontSize: 17,),),
                    SizedBox(
                      height: 5,
                    ),
                    Text(item.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),),
                    SizedBox(
                      height: 10,
                    ),

                    Text("Shiiping Address",style: TextStyle(color: Colors.blueGrey,fontSize: 17,),),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 200,
                      child: Text(item.address,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Place",style: TextStyle(color: Colors.blueGrey,fontSize: 17,)),
                    SizedBox(
                      height: 5,
                    ),

                    Text(item.city,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("PhoneNumber",style: TextStyle(color: Colors.blueGrey,fontSize: 17,)),
                    SizedBox(
                      height: 5,
                    ),

                    Text(item.phoneNumber,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("PinCode",style: TextStyle(color: Colors.blueGrey,fontSize: 17,)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(item.zipCode,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("LandMark",style: TextStyle(color: Colors.blueGrey,fontSize: 17,)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(item.landMark,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,letterSpacing:.3,height: 1.6),),




                  ],
                ),
              ),
            )



          ],
        ),
      ),
      bottomNavigationBar:Consumer<Orders>(builder: (ctx,order,child){
        return
          Container(
            margin: EdgeInsets.only(left: 50,right: 50),
            child: FlatButton(
              color: item.orderConfirmed=="Checking"?Colors.red:Colors.blue,

              onPressed: (){
                order.updateItem(item.id,item.productId);
                // ignore: missing_return

              },
              child: Text("Conform",style: TextStyle(color: Colors.white),),

            ),
          );


      })

    );
  }
}
