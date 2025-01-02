class CategoryModel {
  int? id;
  String? name;
  String? photoLink;

  CategoryModel({this.id, this.name, this.photoLink});

  factory CategoryModel.fromJson(Map<String, dynamic> obj) {
    return CategoryModel(
        id: obj['id'], name: obj['name'], photoLink: obj['photoLink']);
  }
}
