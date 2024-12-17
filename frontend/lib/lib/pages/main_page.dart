import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/room_page.dart';

var emailError = false;
var passwordError = false;

//Текст вводимый в поля
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
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
                      "Welcome\nMy Wardrobe",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
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
                      "assets/icons/startClother.png",
                      height: 97,
                      width: 74,
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
              // Align(
              //   alignment: Alignment.bottomCenter,
              // child: Padding(
              //     padding: EdgeInsets.only(bottom: 30),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Text("New in My Wardrobe?", style: TextStyle(color: Color(0xFF203531), fontSize: 12, fontWeight: FontWeight.w400),),
              //   Text(" Register here", style: TextStyle(color: Color(0xFF4475F7),fontSize: 12, fontWeight: FontWeight.w400))],
              // )),
              // )
            ],
          ),
        ));
  }

  void _OnPressed() {
    print("EMAIL AND PASSWORD");
    print(_emailController.text);
    print(_passwordController.text);
    print("Email $emailError");
    print("END");
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_emailController.text == "") {
      setState(() {
        emailError = true;
      });}
    if (_passwordController.text == "") {
      setState(() {
        passwordError = true;
      });
    }
    if (_emailController.text != "" && _passwordController.text != "") {
      Navigator.of((context))
          .push(MaterialPageRoute(builder: (context) => RoomPage()));
    }
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
              color: emailError ? Color.fromRGBO(255, 51, 51, 0.50) : Color(0xFFE5E9EA),
            width: emailError ? 2 : 1
          )),
      // padding: EdgeInsets.only(bottom:1,
      alignment: Alignment.center,
      // TODO 29 максимум - добавить
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textAlignVertical: TextAlignVertical.center,
        onTap:(){
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
          border: Border.all(color: passwordError ? Color.fromRGBO(255, 51, 51, 0.50) : Color(0xFFE5E9EA),
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
        onTap: () {setState(() {
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
