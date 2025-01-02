import 'package:apollo/configdata/api_address.dart';

class Promotion {
  String promotionName, image;
  int sale;
  Promotion(
      {required this.promotionName, required this.sale, required this.image});
}

List<Promotion> promotionBanners = [
  Promotion(
    promotionName: 'Mừng xuân 2025',
    sale: 50,
    image:
        "$hostAddress/api/Image/GetImage/76610273-206d-4169-ab80-a3baaf396cb1.jpg",
  ),
  Promotion(
    promotionName: 'Ra mắt bộ sưu tập mới',
    sale: 0,
    image:
        "$hostAddress/api/Image/GetImage/be3eeafe-235a-46ca-9286-72eedaae08b5.jpg",
  ),
];
