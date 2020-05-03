class NewsCategoryModel {
   int totalResults;
   String status;
   List<Article> articles;

  //NewsCategoryModel({this.id, this.title, this.categoryname});

  // factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
  //   return NewsCategoryModel(
  //       id: json['id'],
  //       title: json['title'],
  //       categoryname: json['categoryname']);
  // }
}

class Article {
  final String author;
  final String title;
  String description; 
  String url; 
  String urlToImage;
  // String publishedAt; 
  String content;
  
  Article(this.author, this.title);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(json['author'], 'b');
  }
}
