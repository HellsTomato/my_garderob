// import 'package:flutter/material.dart';
//
// class _SearchWidget extends StatefulWidget {
//   const _SearchWidget({super.key});
//
//   @override
//   State<_SearchWidget> createState() => _SearchWidgetState();
// }
//
// class _SearchWidgetState extends State<_SearchWidget> {
//   final TextEditingController controller = TextEditingController();
//   bool haveSearchText = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//
//       controller: controller,
//       //Cтиль текста
//       style: TextStyle(
//         fontWeight: FontWeight.w900,
//         fontSize: 20,
//         color: Colors.black,
//       ),
//       //Стиль курсора
//       cursorColor: Colors.black,
//       //Подпись клавиатурной кнопки
//       textInputAction: TextInputAction.search,
//       //InputDecoration
//       decoration: InputDecoration(
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Colors.black, width: 2)),
//
//         isDense: true,
//         //Значек стирания
//         suffix: GestureDetector(
//           onTap: () => controller.clear(),
//           child: Icon(Icons.clear, color: Colors.black),
//         ),
//         //Значек лупы
//         prefixIcon: Icon(
//           Icons.search,
//           color: Colors.black,
//           size: 24,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: haveSearchText
//               ? BorderSide(color: Colors.black, width: 2)
//               : BorderSide(color: Colors.black26),
//         ),
//       ),
//       textCapitalization: TextCapitalization.words,
//
//     );
//   }
// }
