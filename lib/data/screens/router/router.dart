import 'package:flutter/material.dart';
import 'package:object_box_tut/data/screens/add_category.dart';
import 'package:object_box_tut/data/screens/add_contact.dart';
import 'package:object_box_tut/data/screens/contact_list.dart';
import 'package:object_box_tut/data/screens/search_screen.dart';

class AppRouter {
  Route onRouteGenerate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactList());
      case AddContact.route:
        Map? argument = settings.arguments as Map?;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AddContact(
                  category: argument?['category'],
                  strBase64Image: argument?['strBase64Image'],
                  phoneNumber: argument?['phoneNumber'],
                  email: argument?['email'],
                  firstName: argument?['firstName'],
                  lastName: argument?['lastName'],
                  id: argument?['id'],
                ));
      case ContactList.route:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactList());
      case AddCategory.route:
        //  Map argument = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings, builder: (_) => AddCategory());
      case SearchScreen.route:
        //  Map argument = settings.arguments as Map;
        return MaterialPageRoute(
            settings: settings, builder: (_) => SearchScreen());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactList());
    }
  }

  static Future goToNextPage(BuildContext context, String s,
      {Map? arguments}) async {
    return await Navigator.pushNamed(context, s, arguments: arguments);
  }

  static pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static pushReplacement(BuildContext context, String routeName,
      {Map? arguments}) {
    // Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  static popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == routeName;
      },
    );
  }
}
