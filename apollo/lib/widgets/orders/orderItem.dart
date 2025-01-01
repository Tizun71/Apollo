import 'package:apollo/entity/OrderModel.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat("#,##0", "vi_VN");

class OrderItem extends StatelessWidget {
  final OrderModel item;
  final Size size;
  final Function(int) onConfirmOrder;
  const OrderItem({
    super.key,
    required this.item,
    required this.size,
    required this.onConfirmOrder,
  });

  @override
  Widget build(BuildContext context) {
    String status = "";
    Color colorBanner = Colors.grey.shade300;
    switch (item.status) {
      case -1:
        status = "Đơn hàng đã bị hủy";
        colorBanner = Colors.red;
        break;
      case 0:
        status = "Đơn hàng đang chờ shop xác nhận";
        colorBanner = Colors.orange.shade200;
        break;
      case 1:
        status = "Đơn hàng đang được vận chuyển";
        colorBanner = Colors.yellow.shade200;
        break;
      case 2:
        status = "Xác nhận nhận hàng";
        colorBanner = Colors.lime.shade200;
        break;
      case 3:
        status = "Đơn hàng hoàn thành";
        colorBanner = Colors.green.shade200;
        break;
      default:
    }

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: size.width,
            padding: EdgeInsets.all(16),
            color: colorBanner,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${item.id}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${item.createdDate}",
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("${status}"),
                ),
              ],
            ),
          ),
          // List of items
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: item.orderDetails.length,
            itemBuilder: (context, index) {
              var orderDetail = item.orderDetails[index];
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(orderDetail.photoLink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderDetail.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "x${orderDetail.quantity}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${formatCurrency.format(orderDetail.getPrice())} VND",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),

          // Footer
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ghi chú: ${item.note ?? ''}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                if (item.status == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          onConfirmOrder(item.id!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: Text(
                          "Đã nhận hàng",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${formatCurrency.format(item.amount)} VND",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
