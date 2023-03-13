import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/data/repositories/user_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final UserRepository userRepository;

  CategoryCubit({required this.userRepository}) : super(CategoryInitial());

  void getCategory() {
    List<Categories> category = userRepository.getCategory();
    emit(GetAllCategory(data: category));
  }

  void saveCategory(Categories category) {
    userRepository.saveCategory(category: category);
    emit(SaveCategory());
  }

  void deleteCategory(int id) {
    userRepository.deleteCategory(categoryId: id);
    emit(SaveCategory());
  }
}
