import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:group_button/group_button.dart';
import 'package:mavoz/Screens/details.dart';
import 'package:mavoz/Screens/splash.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Home extends StatefulWidget {
  final List<String> name;
  final List<String> rate;
  final List<String> image;
  final List<String> url;
  final List<String> releasedate;
  final List<String> age;
  final List<String> language;
  final List<String> status;
  final List<String> genre;
  final List<String> about;
  const Home({
    Key? key,
    required this.name,
    required this.age,
    required this.rate,
    required this.releasedate,
    required this.language,
    required this.url,
    required this.about,
    required this.genre,
    required this.image,
    required this.status,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = "Username";
  String useremail = "Useremail";
  String userphoto = "Username";
  String listselect = "";
  int pageViewIndex = 0;
  final gpcontroller = GroupButtonController(selectedIndex: 0);
  var controller = PageController(initialPage: 0);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    userinfo() async {
      final user = await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid.toString())
          .get()
          .then((value) {
        setState(() {
          userphoto = value.data()!['photo'];
          username = value.data()!['name'];
          useremail = value.data()!['email'];
        });
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(e!.message)));
      });
    }

    userinfo();
  }

  List<Widget> _createmoviecard() {
    return new List<Widget>.generate(4, (int index) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            GestureDetector(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Details(
                          about: widget.about[index],
                          age: widget.age[index],
                          genre: widget.genre[index],
                          image: widget.image[index],
                          language: widget.language[index],
                          name: widget.name[index],
                          rate: widget.rate[index],
                          releasedate: widget.releasedate[index],
                          status: widget.status[index],
                          url: widget.url[index],
                        )));
              }),
              child: Container(
                height: MediaQuery.of(context).size.height / 6.5,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/noimage.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: widget.url[index],
                    child: Image.network(
                      widget.image[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Color(0xFFD70B17),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      widget.rate[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  List<Widget> _createChildren() {
    return new List<Widget>.generate(4, (int index) {
      return Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Details(
                        about: widget.about[index],
                        age: widget.age[index],
                        genre: widget.genre[index],
                        image: widget.image[index],
                        language: widget.language[index],
                        name: widget.name[index],
                        rate: widget.rate[index],
                        releasedate: widget.releasedate[index],
                        status: widget.status[index],
                        url: widget.url[index],
                      )));
            }),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/noimage.png"),
                  fit: BoxFit.contain,
                ),
              ),
              child: Image.network(
                widget.image[index],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Details(
                        about: widget.about[index],
                        age: widget.age[index],
                        genre: widget.genre[index],
                        image: widget.image[index],
                        language: widget.language[index],
                        name: widget.name[index],
                        rate: widget.rate[index],
                        releasedate: widget.releasedate[index],
                        status: widget.status[index],
                        url: widget.url[index],
                      )));
            }),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Details(
                        about: widget.about[index],
                        age: widget.age[index],
                        genre: widget.genre[index],
                        image: widget.image[index],
                        language: widget.language[index],
                        name: widget.name[index],
                        rate: widget.rate[index],
                        releasedate: widget.releasedate[index],
                        status: widget.status[index],
                        url: widget.url[index],
                      )));
            }),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 4,
                  // width: MediaQuery.of(context).size.width/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.about[index].length > 20
                            ? "${widget.about[index].substring(0, 20)}..."
                            : widget.about[index],
                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 10,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Details(
                                          about: widget.about[index],
                                          age: widget.age[index],
                                          genre: widget.genre[index],
                                          image: widget.image[index],
                                          language: widget.language[index],
                                          name: widget.name[index],
                                          rate: widget.rate[index],
                                          releasedate:
                                              widget.releasedate[index],
                                          status: widget.status[index],
                                          url: widget.url[index],
                                        )));
                              },
                              child: Container(
                                // margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFFD70B17),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFFD70B17),
                                    )),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.circlePlay,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "  Play  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff181a20),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: GNav(
            tabMargin: EdgeInsets.all(10),
            tabBorderRadius: 15,
            selectedIndex: pageViewIndex,
            tabBackgroundColor: Colors.white10,
            tabActiveBorder: Border.all(
                color: Colors.transparent, width: 1), // tab button border
            tabBorder: Border.all(
                color: Colors.transparent, width: 1), // tab button border

            // tab animation curves
            onTabChange: (index) {
              controller.animateToPage(index,
                  duration: Duration(milliseconds: 10),
                  curve: Curves.bounceInOut);
              setState(() {
                pageViewIndex = index;
              });
            },
            gap: 8, // the tab button gap between icon and text
            color: Colors.white30, // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 16,
            textSize: 10,

            // tab button icon size
            // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 8, vertical: 8), // navigation bar padding
            tabs: [
              GButton(
                icon: FontAwesomeIcons.houseChimneyWindow,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.compass,
                text: 'Explore',
              ),
              GButton(
                icon: FontAwesomeIcons.bookBookmark,
                text: 'My List',
              ),
              GButton(
                icon: FontAwesomeIcons.clockRotateLeft,
                text: 'History',
              ),
              GButton(
                icon: FontAwesomeIcons.user,
                text: 'Profile',
              )
            ]),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: pageViewIndex == 2
                ? Text('My List')
                : pageViewIndex == 4
                    ? Text('Profile')
                    : pageViewIndex == 1
                        ? Container(
                            //Type TextField
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,

                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xff1f222a),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.sistrix,
                                    color: Color(0xff58595c),
                                  ),

                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  hintText:
                                      'Search', // pass the hint text parameter here
                                  hintStyle: TextStyle(
                                      color: Color(0xff58595c), fontSize: 20),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : pageViewIndex == 3
                            ? Text('History')
                            : null,
            actions: [
              Visibility(
                visible: pageViewIndex == 0 ? true : false,
                child: IconButton(
                    onPressed: (() {}), icon: FaIcon(FontAwesomeIcons.sistrix)),
              ),
              Visibility(
                visible: pageViewIndex == 1 ? true : false,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xFFD70B17).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                      color: Color(0xFFD70B17),
                      onPressed: (() {}),
                      icon: FaIcon(Icons.tune)),
                ),
              ),
              Visibility(
                  visible: pageViewIndex == 0 ? true : false,
                  child: IconButton(
                      onPressed: (() {}), icon: FaIcon(FontAwesomeIcons.bell)))
            ],
            leading: pageViewIndex == 0
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      "assets/images/icon.png",
                      fit: BoxFit.contain,
                    ),
                  )
                : null),
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              pageViewIndex = index;
            });
          },
          children: [
            home(context),
            explore(context),
            mylist(context),
            history(context),
            profile(context)
          ],
        ));
  }

  SingleChildScrollView history(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(auth.currentUser?.uid.toString())
                          .collection('History')
                          .orderBy('time')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error }');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.data == null) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/history.png",
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    " Empty History",
                                    style: TextStyle(
                                        color: Color(0xFFD70B17),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "it seems that you haven't watch \n any movies ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14,
                                        //fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            );
                          } else {
                            final docs = snapshot.data!.docs;
                            return docs.isNotEmpty
                                ? Column(
                                    children: [
                                      GridView(
                                          padding: EdgeInsets.all(10),
                                          physics: BouncingScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 1,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 6 / 2),
                                          primary: false,
                                          shrinkWrap: true,
                                          children: List<Widget>.generate(
                                            docs.length,
                                            (index) {
                                              final data = docs[index].data();
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (() {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Details(
                                                                        about: data[
                                                                            'about'],
                                                                        age: data[
                                                                            'age'],
                                                                        genre: data[
                                                                            'genre'],
                                                                        image: data[
                                                                            'image'],
                                                                        language:
                                                                            data['language'],
                                                                        name: data[
                                                                            'name'],
                                                                        rate: data[
                                                                            'rate'],
                                                                        releasedate:
                                                                            data['releasedate'],
                                                                        status:
                                                                            data['status'],
                                                                        url: data[
                                                                            'url'],
                                                                      )));
                                                    }),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              8,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/noimage.png"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Hero(
                                                          tag: data['url'],
                                                          child: Image.network(
                                                            data['image'],
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        data['name']
                                                                    .toString()
                                                                    .length >
                                                                15
                                                            ? "${data['name'].toString().substring(0, 15)}..."
                                                            : data['name'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  IconButton(
                                                      color: Color(0xFFD70B17),
                                                      iconSize: 20,
                                                      onPressed: (() {
                                                        var image =
                                                            data['image'];
                                                        var name = data['name'];
                                                        var doc = data['url'];
                                                        showMaterialModalBottomSheet(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              25.0))),
                                                          context: context,
                                                          backgroundColor:
                                                              Colors.white,
                                                          bounce: true,
                                                          builder: (context) =>
                                                              Padding(
                                                            padding:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                        "Do you want to delete it?",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xFF222222),
                                                                            fontSize: 17)),
                                                                    Container(
                                                                      width: 38,
                                                                      height:
                                                                          38,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        color: Color(0xFF707070)
                                                                            .withOpacity(0.2),
                                                                      ),
                                                                      child: IconButton(
                                                                          onPressed: (() {
                                                                            Navigator.of(context).pop();
                                                                          }),
                                                                          icon: Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                Color(0xFF707070).withOpacity(0.7),
                                                                            size:
                                                                                20,
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  color: Color(
                                                                          0xFF707070)
                                                                      .withOpacity(
                                                                          0.2),
                                                                  height: 0.5,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.2,
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          MediaQuery.of(context).size.height /
                                                                              8,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Colors.white),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        child: Image
                                                                            .network(
                                                                          data[
                                                                              'image'],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      name.toString().length >
                                                                              20
                                                                          ? "${name.toString().substring(0, 20)}..."
                                                                          : name,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                RoundedLoadingButton(
                                                                    borderRadius:
                                                                        8,
                                                                    successColor:
                                                                        Colors
                                                                            .green,
                                                                    color: Color(
                                                                        0xFFD70B17),
                                                                    child: Text(
                                                                        "Yes .Delete",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight: FontWeight
                                                                                .w700)),
                                                                    controller:
                                                                        _btnController,
                                                                    onPressed:
                                                                        () async {
                                                                      var tt = doc
                                                                          .substring(
                                                                              16);
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Users")
                                                                          .doc(auth
                                                                              .currentUser!
                                                                              .uid
                                                                              .toString())
                                                                          .collection(
                                                                              'History')
                                                                          .doc(
                                                                              tt)
                                                                          .delete();
                                                                      _btnController
                                                                          .success();
                                                                      await Future.delayed(const Duration(
                                                                          milliseconds:
                                                                              200));
                                                                      setState(
                                                                          () {});
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .trashCan)),
                                                ],
                                              );
                                            },
                                          )),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/history.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        " Empty History",
                                        style: TextStyle(
                                            color: Color(0xFFD70B17),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "it seems that you haven't watch \n any movies ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                            //fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  );
                          }
                        } else {
                          return GridView(
                            padding: EdgeInsets.all(10),
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 6 / 2),
                            primary: false,
                            shrinkWrap: true,
                            children: List<Widget>.generate(15, (index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              );
                            }),
                          );
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView explore(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Films').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;

              return GridView(
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 9 / 6),
                  primary: false,
                  shrinkWrap: true,
                  children: List<Widget>.generate(
                    docs.length,
                    (index) {
                      final data = docs[index].data();
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Details(
                                        about: data['about'],
                                        age: data['age'],
                                        genre: data['genre'],
                                        image: data['image'],
                                        language: data['language'],
                                        name: data['name'],
                                        rate: data['rate'],
                                        releasedate: data['releasedate'],
                                        status: data['status'],
                                        url: data['url'],
                                      )));
                            }),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/noimage.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Hero(
                                  tag: data['url'],
                                  child: Image.network(
                                    data['image'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD70B17),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    widget.rate[0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ));
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: GridView(
                padding: EdgeInsets.only(top: 10),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 9 / 6),
                primary: false,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FadeShimmer(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2,
                      radius: 8,
                      fadeTheme: FadeTheme.dark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FadeShimmer(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2,
                      radius: 8,
                      fadeTheme: FadeTheme.dark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FadeShimmer(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2,
                      radius: 8,
                      fadeTheme: FadeTheme.dark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FadeShimmer(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 2,
                      radius: 8,
                      fadeTheme: FadeTheme.dark,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SafeArea profile(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FadeShimmer.round(
                    size: 200,
                    fadeTheme: FadeTheme.dark,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: Image.network(
                      userphoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFD70B17),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            FontAwesomeIcons.penFancy,
                            size: 20,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            username,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            useremail,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              // fontWeight: FontWeight.bold
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFD70B17), width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/star.png",
                  width: MediaQuery.of(context).size.width / 7,
                  height: MediaQuery.of(context).size.width / 7,
                  fit: BoxFit.fill,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Join Premium !",
                      style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Enjoy watching Full-HD short films,\nwith out restrictions and with out ads",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Icon(
                  FontAwesomeIcons.angleRight,
                  size: 20,
                  color: Color(0xFFD70B17),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: (() {}),
            leading: Icon(
              FontAwesomeIcons.user,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (() {}),
            leading: Icon(
              FontAwesomeIcons.bell,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Notification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (() {}),
            leading: Icon(
              FontAwesomeIcons.key,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (() {}),
            leading: Icon(
              FontAwesomeIcons.share,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Share App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (() {}),
            leading: Icon(
              FontAwesomeIcons.addressCard,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "About Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => Splash())));
            },
            leading: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 20,
              color: Colors.white,
            ),
            trailing: Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    ));
  }

  SafeArea mylist(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
            height: 30,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                GroupButton(
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedShadow: const [],
                    selectedTextStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    selectedColor: Color(0xFFD70B17),
                    unselectedShadow: const [],
                    unselectedColor: Colors.transparent,
                    unselectedTextStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD70B17),
                    ),
                    selectedBorderColor: Color(0xFFD70B17),
                    unselectedBorderColor: Color(0xFFD70B17),
                    borderRadius: BorderRadius.circular(20),
                    spacing: 5,
                    runSpacing: 0,
                    groupingType: GroupingType.row,
                    direction: Axis.horizontal,
                    mainGroupAlignment: MainGroupAlignment.start,
                    crossGroupAlignment: CrossGroupAlignment.start,
                    groupRunAlignment: GroupRunAlignment.start,
                    textAlign: TextAlign.center,
                    textPadding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    elevation: 0,
                  ),
                  onSelected: (list, index, t) {
                    setState(() {
                      listselect = list.toString();
                    });
                  },
                  controller: gpcontroller,
                  buttons: [
                    "All Categories",
                    "Drama",
                    "Comedy",
                    "Romance",
                    "Horror",
                    "Thriller"
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(auth.currentUser?.uid.toString())
                        .collection('MyList')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error }');
                      }
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.data == null) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/listempty.png",
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  "Your List is Empty",
                                  style: TextStyle(
                                      color: Color(0xFFD70B17),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "it seems that you haven't added \n any movies to the list",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 14,
                                      //fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          );
                        } else {
                          final docs = snapshot.data!.docs;
                          return docs.isNotEmpty
                              ? SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: GridView(
                                      padding: EdgeInsets.all(10),
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 28 / 35),
                                      primary: false,
                                      shrinkWrap: true,
                                      children: List<Widget>.generate(
                                        docs.length,
                                        (index) {
                                          final data = docs[index].data();
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/noimage.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Hero(
                                                    tag: data['url'],
                                                    child: Image.network(
                                                      data['image'],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data['name'].length > 10
                                                        ? "${data['name'].toString().substring(0, 10)}..."
                                                        : data['name'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFD70B17),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Center(
                                                        child: Text(
                                                          data['rate'],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            //fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: (() {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Details(
                                                                about: data[
                                                                    'about'],
                                                                age:
                                                                    data['age'],
                                                                genre: data[
                                                                    'genre'],
                                                                image: data[
                                                                    'image'],
                                                                language: data[
                                                                    'language'],
                                                                name: data[
                                                                    'name'],
                                                                rate: data[
                                                                    'rate'],
                                                                releasedate: data[
                                                                    'releasedate'],
                                                                status: data[
                                                                    'status'],
                                                                url:
                                                                    data['url'],
                                                              )));
                                                }),
                                                child: Container(
                                                  width: double.infinity,
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: Center(
                                                    child: Text(
                                                      "Watch Now ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      )),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/listempty.png",
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              1.5,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      "Your List is Empty",
                                      style: TextStyle(
                                          color: Color(0xFFD70B17),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "it seems that you haven't added \n any movies to the list",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 14,
                                          //fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                );
                        }
                      } else {
                        return GridView(
                          padding: EdgeInsets.all(10),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 28 / 35),
                          primary: false,
                          shrinkWrap: true,
                          children: List<Widget>.generate(15, (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FadeShimmer(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 2,
                                radius: 8,
                                fadeTheme: FadeTheme.dark,
                              ),
                            );
                          }),
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView home(BuildContext context) {
    return SingleChildScrollView(
      //physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            initialPage: 0,
            indicatorColor: Colors.green,
            indicatorBackgroundColor: Colors.grey,
            children: _createChildren(),
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 3000,
            isLoop: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Releases",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: _createmoviecard(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drama",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Films')
                          .limit(5)
                          .where('genre', isEqualTo: 'Drama')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error = ${snapshot.error}');

                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Details(
                                                      about: data['about'],
                                                      age: data['age'],
                                                      genre: data['genre'],
                                                      image: data['image'],
                                                      language:
                                                          data['language'],
                                                      name: data['name'],
                                                      rate: data['rate'],
                                                      releasedate:
                                                          data['releasedate'],
                                                      status: data['status'],
                                                      url: data['url'],
                                                    )));
                                      }),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/noimage.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Hero(
                                            tag: data['url'],
                                            child: Image.network(
                                              data['image'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFD70B17),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              data['rate'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 6.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Films')
                        .limit(5)
                        .orderBy('about')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return CarouselSlider(
                            options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.85,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                height:
                                    MediaQuery.of(context).size.height / 4.5),
                            items: List<Widget>.generate(
                              docs.length,
                              (index) {
                                final data = docs[index].data();
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Details(
                                                      about: data['about'],
                                                      age: data['age'],
                                                      genre: data['genre'],
                                                      image: data['image'],
                                                      language:
                                                          data['language'],
                                                      name: data['name'],
                                                      rate: data['rate'],
                                                      releasedate:
                                                          data['releasedate'],
                                                      status: data['status'],
                                                      url: data['url'],
                                                    )));
                                      }),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/noimage.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            data['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    /* Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFD70B17),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              widget.rate[0],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )*/
                                  ],
                                );
                              },
                            ));
                      }
                      return CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Romance",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Films')
                          .limit(5)
                          .where('genre', isEqualTo: 'Romance')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error = ${snapshot.error}');

                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Details(
                                                      about: data['about'],
                                                      age: data['age'],
                                                      genre: data['genre'],
                                                      image: data['image'],
                                                      language:
                                                          data['language'],
                                                      name: data['name'],
                                                      rate: data['rate'],
                                                      releasedate:
                                                          data['releasedate'],
                                                      status: data['status'],
                                                      url: data['url'],
                                                    )));
                                      }),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/noimage.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Hero(
                                            tag: data['url'],
                                            child: Image.network(
                                              data['image'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFD70B17),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              data['rate'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 6.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Comedy",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Films')
                          .limit(5)
                          .where('genre', isEqualTo: 'Comedy')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error = ${snapshot.error}');

                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Details(
                                                      about: data['about'],
                                                      age: data['age'],
                                                      genre: data['genre'],
                                                      image: data['image'],
                                                      language:
                                                          data['language'],
                                                      name: data['name'],
                                                      rate: data['rate'],
                                                      releasedate:
                                                          data['releasedate'],
                                                      status: data['status'],
                                                      url: data['url'],
                                                    )));
                                      }),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/noimage.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Hero(
                                            tag: data['url'],
                                            child: Image.network(
                                              data['image'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFD70B17),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              data['rate'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 6.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FadeShimmer(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  radius: 8,
                                  fadeTheme: FadeTheme.dark,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
