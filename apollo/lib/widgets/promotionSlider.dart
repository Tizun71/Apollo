import 'package:apollo/entity/promotion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PromotionSlider extends StatelessWidget {
  const PromotionSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
      ),
      items: promotionBanners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${i.image}',
                  ),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.only(left: 27),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "${i.promotionName}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -2,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1.0
                                ..color = Colors.blue,
                            ),
                          ),
                          Text(
                            "${i.promotionName}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (i.sale != 0)
                        Row(
                          children: [
                            Text(
                              "${i.sale}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -3),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  "OFF",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      letterSpacing: -1.5,
                                      fontWeight: FontWeight.bold,
                                      height: 0.6),
                                )
                              ],
                            )
                          ],
                        ),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.black,
                        child: Text(
                          "Mua Ngay",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
