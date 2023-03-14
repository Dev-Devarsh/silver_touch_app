import 'package:bloc/bloc.dart';
import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit({required this.userRepository}) : super(UserInitial());

  void getAllContacts() async {
    List<User> userData = userRepository.getAllContacts();
    emit(GetAllContacts(data: userData));
  }

  void getContactByName(String name) {
    List<User> userData;
    if (name.isNotEmpty) {
      userData = userRepository.getContactByName(name);
    } else {
      userData = [];
    }
    emit(GetContactsByName(data: userData));
  }

  void getContactByNumber(String name) {
    List<User> userData;
    if (name.isNotEmpty) {
      userData = userRepository.getContactByNumber(name);
    } else {
      userData = [];
    }
    emit(GetContactsByName(data: userData));
  }

  void saveContacts({required User user}) async {
   await userRepository.saveContacts(user: user);
    emit(SaveContactSuccess());
  }

  void deleteContact({required int id}) async {
    userRepository.deleContact(id);
    emit(DeleteContactSuccess());
  }
}
