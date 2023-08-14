

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photosharingapp/providers/user_provider.dart';
import 'package:photosharingapp/screens/home-screen.dart';
import 'package:photosharingapp/screens/sign_up.dart';
import 'package:http/http.dart' as http;

class SignIn extends ConsumerStatefulWidget{
  const SignIn({super.key});
  ConsumerState<SignIn> createState(){
    return _SignInState();
  }
}

class _SignInState extends ConsumerState<SignIn>{

  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();

  void dispose(){
    super.dispose();
    username.dispose();
    password.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("Sign In",
      style:GoogleFonts.ptSansNarrow()),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: GoogleFonts.ptSansNarrow(),
                controller:username ,
                decoration:const InputDecoration(
                  hintText: "Username",
                  label: Text("username"),
                  border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(8)))
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                style: GoogleFonts.ptSansNarrow(),
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "password",
                  label: Text("password"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: () async{
                var response=await http.post(Uri.parse("http://192.168.1.7:6000/login"),
                body: jsonEncode({
                  "userName":username.text,
                  "password":password.text
                }),
                headers: {
                  "Content-Type":"application/json"
                });
                if(response.statusCode==200){
                  ref.read(userProvider.notifier).setUser(username.text);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const HomeScreen()));
                }

              }, child:Text("login",
              style:GoogleFonts.ptSansNarrow())),
              const SizedBox(height: 10,),
              InkWell(
                child: Text("Sign up",
                style:GoogleFonts.ptSansNarrow()),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const SignUp()));
                },
              )
            ],
          ),
        ),
      ),

    );
  }
}