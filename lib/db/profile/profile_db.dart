
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stash_project/models/profile/profile_model.dart';

ProfileModel? userdata;
ValueNotifier<List<ProfileModel>> profilelistnotifier = ValueNotifier([]);
int userDbId = 0;
Future<void> addprofile(ProfileModel value) async {
  final db = await Hive.openBox<ProfileModel>('profile_Db');
  db.put(userDbId, value);

  getprofile();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  profilelistnotifier.notifyListeners();
}

Future getprofile() async {
  final db = await Hive.openBox<ProfileModel>('profile_Db');
  userdata = db.get(userDbId);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  profilelistnotifier.notifyListeners();
}
