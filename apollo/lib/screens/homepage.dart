import 'package:apollo/entity/collection.dart';
import 'package:apollo/entity/product.dart';
import 'package:apollo/configdata/color_codes.dart';
import 'package:apollo/widgets/category/category_list.dart';
import 'package:apollo/widgets/feature_collection.dart';
import 'package:apollo/widgets/products/latest_product_list.dart';
import 'package:apollo/widgets/promotionSlider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            SizedBox(height: 20),
            PromotionSlider(),
            SizedBox(height: 20),
            sectionHeading("Danh Mục Sản Phẩm", false),
            CategoryList(),
            SizedBox(height: 20),
            Image.asset('assets/images/banner.jpg'),
            storyDescription(),
            SizedBox(height: 20),
            sectionHeading("Sản Phẩm Mới Ra Mắt", true),
            LatestProductList(),
            SizedBox(height: 20),
            sectionHeading("Bộ Sưu Tập Nổi Bật!", true),
            featureCollectionList(size),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget storyDescription() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10 NĂM HÀNH TRÌNH\nCHẾ TÁC THỦ CÔNG BẠC",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Mỗi món trang sức của Apollo đều được chế tác thủ công bởi người thợ kim hoàn lành nghề, mang trọn tâm huyết và niềm đam mê trong từng nét chạm khắc tỉ mỉ.",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionHeading(
    String textValue,
    bool displaySeeAll,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textValue,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (displaySeeAll)
            Text(
              "Xem tất cả",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 0,
                color: Colors.white70,
              ),
            ),
        ],
      ),
    );
  }

  Widget featureCollectionList(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(featureCollections.length, (index) {
        final items = featureCollections[index];
        return Padding(
          padding: index == 0
              ? EdgeInsets.symmetric(horizontal: 20)
              : EdgeInsets.only(right: 20),
          child: InkWell(
              onTap: () {},
              child: FeatureCollection(
                items: items,
                size: size,
              )),
        );
      })),
    );
  }
}
