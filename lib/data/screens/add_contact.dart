import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box_tut/controllers/category_controoler/category_cubit.dart';
import 'package:object_box_tut/controllers/user_controller/user_cubit.dart';
import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/data/screens/router/router.dart';
import 'package:object_box_tut/data/screens/widget/common_dropdown.dart';
import 'package:object_box_tut/data/screens/widget/image_pick.dart';
import 'package:object_box_tut/utils/app_color.dart';

class AddContact extends StatefulWidget {
  static const String route = 'addContact';

  final Uint8List? strBase64Image;
  final int? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? category;
  final int? id;

  const AddContact(
      {super.key,
      required this.strBase64Image,
      required this.phoneNumber,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.category,
      required this.id});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late UserCubit _userCubit;
  late CategoryCubit _categoryCubit;
  late Uint8List strBase64Image;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  String category = '';

  @override
  void initState() {
    _init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _categoryCubit.getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userCubit = BlocProvider.of<UserCubit>(context);
    _categoryCubit = BlocProvider.of<CategoryCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: widget.id != null
            ? const Text(
                'Edit Contact',
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                'Add Contact',
                style: TextStyle(color: Colors.white),
              ),
        centerTitle: true,
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SaveContactSuccess) {
            AppRouter.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              ImagePeak(
                  image: widget.strBase64Image,
                  loadImage: (image) {
                    strBase64Image = image;
                  }),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.appBarColor),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "First Name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.appBarColor),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Last Name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.appBarColor),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.appBarColor),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is GetAllCategory) {
                    List<Categories> catItems = state.data;
                    return CommonDropDown<Categories>(
                        items: catItems,
                        onSelected: (val) {
                          category = val.category;
                        },
                        hintText: 'Select a category');
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: AppColor.appBarColor,
                  onPressed: () {
                    save();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20))
            ],
          ),
        ),
      ),
    );
  }

  _init() {
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    if (widget.firstName != null) {
      phoneNumberController.text = widget.phoneNumber!.toString();
      emailController.text = widget.email!;
      firstNameController.text = widget.firstName!;
      lastNameController.text = widget.lastName!;
      strBase64Image = widget.strBase64Image!;
      category = widget.category!;
    }
  }

  save() {
    if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone Number is required')));
      return;
    }
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone Number is required')));
      return;
    }
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone Number is required')));
      return;
    }
    if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone Number is required')));
      return;
    }
    if (strBase64Image.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image is required')));
      return;
    }
    if (category.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('category is required')));
      return;
    }
    if (widget.id != null) {
      _userCubit.saveContacts(
          user: User(
              image: strBase64Image,
              category: category,
              email: emailController.text.trim(),
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              mobileNumber: int.parse(phoneNumberController.text.trim()),
              id: widget.id!));
    } else {
      _userCubit.saveContacts(
          user: User(
        image: strBase64Image,
        category: category,
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        mobileNumber: int.parse(phoneNumberController.text.trim()),
      ));
    }
  }
}
