


import 'package:flutter/material.dart';
import 'package:photosharingapp/models/posts.dart';
import 'package:photosharingapp/widgets/post-view.dart';

class PostList extends StatelessWidget{
  const PostList({super.key,required this.posts});
  final List<Post> posts;

  Widget build(BuildContext context){
    return ListView.builder(itemCount:posts.length,itemBuilder:(ctx,i){
      return Center(child: PostView(post: posts[i]));
    });
  }
}