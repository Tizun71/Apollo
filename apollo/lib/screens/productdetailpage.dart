import 'package:apollo/entity/Cart.dart';
import 'package:apollo/entity/productModel.dart';
import 'package:apollo/screens/cartpage.dart';
import 'package:apollo/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatCurrency = NumberFormat("#,##0", "vi_VN");

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ShoppingCart spc = ShoppingCart();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Image.asset(
            'assets/images/logo.png',
            height: 40.0,
            width: 120.0,
            fit: BoxFit.contain,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var token = prefs.getString('jwt_token');
                    if (token == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    } else {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartPage()));
                    }
                  },
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.black12,
              height: size.height * 0.42,
              width: size.width,
              child: PageView.builder(
                  onPageChanged: (value) {},
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.network(
                          widget.product.photoLink ?? '',
                          height: size.height * 0.4,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      salePriceText(widget.product.price ?? 0,
                          widget.product.salePercentage ?? 0),
                      SizedBox(
                        width: 5,
                      ),
                      (widget.product.salePercentage ?? 0) > 0
                          ? Text(
                              "${formatCurrency.format(widget.product.price ?? 0)} VND",
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
                  Text(
                    widget.product.description ?? '',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            spc.addItemInCart(widget.product);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Đã thêm Sản phẩm vào giỏ!"),
              backgroundColor: Colors.amber.withOpacity(0.8),
              duration: Duration(microseconds: 1000),
            ));
          },
          backgroundColor: Colors.black,
          elevation: 0,
          label: SizedBox(
              width: size.width * 0.9,
              child: Expanded(
                  child: Container(
                color: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "THÊM VÀO GIỎ HÀNG",
                      style: TextStyle(color: Colors.black, letterSpacing: -1),
                    )
                  ],
                ),
              ))),
        ));
  }

  Widget salePriceText(int price, int salePercentage) {
    double salePrice = price * (1 - salePercentage / 100);
    return Text(
      "${formatCurrency.format(salePrice)} VND",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
