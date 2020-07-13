import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercoffee/src/provider/categories_provider.dart';
import 'package:fluttercoffee/src/util/router_path.dart';
import 'package:fluttercoffee/src/util/shimmer.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('vo');
    Provider.of<CategoriesProvider>(context,listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Consumer<CategoriesProvider>(
          builder: (BuildContext context, CategoriesProvider value, Widget child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: value.listCategories.length,
              itemBuilder: (BuildContext context, int index) {
                print('aaaaaaaaaaa'+ value.listCategories[index].image);
                return value.isLoading ? ShimmerList() : Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, DetailCategoriesPagee,arguments: value.listCategories[index].name);
                    },
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 200,
                          imageUrl: value.listCategories[index].image,
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
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(value.listCategories[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26
                                  ),),
                                Text(
                                  value.listCategories[index].des,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }
}
