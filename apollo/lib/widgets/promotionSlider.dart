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
        autoPlayInterval: Duration(seconds: 3),
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              padding: const EdgeInsets.only(left: 27),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BLACK FRIDAY",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -2),
                      ),
                      Row(
                        children: [
                          Text(
                            "20",
                            style: TextStyle(
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
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "OFF",
                                style: TextStyle(
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
