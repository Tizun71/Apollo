import 'package:apollo/entity/categoryModel.dart';
import 'package:apollo/utils/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<CategoryProvider>(builder: (context, value, child) {
        return Row(
          children: value.categories.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: categoryItem(e),
            );
          }).toList(),
        );
      }),
    );
  }

  Widget categoryItem(CategoryModel category) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(category.photoLink ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            category.name ?? '',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
