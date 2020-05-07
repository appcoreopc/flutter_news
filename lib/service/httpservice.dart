import 'dart:convert';

import 'package:http/http.dart' as http;
import '../appconstant.dart' as AppConstant;
import '../models/newscategorymodel.dart';

class NewsDataService {
  Future<List<Article>> fetchNewsCategories() async {
    
    final response = await http.get(AppConstant.newsUrl);
    var result = List<Article>();

    if (response.statusCode == 200) {
      var newscategories = json.decode(response.body);
      var articles = newscategories['articles'];
      for (var article in articles) {

        result.add(Article(article['author'], article['title'], article['description'], article['content'], article['urlToImage'], article['url']));
      }
    }
    return result;
  }
}

