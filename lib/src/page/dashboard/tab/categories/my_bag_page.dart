import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercoffee/src/model/order.dart';
import 'package:fluttercoffee/src/provider/order_provider.dart';
import 'package:fluttercoffee/src/util/const.dart';
import 'package:fluttercoffee/src/util/dowloadimage.dart';
import 'package:provider/provider.dart';


class MyPage extends StatelessWidget {
  final List<Order> listOrder;

  const MyPage({Key key, this.listOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderProvider>(
      create: (BuildContext context) =>OrderProvider(),
      child: MyBagPageWidget(listOrder: listOrder,),
    );
  }
}


class MyBagPageWidget extends StatelessWidget {
  final List<Order> listOrder;

  const MyBagPageWidget({Key key, this.listOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<OrderProvider>(context,listen: true);
    double total;
    for(var i in listOrder){
      double amout = double.parse(i.menu.price);
      total = listOrder.length * amout;
    }


    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("My Bag ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            const SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 1.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listOrder.length,
              itemBuilder: (BuildContext context, int index) {
                DowloadImg.getImage('Cafe', listOrder[index].menu.image);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            child: CachedNetworkImage(
                              width: 110,
                              height: 110,
                              imageUrl: DowloadImg.downloadUrl,
                              fit: BoxFit.cover,
                              
                              progressIndicatorBuilder:
                                  (context, url,
                                  downloadProgress) =>
                                  CircularProgressIndicator(
                                      value:
                                      downloadProgress
                                          .progress),
                              errorWidget:
                                  (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(listOrder[index].menu.name),
                              const SizedBox(
                                height: 50,
                              ),
                              Text("\$${listOrder[index].menu.price}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text("1x"),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.shopping_cart,
                  color: kColorGreen),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kColorGreen,
                      ),),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("\$${total}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kColorGreen,
                        ),),

                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2.0,
                ),

              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: kColorGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text(
                          "checkout".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
