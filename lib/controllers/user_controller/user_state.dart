part of 'user_cubit.dart';
@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetAllContactsState extends UserState {
  final List<User> data;
  GetAllContactsState({required this.data});
}
class GetContactsByName extends UserState {
  final List<User> data;
  GetContactsByName({required this.data});
}
class GetContactsByNo extends UserState {
  final List<User> data;
  GetContactsByNo({required this.data});
}

class SaveContactSuccess extends UserState {}
class DeleteContactSuccess extends UserState {}
