
class Post{
  Post({required this.username,required this.postUrl,required this.likes,required this.caption,required this.id});
  String id;
  final String username;
  final String postUrl;
  int likes;
  final String caption;

  void addLike(){
    likes++;
  }
  void removeLike(){
    likes--;
  }
}