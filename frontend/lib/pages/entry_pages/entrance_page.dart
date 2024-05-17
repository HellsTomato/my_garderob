import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/pages/entry_pages/registration_page.dart';
import 'package:my_garderob/pages/room_page.dart';
import 'package:http/http.dart' as http;
import 'package:my_garderob/resources/image_clother.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions/server_api.dart';

//Переменные для оторажения ошибок полей
var emailError = false;
var passwordError = false;
var serverRequest = false;
var errors = {"404": false};

//Текст вводимый в поля
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class EntrancePage extends StatefulWidget {
  const EntrancePage({super.key});

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  @override
  Widget build(BuildContext context) {
    //Не пускает пользователя в поле загрузки
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      // if(serverRequest == true){FutureBuilder( future: _serverRequest(_emailController, _passwordController),builder: (context, snapshot) {},}
      child: (serverRequest == true)
          ? FutureBuilder(
              future: _serverRequest(
                  _emailController.text, _passwordController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      backgroundColor: GarderobColors.background,
                      body: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          )));
                }
                if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      emailError = true;
                      passwordError = true;
                      serverRequest = false;
                    });
                  });
                  return Scaffold(
                    backgroundColor: GarderobColors.background,
                    body: Center(
                        child: SizedBox(
                            height: 30, width: 30, child: Icon(Icons.close))),
                  );
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (snapshot.data == "Error 404") {
                      setState(() {
                        errors["404"] = true;
                      });
                    } else {
                      _saveUsernameToken(snapshot.data!.toString());
                      Navigator.of(context).push(PageTransition(
                          child: RoomPage(),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 500)));
                    }
                  });
                  return Scaffold(
                    backgroundColor: GarderobColors.background,
                    body: Center(
                        child: SizedBox(
                            height: 30, width: 30, child: Icon(Icons.check))),
                  );
                }
              })
          : Scaffold(
              backgroundColor: GarderobColors.background,
              body: SafeArea(
                //Разделяем экран на слои: Всё + кнопка LogIn
                child: Stack(
                  children: [
                    (errors["404"] == true)
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "404",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 19),
                                )))
                        : SizedBox(),
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
                            "Welcome\nMy Garderob",
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
                          //Подпись для забывчивых – сделать когда будет готово API
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: 170,
                          //     ),
                          // Text(
                          //   "Forgot password?",
                          //   style: TextStyle(
                          //       color: Color(0xFF4475F7),
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w400),
                          // )
                          //   ],
                          // ),
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
                    //TODO сделать подсветку неверного email при ошибке полученной со стороне сервера
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
                            child: Text("Log in",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "New in My Wardrobe? ",
                                style: TextStyle(
                                    color: Color(0xFF203531),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of((context)).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationPage()));
                                },
                                child: Text(
                                  "Register here",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFF4475F7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )),
    );
  }

  void _OnPressed() {
//Скрыть кавиатуру когда переходим на следующую страницу
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
        serverRequest = true;
      });
    }
  }

  Future _serverRequest(email, password) async {
    var request = http.MultipartRequest('POST', Uri.parse(Request.login));
    request.fields.addAll({'username': "$email", 'password': "$password"});
    http.StreamedResponse response = await request.send();
    print("Состояние сервера: ${response.statusCode}");

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else if (response.statusCode == 404) {
      setState(() {
        errors["404"] = true;
      });
    }
    throw "_";
  }

  Future _saveUsernameToken(text) async {
    final prefs = await SharedPreferences.getInstance();
    final textToSave = (text.substring(10, (text.length - 2)));
    await prefs.setString("text", "$textToSave");
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
