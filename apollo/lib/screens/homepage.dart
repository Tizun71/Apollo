import 'package:apollo/entity/category.dart';
import 'package:apollo/entity/collection.dart';
import 'package:apollo/entity/product.dart';
import 'package:apollo/enums/color_codes.dart';
import 'package:apollo/widgets/feature_collection.dart';
import 'package:apollo/widgets/latest_product.dart';
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
            categoryList(),
            SizedBox(height: 20),
            Image.asset('assets/images/banner.jpg'),
            storyDescription(),
            SizedBox(height: 20),
            sectionHeading("Sản Phẩm Mới Ra Mắt", true),
            latestProductList(size),
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

  Widget categoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(categories[index].photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    categories[index].name,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  Widget latestProductList(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
      })),
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
