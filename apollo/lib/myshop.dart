import 'package:apollo/entity/product2.dart';
import 'package:apollo/utils/api_service.dart';
import 'package:flutter/material.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late Future<List<Product2>> lsProduct2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsProduct2 = ApiService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: lsProduct2,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              var ls = snapShot.data!;
              return MyList(ls);
            }
          }),
    );
  }

  Widget MyList(List<Product2> ls) {
    return ListView(
      children: ls.map((e) => MyItem(e)).toList(),
    );
  }

  Widget MyItem(Product2 p) {
    return ListTile(
      title: Text(p.title),
    );
  }
}
