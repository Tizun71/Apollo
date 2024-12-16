import 'package:apollo/entity/category.dart';
import 'package:apollo/utils/api_categories_service.dart';
import 'package:flutter/material.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  late Future<List<Category2>> lsProduct2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsProduct2 = CategoryService.getAllCategories();
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

  Widget MyList(List<Category2> ls) {
    return ListView(
      children: ls.map((e) => MyItem(e)).toList(),
    );
  }

  Widget MyItem(Category2 p) {
    return ListTile(
      title: Text(p.description),
    );
  }
}
