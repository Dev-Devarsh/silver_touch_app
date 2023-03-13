part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class GetAllCategory extends CategoryState {
  final List<Categories> data;
  GetAllCategory({required this.data});
}

class SaveCategory extends CategoryState {
  // final Category data;
  SaveCategory();
}
