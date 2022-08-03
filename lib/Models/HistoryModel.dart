class historymodel {
  String? name;
  String? age;
  String? rate;
  String? releasedate;
  String? language;
  String? url;
  String? about;
  String? genre;
  String? image;
  String? status;
  String? time;

  historymodel({
    this.about,
    this.name,
    this.age,
    this.genre,
    this.image,
    this.language,
    this.rate,
    this.releasedate,
    this.status,
    this.url,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'status': status,
      'releasedate': releasedate,
      'rate': rate,
      'language': language,
      'image': image,
      'genre': genre,
      'name': name,
      'age': age,
      'about': about,
      'time': time,
    };
  }
}
