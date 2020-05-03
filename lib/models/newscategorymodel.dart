class NewsCategoryModel {
  final int id;
  final String title;
  final String categoryname;

  NewsCategoryModel({this.id, this.title, this.categoryname});

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewsCategoryModel(
        id: json['id'],
        title: json['title'],
        categoryname: json['categoryname']);
  }
}
