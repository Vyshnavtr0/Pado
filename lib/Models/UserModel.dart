class usermodel {
  String? uid;
  String? email;
  String? name;
  String? photo;
  String? phone;
  String? pro;
  usermodel(
      {this.email, this.name, this.uid, this.photo, this.phone, this.pro});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photo': photo,
      'phone': phone,
      'pro': pro,
    };
  }
}
