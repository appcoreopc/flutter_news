import 'dart:convert';

import 'package:http/http.dart' as http;
import '../appconstant.dart' as AppConstant;
import '../models/newscategorymodel.dart';

Future<List<NewsCategoryModel>> fetchNewsCategories() async {
  final response = await http.get(AppConstant.newsUrl);
  var result = List<NewsCategoryModel>();

  if (response.statusCode == 200) {
    List<NewsCategoryModel> newscategories = json.decode(response.body);
    for (var newcategory in newscategories) {
      result.add(newcategory);
    }
  }
  return result;
}
