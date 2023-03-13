import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box_tut/controllers/category_controoler/category_cubit.dart';
import 'package:object_box_tut/controllers/user_controller/user_cubit.dart';
import 'package:object_box_tut/data/local_db/object_box.dart';
import 'package:object_box_tut/data/repositories/user_repo.dart';
import 'package:object_box_tut/data/screens/router/router.dart';

late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserCubit>(
      create: (context) => UserCubit(userRepository: UserRepository()),
    ),
    BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit(userRepository: UserRepository()),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      onGenerateRoute: AppRouter().onRouteGenerate,
    );
  }
}
