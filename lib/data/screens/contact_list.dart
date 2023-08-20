import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box_tut/controllers/user_controller/user_cubit.dart';
import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/screens/add_category.dart';
import 'package:object_box_tut/data/screens/add_contact.dart';
import 'package:object_box_tut/data/screens/router/router.dart';
import 'package:object_box_tut/data/screens/search_screen.dart';
import 'package:object_box_tut/data/screens/widget/contacts_tile.dart';
import 'package:object_box_tut/utils/app_color.dart';

class ContactList extends StatefulWidget {
  static const String route = '/contactList';
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late UserCubit _userCubit;
  List<String> drawerList = ['Add Category', 'Add Contact'];
  List<String> routeList = [
    AddCategory.route,
    AddContact.route,
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userCubit.getAllContacts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          title:
              const Text("Contact List", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  AppRouter.goToNextPage(context, SearchScreen.route);
                },
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: Drawer(
          backgroundColor: AppColor.scaffoldBg,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      AppRouter.goToNextPage(context, routeList[index])
                          .then((value) {
                        _userCubit.getAllContacts();
                      });
                    },
                    child: ListTile(
                      title: Text(
                        drawerList[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: AppColor.scaffoldDevider),
                itemCount: 2),
          ),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is DeleteContactSuccess) {
              _userCubit.getAllContacts();
            }
          },
          builder: (context, state) {
            if (state is GetAllContactsState) {
              if (state.data.isEmpty) {
                return const Center(
                  child: Text('Please Add contacts'),
                );
              } else {
                List<User> contacts = state.data;
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        contacts.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ContactTile(
                                  user: contacts[index],
                                  id: (id) {
                                    _userCubit.deleteContact(id: id);
                                  }),
                            )),
                  ),
                );
              }
            }
            return Container();
          },
        ));
  }
}
