import 'package:apollo/screens/productdetailpage.dart';
import 'package:apollo/utils/productProvider.dart';
import 'package:apollo/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final formatCurrency = NumberFormat("#,##0", "vi_VN");

class LatestProductList extends StatefulWidget {
  const LatestProductList({super.key});

  @override
  State<LatestProductList> createState() => _LatestProductListState();
}

class _LatestProductListState extends State<LatestProductList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(1, 4, '', null, 'desc');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            children: value.products.asMap().entries.map((e) {
              int index = e.key;
              var product = e.value;
              return Padding(
                padding: index == 0
                    ? EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailPage(product: product)));
                  },
                  child: ProductCard(item: product, size: size),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
