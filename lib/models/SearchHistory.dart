import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SearchHistory extends HiveObject {
  late List<String> searchList;
}
