class CategoryModel {
  String? name;
  String? photoLink;

  CategoryModel({this.name, this.photoLink});

  factory CategoryModel.fromJson(Map<String, dynamic> obj) {
    return CategoryModel(name: obj['name'], photoLink: obj['photoLink']);
  }
}
