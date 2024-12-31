import 'package:apollo/services/authService.dart';
import 'package:apollo/provirders/OrderProvider.dart';
import 'package:apollo/widgets/orders/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    int? userId = await authService.getUserIdFromToken();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra, vui lòng thử lại sau.')),
      );
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<OrderProvider>(context, listen: false).getOrders(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        // scrollDirection: Axis.horizontal,
        child: Consumer<OrderProvider>(builder: (context, value, child) {
      if (value.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: value.orders.asMap().entries.map((e) {
            var order = e.value;
            return InkWell(
              onTap: () {},
              child: OrderItem(item: order, size: size),
            );
          }).toList(),
        ),
      );
    }));
  }
}
