import 'package:apollo/entity/collection.dart';
import 'package:flutter/material.dart';

class FeatureCollection extends StatelessWidget {
  final Collection items;
  final Size size;
  const FeatureCollection({super.key, required this.items, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(items.image),
            ),
          ),
          height: size.height * 0.25,
          width: size.width * 0.8,
        ),
        SizedBox(height: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${items.name}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.4,
              child: MaterialButton(
                onPressed: () {},
                color: Colors.amber,
                child: Text(
                  "XEM BỘ SƯU TẬP",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
