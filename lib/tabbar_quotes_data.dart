import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_modal.dart';

class MyTabbarQuotes extends StatefulWidget {
  const MyTabbarQuotes({
    Key? key,
    required this.festival_id,
    required this.fest_category_qoutes,
  }) : super(key: key);
  final int fest_category_qoutes;
  final dynamic festival_id;

  @override
  State<MyTabbarQuotes> createState() => _MyTabbarQuotesState();
}

class _MyTabbarQuotesState extends State<MyTabbarQuotes> {
  bool isLoading = false;
  final colorModal = MyColorsModal();
  final firebaseDb = FirebaseFirestore.instance;
  var festCountry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseDb
            .collection('festive_category')
            .where('festival_id', isEqualTo: widget.festival_id)
            //.orderBy("date",descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
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
            );
          } else if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data?.docs[0]['quotes'].length,
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      margin: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20.0)),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      margin: EdgeInsets.all(22),
                      child: Center(
                          child: SelectableText(
                        snapshot.data!.docs[0]['quotes'][index],
                        style: GoogleFonts.alegreya(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        onTap: () {
                          print('Tapped');
                        },
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                        showCursor: true,
                        cursorWidth: 2,
                        cursorColor: Colors.red,
                        cursorRadius: Radius.circular(5),
                      )),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, //New
                                blurRadius: 5.0,
                                offset: Offset(10, 10))
                          ],
                          gradient: colorModal.getGradientColors()[index % 12],
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(20.0)),
                    );
                  }
                });
          }
          return Container();
        },
      ),
    );
  }
}
