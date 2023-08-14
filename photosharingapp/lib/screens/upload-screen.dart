
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photosharingapp/data/post_data.dart';
import 'package:photosharingapp/models/posts.dart';
import 'package:photosharingapp/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class UploadPost extends ConsumerStatefulWidget{
const UploadPost({super.key,required this.gotoHome});
final Function gotoHome;
ConsumerState<UploadPost> createState(){
  return _UploadPostState();
}
}

class _UploadPostState extends ConsumerState<UploadPost>{
  Widget _img=Container(
    height: 200,
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2,color:Colors.deepPurple,style: BorderStyle.solid
      )
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add_a_photo,color: Colors.deepPurple,),
          Text("select photo",
          style:GoogleFonts.ptSansNarrow(
            fontSize: 10
          ))
        ],
      ),
    ));
  TextEditingController caption=TextEditingController();
  late XFile? image;
  Widget build(BuildContext context){

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: _img,
              onTap: ()async{
                  final ImagePicker picker = ImagePicker();
                  image= await picker.pickImage(source: ImageSource.gallery);
                  if(image!=null){
                  setState(() {
                    _img=Image.file(File(image!.path),height: 200,width: 200,);
                  });
                  }
              },
            ),
            const SizedBox(height: 20,),
            TextField(
              style: GoogleFonts.ptSansNarrow(),
              controller: caption,
              decoration:InputDecoration(
                label: Text("caption",
                style: GoogleFonts.ptSansNarrow(),),
                hintText: "caption",
              ),
            ),
           const  SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              //add logic for posting afterwards...
              var request=http.MultipartRequest('POST',Uri.parse("http://192.168.1.7:6000/addpost"));
              request.fields['caption']=caption.text;
              request.fields['userName']=ref.read(userProvider.notifier).getUser();
              request.files.add(await http.MultipartFile.fromPath("post", image!.path),);
              var response=await request.send();
              //posts.add(Post(username: ref.read(userProvider.notifier).getUser(), postUrl: "assets/photo.png", likes: 0, caption: caption.text,id:"123"));
              widget.gotoHome();
            }, child: Text("post",style: GoogleFonts.ptSansNarrow(),))
          ],
        ),
      ),
    );
  }
}