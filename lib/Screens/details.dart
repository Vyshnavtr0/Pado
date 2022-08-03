import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:mavoz/Models/HistoryModel.dart';
import 'package:mavoz/Models/ListModel.dart';
import 'package:numeral/numeral.dart';
import 'package:pod_player/pod_player.dart';
import 'package:readmore/readmore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Details extends StatefulWidget {
  final String name;
  final String rate;
  final String image;
  final String url;
  final String releasedate;
  final String age;
  final String language;
  final String status;
  final String genre;
  final String about;
  const Details({
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
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late final PodPlayerController controller;
  history() async {
    var tt = widget.url.substring(16);
    historymodel listModel = historymodel();
    listModel.about = widget.about;
    listModel.age = widget.age;
    listModel.genre = widget.genre;
    listModel.image = widget.image;
    listModel.language = widget.language;
    listModel.name = widget.name;
    listModel.rate = widget.rate;
    listModel.releasedate = widget.releasedate;
    listModel.time = DateTime.now().millisecondsSinceEpoch.toString();
    listModel.status = widget.status;
    listModel.url = widget.url;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser?.uid.toString())
        .collection('History')
        .doc(tt)
        .set(listModel.toMap());
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    controller = PodPlayerController(
      podPlayerConfig: PodPlayerConfig(
        autoPlay: false,
        initialVideoQuality: 720,
      ),
      playVideoFrom: widget.url.contains('youtu.be')
          ? PlayVideoFrom.youtube(
              widget.url,
            )
          : PlayVideoFrom.network(
              widget.url,
            ),
    )..initialise();
    history();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181a20),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AvatarGlow(
          glowColor: Colors.black,
          endRadius: 30.0,
          child: IconButton(
              icon: Icon(FontAwesomeIcons.angleLeft),
              onPressed: (() {
                Navigator.of(context).pop();
              })),
        ),
        actions: [
          AvatarGlow(
            glowColor: Colors.black,
            endRadius: 30.0,
            child: IconButton(icon: Icon(Icons.cast), onPressed: (() {})),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              //height: MediaQuery.of(context).size.height / 3.5,
              child: Stack(
                children: [
                  Container(
                    //height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: widget.url,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: PodVideoPlayer(
                        controller: controller,
                        //frameAspectRatio: 19 / 13,

                        backgroundColor: Colors.transparent,
                        podProgressBarConfig: PodProgressBarConfig(
                            playingBarColor: Colors.green,
                            circleHandlerColor: Colors.green)),
                  ),
                  /*Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 5,
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
                  ),*/
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      LikeButton(
                        size: 35,
                        circleColor: CircleColor(
                            start: Colors.red, end: Color(0xFFD70B17)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xFFD70B17),
                          dotSecondaryColor: Colors.red,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            FontAwesomeIcons.heart,
                            //size: 18,
                            color: isLiked ? Color(0xFFD70B17) : Colors.grey,
                          );
                        },
                      ),
                      IconButton(
                          color: Colors.grey,
                          icon: FaIcon(FontAwesomeIcons.paperPlane),
                          onPressed: (() {}))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.starHalfStroke,
                        size: 18,
                        color: Color(0xFFD70B17),
                      ),
                      Text(
                        " ${widget.rate} >",
                        style: TextStyle(
                          color: Color(0xFFD70B17),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        " ${widget.releasedate}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFD70B17))),
                        child: Text(
                          widget.age,
                          style: TextStyle(
                            color: Color(0xFFD70B17),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFD70B17))),
                        child: Text(
                          widget.language,
                          style: TextStyle(
                            color: Color(0xFFD70B17),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green)),
                        child: Text(
                          widget.status,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.play();
                            controller.enableFullScreen();
                          },
                          child: Container(
                            // margin: const EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFD70B17),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xFFD70B17),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.circlePlay,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "  Play  ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var tt = widget.url.substring(16);
                            listmodel listModel = listmodel();
                            listModel.about = widget.about;
                            listModel.age = widget.age;
                            listModel.genre = widget.genre;
                            listModel.image = widget.image;
                            listModel.language = widget.language;
                            listModel.name = widget.name;
                            listModel.rate = widget.rate;
                            listModel.releasedate = widget.releasedate;
                            listModel.search = widget.name;
                            listModel.status = widget.status;
                            listModel.url = widget.url;
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(auth.currentUser?.uid.toString())
                                .collection('MyList')
                                .doc(tt)
                                .set(listModel.toMap());
                            showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  backgroundColor: Colors.green,
                                  message: "Added to your watch list ",
                                ));
                          },
                          child: Container(
                            // margin: const EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    " My List ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Genre : ${widget.genre}",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ReadMoreText(
                        widget.about,
                        trimLines: 3,
                        colorClickableText: Color(0xFFD70B17),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          //fontWeight: FontWeight.bold
                        ),
                        lessStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD70B17)),
                        moreStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD70B17)),
                      )),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child:
                              TabBar(indicatorColor: Color(0xFFD70B17), tabs: [
                            Tab(text: "More Like This"),
                            Tab(text: "Comments"),
                          ]),
                        ),
                        Container(
                          //Add this to give height
                          height: MediaQuery.of(context).size.height / 3,
                          child: TabBarView(children: [
                            Container(
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('Films')
                                    .where('genre',
                                        isGreaterThanOrEqualTo: widget.genre)
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasError)
                                    return Text('Error = ${snapshot.error}');

                                  if (snapshot.hasData) {
                                    final docs = snapshot.data!.docs;

                                    return GridView(
                                        padding: EdgeInsets.only(top: 10),
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
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
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Details(
                                                                          about:
                                                                              data['about'],
                                                                          age: data[
                                                                              'age'],
                                                                          genre:
                                                                              data['genre'],
                                                                          image:
                                                                              data['image'],
                                                                          language:
                                                                              data['language'],
                                                                          name:
                                                                              data['name'],
                                                                          rate:
                                                                              data['rate'],
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
                                                            6,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
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
                                                          BorderRadius.circular(
                                                              8),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                )
                                              ],
                                            );
                                          },
                                        ));
                                  }

                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    child: GridView(
                                      padding: EdgeInsets.only(top: 10),
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 9 / 6),
                                      primary: false,
                                      shrinkWrap: true,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: FadeShimmer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            radius: 8,
                                            fadeTheme: FadeTheme.dark,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: FadeShimmer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            radius: 8,
                                            fadeTheme: FadeTheme.dark,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: FadeShimmer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            radius: 8,
                                            fadeTheme: FadeTheme.dark,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: FadeShimmer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
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
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${Numeral(10).format()} Comments",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
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
                                  Column(
                                    children: [
                                      ListTile(
                                        trailing: IconButton(
                                            color: Colors.white,
                                            icon: Icon(Icons.pending_outlined),
                                            onPressed: () {}),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.network(
                                              "https://res.cloudinary.com/dvhlfyvrr/image/upload/v1653224954/sample.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "Kristin Watson",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            ReadMoreText(
                                              'Village Cricket Boy..! A heartwarming story of a boy who loved cricket and Sachin with a glimpse of love, joy, innocence and pain. Starring Master Davinchi, Divya Gopinath, Master Athulkrishna, Prema chandran, Tresa Poulose and a lot of new faces. ',
                                              trimLines: 2,
                                              colorClickableText:
                                                  Color(0xFFD70B17),
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                //fontWeight: FontWeight.bold
                                              ),
                                              lessStyle: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD70B17)),
                                              moreStyle: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD70B17)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                LikeButton(
                                                  size: 25,
                                                  circleColor: CircleColor(
                                                      start: Colors.red,
                                                      end: Color(0xFFD70B17)),
                                                  bubblesColor: BubblesColor(
                                                    dotPrimaryColor:
                                                        Color(0xFFD70B17),
                                                    dotSecondaryColor:
                                                        Colors.red,
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      isLiked
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      size: 18,
                                                      color: isLiked
                                                          ? Color(0xFFD70B17)
                                                          : Colors.grey,
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${Numeral(10).format()}",
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "3 day ago",
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
