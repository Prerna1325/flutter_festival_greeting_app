import 'dart:ui';
import 'package:festive_app/lottie_animation_modal.dart';
import 'package:festive_app/new_bg_screen.dart';
import 'package:festive_app/religion_category.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFestiveCategory extends StatefulWidget {
  MyFestiveCategory(
      {Key? key, this.religions_id, this.religion_name, this.religion_list})
      : super(key: key);
  var religions_id;
  var religion_name;
  var religion_list;

  @override
  State<MyFestiveCategory> createState() => _MyFestiveCategoryState();
}

class _MyFestiveCategoryState extends State<MyFestiveCategory> {
  bool isPressed = true;
  bool? isLoading;

  final firebaseDb = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    Offset distance = isPressed ? Offset(5, 5) : Offset(18, 18);
    double blur = isPressed ? 5.0 : 30.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: MyBgScreen(
          height: 150,
          UpperChild: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyReligionScreen()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.religion_name + " Festivals",
                        style: GoogleFonts.habibi(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyReligionScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.home_rounded,
                                    size: 30,
                                    color: Color(0xff331c50),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          LowerChild: Padding(
            padding:
                const EdgeInsets.only(top: 26, left: 10, right: 10, bottom: 5),
            child: StreamBuilder<QuerySnapshot>(
                stream: firebaseDb
                    .collection('festive_category')
                    .orderBy('date', descending: false)
                    .where('religion_id', isEqualTo: widget.religions_id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Loading ...',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  } else {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 4),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isPressed = !isPressed;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyLottieAnimation(
                                              image: snapshot.data!.docs[index]
                                                  ['image'][0],
                                              id: snapshot.data!.docs[index]
                                                  ['festival_id'],
                                              religions_id: widget.religions_id,
                                              religion_name:
                                                  widget.religion_name,
                                              festival_image: index,
                                              festival_quotes: index,
                                            )));
                              });
                            },
                            child: Hero(
                              tag: 'button1 ${index}',
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                  top: 15,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: blur,
                                          spreadRadius: 0,
                                          offset: -distance //New
                                          ),
                                      BoxShadow(
                                        blurRadius: blur,
                                        offset: distance,
                                        color: Colors.grey.shade600,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0)),
                                        child: Image(
                                          alignment: Alignment.center,
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]['image']
                                                [0],
                                          ),
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        color: Color(0xffffdb24),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                snapshot.data?.docs[index]
                                                    ['name'],
                                                style: GoogleFonts.habibi(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 21)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "${DateFormat.yMMMMd().format(DateTime.parse(snapshot.data!.docs[index]['date']))}",
                                    //   style: GoogleFonts.alegreya(
                                    //       color: Colors.indigo,
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 20),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
