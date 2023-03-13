import 'dart:developer';

import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/data/local_db/object_box.dart';
import 'package:object_box_tut/main.dart';

class UserRepository {
  List<User> getAllContacts() {
    return objectBox.getUsers();
  }

  void saveContacts({required User user}) async {
    objectBox.insterUser(user);
  }

  deleContact(int id) {
    objectBox.deleteUser(id);
  }

  List<Categories> getCategory() {
    log('message ${objectBox.getAllCategory().map((e) => e.category)}');
    return objectBox.getAllCategory();
  }

  void saveCategory({required Categories category}) {
    objectBox.insterCategory(category);
  }

  void deleteCategory({required int categoryId}) {
    objectBox.deleteCategory(categoryId);
  }
}
