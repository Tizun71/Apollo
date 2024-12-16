class Category2 {
  int id;
  String name;
  String description;
  String photo;

  Category2({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  factory Category2.fromJson(Map<String, dynamic> json) {
    return Category2(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      photo: json["photo"],
    );
  }
}

List<Category2> categories = [
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
  Category2(
      id: 1,
      name: "Nhẫn bạc",
      description: "123",
      photo: "https://helios.vn/cdn/shop/files/nhan.png?v=1728462443"),
];
