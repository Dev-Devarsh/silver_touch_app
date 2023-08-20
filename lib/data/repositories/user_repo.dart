import 'dart:developer';

import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/main.dart';

class UserRepository {
  Future<List<User>> getAllContacts() async{
    return await objectBox.getUsers();
  }

  Future<int> saveContacts({required User user}) async {
   return await objectBox.insterUser(user);
  }

  deleContact(int id) {
    objectBox.deleteUser(id);
  }

  getContactByName(String name) {
    return objectBox.getUserByName(name);
  }

  getContactByNumber(String name) {
    return objectBox.getUserByPhoneNo(name);
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
