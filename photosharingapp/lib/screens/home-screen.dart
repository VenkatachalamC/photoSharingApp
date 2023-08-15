import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photosharingapp/models/posts.dart';
import 'package:photosharingapp/providers/user_provider.dart';
import 'package:photosharingapp/screens/sign_in.dart';
import 'package:photosharingapp/screens/upload-screen.dart';
import 'package:photosharingapp/widgets/postlist.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends ConsumerStatefulWidget{
  const HomeScreen({super.key});
  ConsumerState<HomeScreen> createState(){
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen>{
  int _currentIndex=0;
  late List<Post> postList=[];
  late Widget _currentWidget=PostList(posts: postList);
  void gotoHome(){
    setState(() {
      _currentIndex=0;
      _currentWidget=PostList(posts: postList,);
    });
  }

  Future<List<Post>> loadPosts() async{
    var url=Uri.parse("http://192.168.1.7:6000/posts/${ref.read(userProvider.notifier).getUser()}");
    var response=await http.get(url);
    var result=jsonDecode(response.body);
    postList=[];
    result.forEach((e){
      postList.add(Post(username: e["userName"], postUrl: "http://192.168.1.7:6000/post/${e["_id"]}", likes: e["likes"], caption: e["caption"],id:e["_id"],liked: e["liked"]));
    });
    return postList;
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Sharing App",style: GoogleFonts.ptSansNarrow(),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const SignIn()));
          }, icon:const Icon(Icons.logout_sharp))
        ],
      ),
      body:FutureBuilder(future:loadPosts(), builder:(ctx, snapshot) {
        if(snapshot.hasData){
          return _currentWidget;
        }
        else if(snapshot.hasError){
          return Center(child: const Text("something went wrong"),);
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:const  [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo),label:"Add post"),
      ],
      onTap: (idx){
        setState(() {
          _currentIndex=idx;
          _currentWidget=idx==0?PostList(posts: postList,):UploadPost(gotoHome:gotoHome);
        });
      },
      ),
    );
  }
}