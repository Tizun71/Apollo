class OrderModel {
  int? id;
  String? createdDate;
  int? status;
  int? amount;
  String? note;
  List<OrderDetail> orderDetails;

  OrderModel(
      {this.id,
      this.createdDate,
      this.status,
      this.amount,
      this.note,
      required this.orderDetails});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var list = json['orderDetails'] as List;
    List<OrderDetail> detailsList =
        list.map((i) => OrderDetail.fromJson(i)).toList();

    return OrderModel(
      id: json['orderID'],
      createdDate: json['createdDate'],
      status: json['status'],
      amount: json['amount'],
      note: json['note'],
      orderDetails: detailsList,
    );
  }
}

class OrderDetail {
  String photoLink;
  String productName;
  int quantity;
  int productPrice;

  OrderDetail({
    required this.photoLink,
    required this.productName,
    required this.quantity,
    required this.productPrice,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      photoLink: json['photoLink'],
      productName: json['productName'],
      quantity: json['quantity'],
      productPrice: json['productPrice'],
    );
  }

  int getPrice() {
    return productPrice * quantity;
  }
}
