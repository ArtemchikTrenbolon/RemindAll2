import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app3/components/my_button.dart';
import 'package:flutter_app3/components/my_textfiled.dart';
import 'package:flutter_app3/pages/forgot_password_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';



import '../components/square_tile.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget{
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void singUserIn() async{
    showDialog(
      context: context,
      builder: (context) {
      return const Center(
          child: CircularProgressIndicator()
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Center(
              child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),

                Image.asset(
                  "lib/images/WavingHandYea.png",
                  width: 150,
                  height: 150,
                ),

                SizedBox(height: 25),

                Text(
                  'Здравствуйте!',
                  style: TextStyle(
                    fontFamily: 'BebasNeue_cyrilic',
                    fontSize: 36,
                    fontWeight:FontWeight.normal
                  ),
                ),


                SizedBox(height: 10),
            
                Text(
                    'Добро пожаловать обратно, мы по вам скучали!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 17,
                    ),
                ),
            
                SizedBox(height: 10),
            
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Почта',
                            ),
                          )
                  ),
                ),
                ),
                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Пароль',
                          ),
                        )
                    ),
                  ),
                ),
            
                SizedBox(height: 10),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  }
                              ),
                          );
                        },
                        child: Text(
                          'Забыли пароль?',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 25),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: MyButton(
                        text: "Войти",
                        onTap: singUserIn,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                const SizedBox(height: 50),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Нет аккаунта?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                          'Зарегистрироваться',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        ),
                    ),
                ],
                  )
            
              ],
            ),
          ),
        ),
      )

    );
  }
}