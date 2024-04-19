import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/pages/photo_page.dart';

import '../resources/image_clother.dart';

class CameraMen extends StatefulWidget {

  final imageIcon;
  const CameraMen({super.key, required this.imageIcon});



  @override
  State<CameraMen> createState() => _CameraMenState();
}

class _CameraMenState extends State<CameraMen> {

  late String imageIcon;

  @override
  void initState() {
    super.initState();
    imageIcon = widget.imageIcon;
  }
  XFile? imageFile;
  void _onClick(final bool gallery, final String bodyPart) async {
    double ratioX = 0.0;
    double ratioY = 0.0;
    switch (bodyPart) {
      case "Head":
        ratioX = 1.5;
        ratioY = 1;
        break;
      case "Torso":
        ratioX = 2;
        ratioY = 1;
        break;
      case "Legs":
        ratioX = 2.5;
        ratioY = 1;
        break;
      case "Feet":
        ratioX = 1.5;
        ratioY = 1;
        break;
    }
    imageFile = await ImagePickerService().pickCropImage(
        cropAspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
        imageSource: gallery ? ImageSource.gallery : ImageSource.camera);
    setState(() {});
    print(imageFile!.path);
    if (imageFile != null){
      Navigator.of((context)).push(MaterialPageRoute(
          builder: (context) => PhotoPage(imageFile: imageFile!.path, bodyPart: bodyPart,))
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Take A Photo\nFrom:",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
                const SizedBox(height: 27),
                ButtomChoose(
                  onTap: () {
                    _onClick(false, _convert(imageIcon));
                  },
                  text: "Camera",
                ),
                SizedBox(height: 10),
                ButtomChoose(
                  onTap: () {
                    print("aaaaaaaaaaaa");
                    _onClick(true, _convert(imageIcon));
                  },
                  text: "Galery",
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//         child: imageFile != null
//             ? Image(
//                 image: FileImage(File(imageFile!.path)),
//               )
//             : Text("No Image")),
//     floatingActionButton: FloatingActionButton(
//       onPressed: _onClick,
//       child: Icon(Icons.camera),
//     ),
//   );
// }
}

class ButtomChoose extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ButtomChoose({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ImagePickerService {
  Future<XFile?> pickCropImage(
      {required CropAspectRatio cropAspectRatio,
      required ImageSource imageSource}) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage == null) return null;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickImage.path,
        aspectRatio: cropAspectRatio,
        compressQuality: 90,
        compressFormat: ImageCompressFormat.png);
    if (croppedFile == null) return null;

    return XFile(croppedFile.path);
  }
}
String _convert(ImagePath){
  switch(ImagePath){
    case ImageClother.iconHat:
      return "Head";
    case ImageClother.iconPolo:
      return "Torso";
    case ImageClother.iconPants:
      return "Legs";
    case ImageClother.iconShoose:
      return "Feet";
    default:
      return "Error";
  }
}
