import "package:firebase_auth/firebase_auth.dart";
import 'package:firstapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/my_button.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  //register text tap detection
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp () async {
    // loading circle
    showDialog(
      context: context,
       builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating user
    try {
      //check if confirmed password matches
      if(passwordController.text == ConfirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
        );
      } else {
        //error pop up
        errorMessage("Passwords don't match");
      }
      
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //wrong email
      errorMessage(e.code);
    }
  }

  //popup when email is not found
    void errorMessage(String message) {
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
                  Text('Create your account now!',
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

                  //confirm password
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: ConfirmPasswordController, 
                    obsecureText: true, 
                    hintText: 'Confirm Password:',), 
                  
            
                  //sign in button
                  const SizedBox(height: 10),
                  MyButton(
                    onTap: signUserUp,
                    text: "Sign Up",
                   
                  ),
            
                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey.shade600),
                        ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
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

