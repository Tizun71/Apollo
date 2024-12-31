import 'package:apollo/widgets/products/search_product_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String value = '';
  TextEditingController _searchController = TextEditingController(text: '');
  void filterData(String searchValue) {
    setState(() {
      value = searchValue;
    });
  }

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
            SearchProductList(
              searchValue: value,
            )
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
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.filter_alt,
                color: Colors.amber.withOpacity(0.6),
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
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(15)),
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
            controller: _searchController,
            showCursor: true,
            onSubmitted: (value) {
              filterData(value);
            },
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
