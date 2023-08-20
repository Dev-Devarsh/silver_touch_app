import 'package:flutter/material.dart';
import 'package:object_box_tut/controllers/category_controoler/category_cubit.dart';
import 'package:object_box_tut/data/local_db/categoty_db.dart';
import 'package:object_box_tut/utils/app_color.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.catItems,
    required CategoryCubit categoryCubit,
  })  : _categoryCubit = categoryCubit,
        super(key: key);

  final List<Categories> catItems;
  final CategoryCubit _categoryCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
              catItems.length,
              (index) => Column(
                    children: [
                      Container(
                        height: 35,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        color: AppColor.categoryBg,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(catItems[index].category),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Image(image: AssetImage('assets/mipmap/edit.png')),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _categoryCubit.deleteCategory(catItems[index].id);
                                        },
                                        child: const Image(image: AssetImage('assets/mipmap/delete.png')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Divider(
                          thickness: 2,
                          height: 3,
                          color: AppColor.categoryDevider,
                        ),
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
