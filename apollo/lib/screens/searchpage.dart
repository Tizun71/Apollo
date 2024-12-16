import 'package:apollo/entity/product.dart';
import 'package:apollo/widgets/latest_product.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            SizedBox(height: 20),
            searchSection(size, context),
            SizedBox(height: 20),
            Container(
                child: GridView.count(
              padding: EdgeInsets.all(8),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Vô hiệu hóa scroll bên trong GridView
              children: List.generate(latestProducts.length, (index) {
                final items = latestProducts[index];
                return Padding(
                  padding: index == 0
                      ? EdgeInsets.symmetric(horizontal: 20)
                      : EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {},
                      child: LatestProduct(
                        items: items,
                        size: size,
                      )),
                );
              }),
            ))
          ],
        ),
      ),
    );
  }

  Widget searchSection(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          searchBoxItem(size),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return modalBottomItem();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              height: 50,
              child: Icon(
                Icons.filter_alt,
                color: Colors.amber.withOpacity(0.6),
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBoxItem(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Colors.amber.withOpacity(0.6),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            showCursor: true,
            cursorColor: Colors.amber,
            style: TextStyle(color: Colors.amber),
            decoration: InputDecoration(
                hintText: 'Tìm kiếm mặt hàng',
                hintStyle: TextStyle(color: Colors.amber),
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          )),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget modalBottomItem() {
    return Container(
      height: 500,
      decoration: BoxDecoration(color: const Color.fromARGB(244, 0, 0, 0)),
      child: Center(
        child: Column(
          children: [Text("Danh mục")],
        ),
      ),
    );
  }
}
