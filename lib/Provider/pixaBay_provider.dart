import 'package:flutter/foundation.dart';
import '../Modal/pixaBay_modal.dart';
import '../api_helper.dart';

class SearchProvider extends ChangeNotifier
{
  Helper helper = Helper();
  SearchModal? searchModal;
  String search = '';

  void searchImg(String img)
  {
    search = img;
    notifyListeners();
  }

  Future<SearchModal?> fromMap(String img)
  async {
    final data = await helper.fetchApiData(img);
    searchModal = SearchModal.fromJson(data);
    return searchModal;
  }

}
