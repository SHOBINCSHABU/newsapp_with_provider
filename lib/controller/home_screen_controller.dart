import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp_with_provider/model/news_api_model.dart';

class HomeScreenController with ChangeNotifier {
  List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  NewApiResModel? resByCategory;
  int selectedCategoryIndex = 0;
  NewApiResModel? resModel;
  bool isLoading = false;
  Future getDataByCategory() async {
    isLoading = true;
    notifyListeners();
  Uri url = Uri.parse(
    "https://newsapi.org/v2/top-headlines?country=in&category=${categories[selectedCategoryIndex]}&apiKey=67c514ae297247f28d6bfb29c94179bc");
  var res = await http.get(url);

  if (res.statusCode == 200) {
      var decodedData = jsonDecode(res.body);
    resModel = NewApiResModel.fromJson(decodedData);
    notifyListeners();
  }else{
    print("faild");
  }
  isLoading = false;
  notifyListeners();

  onCategorySelection(int value) {
    selectedCategoryIndex = value;
    notifyListeners();
    getDataByCategory();
  }
  }
}


// Future getData(String searchQuery) async {
//     isLoading = true;
//     notifyListeners();
//   Uri url = Uri.parse(
//     "https://newsapi.org/v2/everything?q=keyword&apiKey=67c514ae297247f28d6bfb29c94179bc");
//   var res = await http.get(url);

//   if (res.statusCode == 200) {
//       var decodedData = jsonDecode(res.body);
//     resModel = NewApiResModel.fromJson(decodedData);
//     notifyListeners();
//   }else{
//     print("faild");
//   }
//   isLoading = false;
//   notifyListeners();
//   }
// }