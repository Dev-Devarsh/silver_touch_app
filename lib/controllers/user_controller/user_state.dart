part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class GetAllContacts extends UserState {
  final List<User> data;
  GetAllContacts({required this.data});
}

class SaveContactSuccess extends UserState {}
class DeleteContactSuccess extends UserState {}
