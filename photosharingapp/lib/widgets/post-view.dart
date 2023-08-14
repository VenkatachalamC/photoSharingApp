

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photosharingapp/models/posts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PostView extends StatefulWidget{
  const PostView({super.key,required this.post});
  final Post post;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool liked=false;
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:0,vertical: 20 ),
      padding: const EdgeInsets.all(10),
      child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(widget.post.username,
      style:GoogleFonts.ptSansNarrow(
        fontSize: 23,
        fontWeight: FontWeight.w500
      )),
      Image.network(widget.post.postUrl,
      height:300,
      width: double.infinity,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        IconButton(onPressed: (){
          if(!liked){
          setState(() {
            http.post(Uri.parse("http://192.168.1.7:6000/likepost"),body: jsonEncode({
              "id":widget.post.id
            }),headers: {
              "Content-Type":"application/json"
            });
            widget.post.addLike();
            liked=true;
          });
          }
          else{
            setState(() {
              http.post(Uri.parse("http://192.168.1.7:6000/dislike"),
              body:jsonEncode({
                "id":widget.post.id
              }),headers: {
                "Content-Type":"application/json"
              });
              widget.post.removeLike();
              liked=false;
            });
          }
        }, icon: Icon(Icons.thumb_up,color:liked?Colors.blue:Colors.grey,)),
        Text("${widget.post.likes} likes",
        style:GoogleFonts.ptSansNarrow(
          fontSize: 16
        ))
      ],),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
        child: Text(widget.post.caption,
        style: GoogleFonts.ptSansNarrow(
          fontSize: 18,
          fontWeight: FontWeight.w400
        ),)
      )
      ]),
    );
  }
}