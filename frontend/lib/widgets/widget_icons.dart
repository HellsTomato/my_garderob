
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/pages/camera_page.dart';
import 'package:my_garderob/pages/photo_page.dart';
import 'package:my_garderob/resources/image_clother.dart';

// class IconWidget extends StatelessWidget {
//   final height;
//   final String ImagePath;
//   final VoidCallback onTap;
//
//   const IconWidget(
//       {super.key,
//       required this.height,
//       required this.ImagePath,
//       required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           height: height,
//           width: double.infinity,
//           padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 1),
//               borderRadius: BorderRadius.circular(10)),
//           child: Stack(
//             children: [
//               Align(alignment: Alignment.center, child: Image.asset(ImagePath)),
//               Align(
//                   alignment: Alignment.topRight,
//                   child: GestureDetector(
//                     onTap: () => Navigator.of((context)).push(MaterialPageRoute(
//                         builder: (context) => CameraMen(imageIcon: ImagePath))),
//                     child: Container(
//                       height: 45,
//                       width: 45,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.black, width: 2)),
//                       child: Icon(Icons.add, size: 40),
//                     ),
//                   ))
//             ],
//           )),
//     );
//   }
// }
//
// class ImageContainer extends StatelessWidget {
//   final height;
//   final String ImagePath;
//   final VoidCallback onTap;
//
//   const ImageContainer(
//       {super.key, this.height, required this.ImagePath, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//     onTap: onTap,
//     child: Container(
//         height: height,
//         width: double.infinity,
//         padding: EdgeInsets.all(2),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 1),
//             borderRadius: BorderRadius.circular(10)),
//         child: Stack(
//           children: [
//             Align(alignment: Alignment.center, child: Image.file(File(ImagePath))),
//           ],
//         )),
//     );
//   }
// }
