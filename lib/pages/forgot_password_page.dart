import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget{
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage>{
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Ссылка для сброса пароля отправлена, проверьте свою почту!"),
            );
          });
    }
    on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Image.network(
              "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Objects/Keyboard.webp",
              width: 150,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Введите свою почту и мы отправим вам ссылку для сброса",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 15),

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

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MaterialButton(
                onPressed: passwordReset,
                child: Text(
                  "Сбросить пароль",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                padding: EdgeInsets.all(20), // Добавляем внутренний отступ
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Закругляем углы кнопки
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}