import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  final String firstName;
  final String lastName;
  final String email;
  final int mobileNumber;
  final String category;
  final Uint8List image;
  User(
      {this.id = 0,
      required this.mobileNumber,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.category,
      required this.image
      });
}
