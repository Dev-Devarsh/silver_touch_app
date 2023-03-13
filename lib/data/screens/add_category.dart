import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box_tut/controllers/category_controoler/category_cubit.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/data/screens/widget/categoty_list.dart';
import 'package:object_box_tut/utils/app_color.dart';

class AddCategory extends StatefulWidget {
  static const String route = 'addCategory';
  const AddCategory();

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late CategoryCubit _categoryCubit;
  TextEditingController categoryController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _categoryCubit.getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _categoryCubit = BlocProvider.of<CategoryCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          'Create and store category',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocListener<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is SaveCategory) {
            _categoryCubit.getCategory();
            categoryController.text = '';
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              margin: const EdgeInsets.fromLTRB(50, 110, 50, 0),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.appBarColor),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Category",
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(
                color: AppColor.appBarColor,
                onPressed: () {
                  _categoryCubit.saveCategory(
                      Categories(category: categoryController.text.trim()));
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                )),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is GetAllCategory) {
                  List<Categories> catItems = state.data;
                  return CategoryList(
                      catItems: catItems, categoryCubit: _categoryCubit);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
