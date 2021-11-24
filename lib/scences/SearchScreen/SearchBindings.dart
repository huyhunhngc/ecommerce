import 'package:dutstore/scences/SearchScreen/SearchViewModel.dart';
import 'package:dutstore/services/Network/DataService.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DataServices>(DataServices());
    Get.put<SearchViewModel>(SearchViewModel());
  }
}
