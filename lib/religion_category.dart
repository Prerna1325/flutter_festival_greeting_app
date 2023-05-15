import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_app/ad_banner.dart';
import 'package:festive_app/festive_category.dart';
import 'package:festive_app/new_bg_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_modal.dart';

class MyReligionScreen extends StatefulWidget {
  const MyReligionScreen({Key? key}) : super(key: key);

  @override
  State<MyReligionScreen> createState() => _MyReligionScreenState();
}

class _MyReligionScreenState extends State<MyReligionScreen> {

  late bool isLoading;
  bool isPressed = true;
  final colorModal = MyColorsModal();
  final firebaseDb = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? Offset(5, 5) : Offset(18, 18);
    double blur = isPressed ? 5.0 : 30.0;
    return Scaffold(
        body: MyBgScreen(
          height: 120,
          UpperChild: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Festival Greetings',
                style: GoogleFonts.alikeAngular(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
          ),
          LowerChild: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    ' Religions',
                    style: GoogleFonts.habibi(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: firebaseDb
                          .collection('religions_category')
                          .orderBy('religion_id', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
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
                        } else if (snapshot.data != null) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 0),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: InkWell(
                                          onTap: () {
                                            var religions_id = snapshot.data!
                                                .docs[index]['religion_id'];
                                            var name = snapshot.data!
                                                .docs[index]['religion_name'];
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyFestiveCategory(
                                                          //   religion_list: religion_list,
                                                          religions_id:
                                                              religions_id,
                                                          religion_name: name,
                                                        )));
                                          },
                                          child: Container(
                                              // height: MediaQuery.of(context)
                                              //     .size
                                              //     .height,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: blur,
                                                        spreadRadius: 4,
                                                        offset: -distance //New
                                                        ),
                                                    BoxShadow(
                                                      blurRadius: blur,
                                                      offset: distance,
                                                      color:
                                                          Colors.grey.shade600,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0)),
                                                        child: Image(
                                                          alignment:
                                                              Alignment.center,
                                                          image: NetworkImage(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'religion_image'],
                                                          ),
                                                          fit: BoxFit.fill,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20.0)),
                                                      child: Container(
                                                        height: 40,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffffdb24),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              snapshot.data
                                                                          ?.docs[
                                                                      index][
                                                                  'religion_name'],
                                                              style: GoogleFonts.habibi(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20)),
                                                        ),
                                                      ),
                                                    ),
                                                  ])),
                                        ),
                                      );
                                    })),
                          );
                        }
                        return Container();
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: AdBanner(),
                )
              ],
            ),
          ),
        ),

    );
  }
}
