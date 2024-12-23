// import 'package:apollo/entity/product.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// final formatCurrency = NumberFormat("#,##0", "vi_VN");

// class LatestProduct extends StatelessWidget {
//   final Product items;
//   final Size size;
//   const LatestProduct({super.key, required this.items, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(items.image),
//             ),
//           ),
//           height: size.height * 0.25,
//           width: size.width * 0.5,
//           child: Padding(
//             padding: EdgeInsets.all(12),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 80,
//                 height: 25,
//                 decoration:
//                     BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
//                 child: Text(
//                   "10% OFF",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 7),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               items.name,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 11),
//             ),
//             Row(
//               children: [
//                 Text(
//                   "${formatCurrency.format(items.price)} VND",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   "${formatCurrency.format(items.price)} VND",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white54,
//                       decoration: TextDecoration.lineThrough,
//                       decorationColor: Colors.white54),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             SizedBox(
//               width: size.width * 0.5,
//               child: MaterialButton(
//                 onPressed: () {},
//                 color: Colors.amber,
//                 child: Text(
//                   "Thêm vào giỏ hàng",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
