import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/components/my_button.dart';
import 'package:flutter_app3/components/my_textfiled.dart';
import 'package:flutter_app3/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';



import '../components/square_tile.dart';

class RegisterPage extends StatefulWidget{
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void singUserUp() async{

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator()
        );
      },
    );

    try {
      // if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      // }

      // else {
      //   showErrorMessage('Password don\`t match!');
      // }

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'username' : emailController.text.split('@')[0]
      });
    if (context.mounted) Navigator.pop(context);
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
                style:  TextStyle(color: Colors.white),
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
                  SizedBox(height: 25),

                Image.asset(
                  'lib/images/personal.png',

                  width: 100,
                  height: 100,
                ),


                  SizedBox(height: 10),

                  Text(
                    'Let\`s create an account for you!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 28,
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
                              hintText: 'Email',
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
                              hintText: 'Password',
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
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                          )
                      ),
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
                          text: "Зарегистрироваться",
                          onTap: singUserUp,
                        ),
                      ),
                    ),
                  ),



                  SizedBox(height: 50),



                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Уже есть аккаунт?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Войти',
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