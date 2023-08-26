import 'dart:developer';

import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<User> _userBox;
  late final Box<Categories> _userCategory;
  ObjectBox._init(this._store) {
    _userBox = Box<User>(_store);
    _userCategory = Box<Categories>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  List<User> getUsers(){
    log("User added ${_userBox.count()}");
    log("User hashCode ${_userBox.hashCode}");
    if (!_userBox.isEmpty()) {
      return _userBox.getAll();
    } else {
      return [];
    }
  }

  User? getUser(int id) => _userBox.get(id);
  int insterUser(User user) => _userBox.put(user);
  bool deleteUser(int id) => _userBox.remove(id);

  List<User> getUserByName(String name) {
    Query<User> query = _userBox
        .query(User_.firstName.contains(name) | User_.lastName.contains(name))
        .build();
    List<User> users = query.find();
    log(users.map((e) => e.firstName).toString());
    return users;
  }

  List<User> getUserByPhoneNo(String name) {
    if (!_userBox.isEmpty()) {
      List<User> users = [];
      for (var e in _userBox.getAll()) {
        if (e.mobileNumber.toString().contains(name)) {
          users.add(e);
        }
      }
      return users;
    } else {
      return [];
    }
  }

  List<Categories> getAllCategory() {
    if (!_userCategory.isEmpty()) {
      return _userCategory.getAll();
    } else {
      return [];
    }
  }

  Categories? getCategory(int id) => _userCategory.get(id);
  int insterCategory(Categories category) => _userCategory.put(category);
  bool deleteCategory(int id) => _userCategory.remove(id);
}
