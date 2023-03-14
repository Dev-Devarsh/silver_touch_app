import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box_tut/controllers/user_controller/user_cubit.dart';
import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/screens/add_contact.dart';
import 'package:object_box_tut/data/screens/router/router.dart';
import 'package:object_box_tut/data/screens/widget/contacts_tile.dart';
import 'package:object_box_tut/data/screens/widget/search_bar.dart';

class SearchScreen extends StatefulWidget {
  static const String route = '/searchList';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearhgScreenState();
}

class _SearhgScreenState extends State<SearchScreen> {
  TextEditingController _SearchController = TextEditingController();
  late UserCubit _userCubit;
  final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    _userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SearchBar(
            ctx: context,
            textFocusNode: _searchFocusNode,
            searchController: _SearchController,
            onChanged: (val, number) {
              number
                  ? _userCubit.getContactByNumber(val)
                  : _userCubit.getContactByName(val);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();
            },
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is GetContactsByName) {
                  if (state.data.isEmpty) {
                    return const Center(
                      child: Text('No Contacts Found'),
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
                if (state is GetContactsByName) {
                  if (state.data.isEmpty) {
                    return const Center(
                      child: Text('No Contacts Found'),
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
            ),
          )
        ],
      )),
    );
  }
}
