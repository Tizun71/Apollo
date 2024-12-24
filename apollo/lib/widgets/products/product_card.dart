import 'package:apollo/entity/productModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat("#,##0", "vi_VN");

class ProductCard extends StatelessWidget {
  final ProductModel item;
  final Size size;
  const ProductCard({super.key, required this.item, required this.size});

  @override
  Widget build(BuildContext context) {
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
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                            decorationColor: Colors.white54,
                            fontSize: 11),
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: size.width * 0.5,
              child: MaterialButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Đã thêm Sản phẩm vào giỏ!"),
                    backgroundColor: Colors.amber.withOpacity(0.8),
                    duration: Duration(microseconds: 1000),
                  ));
                },
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
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11),
    );
  }
}
