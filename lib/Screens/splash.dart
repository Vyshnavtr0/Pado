import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mavoz/Screens/home.dart';
import 'package:mavoz/Screens/login.dart';
import 'package:mavoz/Screens/signup.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    nextScreen();
  }

  List<String> name = [];
  List<String> image = [];
  List<String> url = [];
  List<String> rate = [];
  List<String> releasedate = [];
  List<String> age = [];
  List<String> language = [];
  List<String> status = [];
  List<String> genre = [];
  List<String> about = [];
  final auth = FirebaseAuth.instance;
  nextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    var collection = FirebaseFirestore.instance.collection('Films');
    var querySnapshot = await collection.limit(5).get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      name.add(data['name']);
      image.add(data['image']);
      url.add(data['url']);
      rate.add(data['rate']);
      releasedate.add(data['releasedate']);
      age.add(data['age']);
      language.add(data['language']);
      status.add(data['status']);
      genre.add(data['genre']);
      about.add(data['about']);
    }
    if (auth.currentUser == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Login())));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => Home(
                about: about,
                age: age,
                genre: genre,
                image: image,
                language: language,
                name: name,
                rate: rate,
                releasedate: releasedate,
                status: status,
                url: url,
              ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        "assets/images/icongif.gif",
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.contain,
      )),
    );
  }
}
