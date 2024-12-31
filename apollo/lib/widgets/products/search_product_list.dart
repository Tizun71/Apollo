import 'package:apollo/screens/productdetailpage.dart';
import 'package:apollo/provirders/productProvider.dart';
import 'package:apollo/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProductList extends StatefulWidget {
  final String? searchValue;
  const SearchProductList({super.key, this.searchValue});

  @override
  State<SearchProductList> createState() => _SearchProductListState();
}

class _SearchProductListState extends State<SearchProductList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(0, 0, widget.searchValue ?? '', null, 'desc');
    });
  }

  @override
  void didUpdateWidget(covariant SearchProductList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchValue != oldWidget.searchValue) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(0, 0, widget.searchValue ?? '', null, 'desc');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Consumer<ProductProvider>(builder: (context, value, child) {
      return GridView.count(
        padding: EdgeInsets.all(8),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: value.products.asMap().entries.map((e) {
          var product = e.value;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product)));
                },
                child: ProductCard(
                  item: product,
                  size: size,
                )),
          );
        }).toList(),
      );
    }));
  }
}
