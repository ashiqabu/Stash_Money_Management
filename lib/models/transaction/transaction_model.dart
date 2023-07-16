import 'package:hive_flutter/hive_flutter.dart';
import 'package:stash_project/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TranscationModel {
  @HiveField(0)
  final String note;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
@HiveField(5)
   String? id;

  TranscationModel({
    required this.note,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }){
    id=DateTime.now().microsecondsSinceEpoch.toString();
  }
  
}
