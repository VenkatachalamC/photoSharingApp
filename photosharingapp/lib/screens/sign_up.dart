


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class SignUp extends StatefulWidget{
  const SignUp({super.key});
  State<SignUp> createState(){
    return _SignUpState();
  }
}
class _SignUpState extends State<SignUp>{
  TextEditingController username=TextEditingController();
  TextEditingController pass1=TextEditingController();
  TextEditingController pass2=TextEditingController();
  Widget _error=const Text("");

  void dispose(){
    super.dispose();
    username.dispose();
    pass1.dispose();
    pass2.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("Sign Up",
      style:GoogleFonts.ptSansNarrow()),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _error,
            TextField(
              style: GoogleFonts.ptSansNarrow(),
              controller: username,
              decoration:InputDecoration(
                hintText: "username",
                label: Text("username",style:GoogleFonts.ptSansNarrow()),
                border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              style: GoogleFonts.ptSansNarrow(),
              controller:pass1,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
                label: Text("password",style:GoogleFonts.ptSansNarrow()),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              style: GoogleFonts.ptSansNarrow(),
              controller:pass2,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "confirm password",
                label: Text("username",style:GoogleFonts.ptSansNarrow()),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              if(pass1.text==pass2.text){
               var response=await http.post(Uri.parse("http://192.168.1.7:6000/signup"),
                body: jsonEncode({
                  "userName":username.text,
                  "password":pass1.text
                }),
                headers: {
                  "Content-Type":"application/json"
                });
                if(response.statusCode==200){
                  Navigator.of(context).pop();
                }
                else{
                  _error=Text("something went wrong.try again",style: GoogleFonts.ptSansNarrow( color:Colors.red),);
                }
              }else{
                setState(() {
                  _error=Text("passwords do not match",style: GoogleFonts.ptSansNarrow(
                    color: Colors.red
                  ),);
                });
              }
            }, child:Text("Sign Up",
            style:GoogleFonts.ptSansNarrow()))
          ],)
        ),
      ),
    );
  }
}