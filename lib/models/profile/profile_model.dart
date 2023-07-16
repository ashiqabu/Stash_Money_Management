import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 4)
class ProfileModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String email;

  ProfileModel({
    required this.name,
    required this.email,
    required this.image,
    required this.id,
  });
}
