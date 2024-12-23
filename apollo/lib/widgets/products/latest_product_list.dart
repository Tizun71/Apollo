import 'package:apollo/entity/productModel.dart';
import 'package:apollo/utils/productProvider.dart';
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
          return Row(
            children: value.products.asMap().entries.map((e) {
              int index = e.key;
              var product = e.value;
              return Padding(
                padding: index == 0
                    ? EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {},
                  child: latestProduct(product, size),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget latestProduct(ProductModel item, Size size) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(item.photoLink ?? ''),
            ),
          ),
          height: size.height * 0.25,
          width: size.width * 0.5,
          child: Padding(
              padding: EdgeInsets.all(12),
              child: (item.salePercentage ?? 0) > 0
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.red),
                        child: Text(
                          "${item.salePercentage}% OFF",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox()),
        ),
        SizedBox(height: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 11),
            ),
            Row(
              children: [
                salePriceText(item.price ?? 0, item.salePercentage ?? 0),
                SizedBox(
                  width: 5,
                ),
                (item.salePercentage ?? 0) > 0
                    ? Text(
                        "${formatCurrency.format(item.price ?? 0)} VND",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white54),
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: size.width * 0.5,
              child: MaterialButton(
                onPressed: () {},
                color: Colors.amber,
                child: Text(
                  "Thêm vào giỏ hàng",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget salePriceText(int price, int salePercentage) {
    double salePrice = price * (1 - salePercentage / 100);
    return Text(
      "${formatCurrency.format(salePrice)} VND",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
