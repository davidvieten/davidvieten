import "package:firebase_auth/firebase_auth.dart";
import 'package:firstapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/my_button.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  //register text tap detection
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //log in user method
  void logUserIn () async {
    // loading circle
    showDialog(
      context: context,
       builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //wrong email
      wrongCredentialMessage(e.code);
    }
  }

  //popup when email is not found
    void wrongCredentialMessage(String message) {
      showDialog(
        context: context,
        builder:(context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
                ),
            )
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  //SSL Logo
                  const SizedBox(height: 50),
                  Image.asset(
                  'lib/images/SSL23LOGO.png', 
                  width: 250, 
                  height: 250, 
                  // You can also set other properties of the Image widget such as fit, alignment, etc.
                  ),
            
                  //Welcome Message
                  const SizedBox(height: 0),
                  Text('Welcome SSL General Manager!',
                  style: TextStyle(color: Colors.grey[800],
                  fontSize: 18)),
            
                  const SizedBox(height: 50),
                  //email enter
                  MyTextField(
                    controller: emailController,
                    obsecureText: false, 
                    hintText: 'Email:',),
            
                  //password enter
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController, 
                    obsecureText: true, 
                    hintText: 'Password:',),
                  
                  //forgot password
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
            
                  //sign in button
                  const SizedBox(height: 10),
                  MyButton(
                    onTap: logUserIn,
                    text: "Login",
                  ),
            
                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey.shade600),
                        ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold)
                        ),
                      ),
            
                    ],
                  )
             ],
            ),
          ),
        ),
      ),
    );
  }
}

