import 'package:objectbox/objectbox.dart';

@Entity()
class Categories {
  @Id()
  int id;
  final String category;
  Categories({this.id = 0, required this.category});

  @override
  String toString() => category;
}
