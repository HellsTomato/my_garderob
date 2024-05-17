import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/pages/room_page.dart';
import 'package:my_garderob/resources/image_clother.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../functions/server_api.dart';

//Переменные для оторажения ошибок полей
var emailError = false;
var passwordError = false;
var serverRequest = false;
//Текст вводимый в поля
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _MainPageState();
}

late Future<String> token;

class _MainPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    if (serverRequest == true) {
      return FutureBuilder(
          future: token,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Scaffold(
                      backgroundColor: GarderobColors.background,
                      body: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ))));
            }
            if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  serverRequest = false;
                  emailError = true;
                  passwordError = true;
                });
              });
              return Scaffold(
                  backgroundColor: GarderobColors.background,
                  body: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()));
            } else {
              _saveUsernameToken(snapshot.data!.toString());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(PageTransition(
                    child: RoomPage(),
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 500)));
              });
              return Scaffold(
                  backgroundColor: GarderobColors.background,
                  body: Center(
                    child: SizedBox(
                        height: 20, width: 20, child: Icon(Icons.check)),
                  ));
            }
          });
    } else {
      return Scaffold(
          backgroundColor: GarderobColors.background,
          body: SafeArea(
            //Разделяем экран на слои: Всё + кнопка LogIn
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 197,
                      // ),
                      Text(
                        "Registration In\nMy Wardrobe",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 28),
                      ),
                      const SizedBox(height: 27),
                      EmailWidget(
                        text: "Email",
                      ),
                      const SizedBox(height: 23),
                      PasswordWidget(text: "Password"),
                      const SizedBox(height: 17),

                      const SizedBox(
                        height: 68.09,
                      ),

//Иконка одежды (фиксирована)
                      Image.asset(
                        ImageClother.clotherStopka,
                        height: 110,
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),

//Кнопка проверяет заполненность полей: Заполнено ? Отправить на сервер : ИНАЧЕ подсветка пустых полей
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 78),
                    child: GestureDetector(
//Запускаем функцию делающую работу при нажатии
                      onTap: () => _OnPressed(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 279,
                        decoration: BoxDecoration(
                            color: Color(0xFF203531),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("Create",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }

  Future _saveUsernameToken(String text) async {

    final prefs = await SharedPreferences.getInstance();
    final textToSave = (text.substring(10, (text.length - 2)));
    await prefs.setString("text", "$textToSave");
  }

  void _OnPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_emailController.text == "") {
      setState(() {
        emailError = true;
      });
    }
    if (_passwordController.text == "") {
      setState(() {
        passwordError = true;
      });
    }
    if (_emailController.text != "" && _passwordController.text != "") {
      setState(() {
        token = _registration(_emailController.text, _passwordController.text);
        serverRequest = true;
      });
      // Navigator.of((context))
      //     .push(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

// Пока username = email
// Работа с сервером
  Future<String> _registration(String email, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(Request.registration));
    request.fields.addAll({
      'email': "$email",
      'username': "$email",
      'password': "$password",
    });
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode != 201) {
      throw "";
    }
    return await response.stream.bytesToString();
  }
}

class EmailWidget extends StatefulWidget {
  final String text;

  const EmailWidget({
    super.key,
    required this.text,
  });

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 4,
                offset: Offset(0, 4))
          ],
          border: Border.all(
              color: emailError
                  ? Color.fromRGBO(255, 51, 51, 0.50)
                  : Color(0xFFE5E9EA),
              width: emailError ? 2 : 1)),
      // padding: EdgeInsets.only(bottom:1,
      alignment: Alignment.center,
      // TODO 29 максимум - добавить
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textAlignVertical: TextAlignVertical.center,
        onTap: () {
          setState(() {
            emailError = false;
          });
        },
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
            hintText: widget.text,
            // contentPadding: EdgeInsets.only(bottom: 2),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.mail_outline),
            suffixIcon: null),
        enableSuggestions: true,
      ),
    );
  }
}

class PasswordWidget extends StatefulWidget {
  final String text;

  PasswordWidget({
    super.key,
    required this.text,
  });

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 4,
                offset: Offset(0, 4))
          ],
          border: Border.all(
              color: passwordError
                  ? Color.fromRGBO(255, 51, 51, 0.50)
                  : Color(0xFFE5E9EA),
              width: passwordError ? 2 : 1)),
      // padding: EdgeInsets.only(bottom:1,
      alignment: Alignment.center,
      // TODO 29 максимум - добавить
      child: TextField(
        controller: _passwordController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("^[\u0000-\u007F]+\$"))
        ],
        autocorrect: false,
        obscureText: hideText,
        textAlignVertical: TextAlignVertical.center,
        onTap: () {
          setState(() {
            passwordError = false;
          });
        },
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon(hideText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
            onTap: () => setState(() => hideText = !hideText),
          ),
          hintText: "Password",
          // contentPadding: EdgeInsets.only(bottom: 2)fghj
          border: InputBorder.none,
          prefixIcon: Icon(Icons.lock_outline_rounded),
        ),
        enableSuggestions: true,
      ),
    );
  }
}
