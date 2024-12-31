import 'package:apollo/entity/Cart.dart';

import 'package:apollo/services/authService.dart';
import 'package:apollo/services/orderService.dart';
import 'package:apollo/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat("#,##0", "vi_VN");

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ShoppingCartScreen(),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final OrderService orderService = OrderService();
  final AuthService authService = AuthService();
  final TextEditingController noteController = TextEditingController();
  List<CartItem> _cartItems = ShoppingCart().getCart();

  Future<void> _invokeOrder() async {
    int? userId = await authService.getUserIdFromToken();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra, vui lòng thử lại sau.')),
      );
      return;
    }
    await orderService.invokeOrder(userId, noteController.text);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return Dismissible(
                      key: Key(item.product.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _removeItem(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.product.name} đã được xóa.'),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Image.network(
                            item.product.photoLink ?? '',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          title: Text(
                            item.product.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  salePriceText(item.product.price ?? 0,
                                      item.product.salePercentage ?? 0),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  (item.product.salePercentage ?? 0) > 0
                                      ? Text(
                                          "${formatCurrency.format(item.product.price ?? 0)} VND",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white54,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.white54,
                                              fontSize: 11),
                                        )
                                      : SizedBox()
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        item.quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text(
                  'Quay về trang chủ',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tổng tiền",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    "${formatCurrency.format(ShoppingCart.getTotal())} VND",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noteController,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Thêm ghi chú vào đơn hàng của bạn",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _invokeOrder();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "ĐẶT HÀNG",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ]),
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
