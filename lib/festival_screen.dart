import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_app/festive_category.dart';
import 'package:festive_app/my_festival_description.dart';
import 'package:festive_app/new_bg_screen.dart';
import 'package:festive_app/religion_category.dart';
import 'package:festive_app/tabbar_images_data.dart';
import 'package:festive_app/tabbar_quotes_data.dart';
import 'package:flutter/material.dart';

class MyFestivalScreen extends StatefulWidget {
  MyFestivalScreen(
      {Key? key,
      required this.fest_category_id,
      required this.fest_category_quotes,
      required this.name,
      this.id,
      this.religion_name,
      this.image,
      this.religions_id})
      : super(key: key);
  final int fest_category_id;
  final int fest_category_quotes;
  final String name;
  var religion_name;
  final religions_id;
  var id;
  var image;

  @override
  State<MyFestivalScreen> createState() => _MyFestivalScreenState();
}

class _MyFestivalScreenState extends State<MyFestivalScreen>
    with TickerProviderStateMixin {
  List<Widget> tabbarViews = [];

  final firebaseDb = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabbarViews = [
      MyFestivalDescription(
        image: widget.image,
        festival_id: widget.id,
      ),
      MyTabbarImagesData(
        id: widget.id,
        fest_category_id: widget.fest_category_id,
      ),
      MyTabbarQuotes(
          festival_id: widget.id,
          fest_category_qoutes: widget.fest_category_quotes),
    ];
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return DefaultTabController(
        length: 3
        ,
        child: Scaffold(
          body: MyBgScreen(
            height: 120,
            UpperChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyFestiveCategory(
                                      religions_id: widget.religions_id,
                                      religion_name: widget.religion_name,
                                    )));
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
                // SizedBox(width: 50,),

                Expanded(
                  flex: 3,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
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
            LowerChild: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 5, right: 15, bottom: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: SizedBox(
                          height: 40,
                          child: TabBar(
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xffffdb24)),
                            controller: tabController,
                            isScrollable: true,
                            labelPadding: EdgeInsets.symmetric(horizontal: 30),
                            tabs: [
                              Tab(
                                child: Text(
                                  'About',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff361c56),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Images',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff361c56),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Quotes',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff361c56),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarView(
                        controller: tabController, children: tabbarViews),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
