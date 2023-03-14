import 'package:flutter/material.dart';
import 'package:object_box_tut/data/local_db/add_contact_db.dart';
import 'package:object_box_tut/data/screens/add_contact.dart';
import 'package:object_box_tut/data/screens/router/router.dart';

class ContactTile extends StatefulWidget {
  final User user;
  final Function(int) id;
  const ContactTile({super.key, required this.user, required this.id});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 70,
        width: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(180),
          child: Image.memory(widget.user.image, fit: BoxFit.fill),
        ),
      ),
      title: Text(widget.user.firstName),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              AppRouter.goToNextPage(context, AddContact.route, arguments: {
                'category': widget.user.category,
                'strBase64Image': widget.user.image,
                'phoneNumber': widget.user.mobileNumber,
                'email': widget.user.email,
                'firstName': widget.user.firstName,
                'lastName': widget.user.lastName,
                'id': widget.user.id,
              });
            },
            child: const Image(image: AssetImage('assets/mipmap/edit.png')),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: widget.id(widget.user.id),
            child: const Image(image: AssetImage('assets/mipmap/delete.png')),
          ),
        ],
      ),
    );
  }
}
