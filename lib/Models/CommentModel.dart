class commentsmodel {
  String? name;
  String? uid;
  String? text;
  List<String>? like;
  String? image;
  String? time;

  commentsmodel({
    this.name,
    this.image,
    this.like,
    this.text,
    this.uid,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'time': time,
      'like': like,
      'text': text,
      'time': uid,
    };
  }
}
