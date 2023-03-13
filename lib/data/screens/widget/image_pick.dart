import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:object_box_tut/data/screens/router/router.dart';
import 'package:path_provider/path_provider.dart';

class ImagePeak extends StatefulWidget {
  Function(Uint8List) loadImage;
  final Uint8List? image;
  ImagePeak({required this.loadImage, required this.image});

  @override
  State<ImagePeak> createState() => _ImagePeakState();
}

class _ImagePeakState extends State<ImagePeak> {
  @override
  void initState() {
    strBase64Image = widget.image;
    super.initState();
  }

  Uint8List? strBase64Image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Colors.grey.shade200),
        child: strBase64Image == null
            ? const Center(
                child: Text('Add image'),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Image.memory(
                  strBase64Image!,
                  fit: BoxFit.fill,
                ),
              ),
      ),
      onTap: () async {
        await _openCameraPhoto(onPhoto: () async {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            await getImage(ImageSource.camera);
          } else if (status.isDenied) {
            await Permission.camera.request();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Camera Permission'),
                      content: const Text('Camera Permission Required'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          child: const Text('Settings'),
                          onPressed: () => openAppSettings(),
                        ),
                      ],
                    ));
          }
        }, onFile: () async {
          var status = await Permission.storage;
          if (await status.isGranted) {
            await loadAssets();
            setState(() {});
          } else if (await status.isDenied) {
            await Permission.storage.request();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('Photo Libary Permission'),
                      content: const Text('Photo Libary Permission requied'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: const Text('Deny'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          child: const Text('Open Settings'),
                          onPressed: () => openAppSettings(),
                        ),
                      ],
                    ));
          }
        });
      },
    );
  }

  Future<void> _openCameraPhoto(
      {required VoidCallback onPhoto, required VoidCallback onFile}) async {
    return await showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context1) => CupertinoActionSheet(
        title: const Text(
          'Choose your source',
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontFamily: 'Roboto'),
        ),
        message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              AppRouter.pop(context);
              onPhoto();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () async {
              Navigator.pop(context);
              onFile();
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      Uint8List imageBytes = await image.readAsBytes();
      strBase64Image = imageBytes;
      widget.loadImage(
        imageBytes,
      );
      setState(() {});
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "camera_access_denied") {
          return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Camera Permission'),
                    content: const Text('Camera Permission Required'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Deny'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('strSettings'),
                        onPressed: () => openAppSettings(),
                      ),
                    ],
                  ));
        }
      }
    }
  }

  Future<void> getImage(ImageSource imageSource) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      Uint8List imageBytes = await image.readAsBytes();
      strBase64Image = imageBytes;
      widget.loadImage(
        imageBytes,
      );
      setState(() {});
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "camera_access_denied") {
          return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Camera Permission'),
                    content: const Text('Camera Permission Required'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Deny'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('strSettings'),
                        onPressed: () => openAppSettings(),
                      ),
                    ],
                  ));
        }
      }
    }
  }
}
