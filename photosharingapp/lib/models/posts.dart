
class Post{
  Post({required this.username,required this.postUrl,required this.likes,required this.caption,required this.id,required this.liked});
  String id;
  final String username;
  final String postUrl;
  int likes;
  final String caption;
  bool liked;

  void addLike(){
    likes++;
    liked=true;
  }
  void removeLike(){
    likes--;
    liked=false;
  }
}