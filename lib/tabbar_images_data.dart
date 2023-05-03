import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_app/images_screen.dart';
import 'package:flutter/material.dart';

class MyTabbarImagesData extends StatefulWidget {
  MyTabbarImagesData(
      {Key? key, this.fest_category_id, this.religions_id, this.id})
      : super(key: key);

  var fest_category_id;
  var id;
  var religions_id;

  @override
  State<MyTabbarImagesData> createState() => _MyTabbarImagesDataState();
}

class _MyTabbarImagesDataState extends State<MyTabbarImagesData> {
  bool isLoading = false;
  final firebaseDb = FirebaseFirestore.instance;

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
    await Future.delayed(Duration(seconds: 1), () {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: StreamBuilder<QuerySnapshot>(
          stream: firebaseDb
              .collection('festive_category')
              .where("festival_id", isEqualTo: widget.id)
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
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 19,
                      crossAxisSpacing: 15),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs[0]["image"].length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                      );
                    } else {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImageScreen(
                                                fest_category_quotes:
                                                    widget.fest_category_id,
                                                fest_category_id:
                                                    widget.fest_category_id,
                                                name: snapshot.data!.docs[0]
                                                    ['name'],
                                                image: snapshot.data!.docs[0]
                                                    ['image'][index])));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Hero(
                                      tag: 'background ${index}',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          snapshot.data?.docs[0]['image']
                                              [index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // InkWell(
                              //     onTap: () async {
                              //       final url = Uri.parse(snapshot
                              //               .data?.docs[widget.fest_category_id]
                              //           ['image'][index]);
                              //       final res = await http.get(url);
                              //       final bytes = res.bodyBytes;
                              //       final temp = await getTemporaryDirectory();
                              //       final path = '${temp.path}/image.jpg';
                              //       File(path).writeAsBytes(bytes);
                              //
                              //       await Share.shareFiles([path]);
                              //     },
                              //     child: Container(
                              //       height: 40,
                              //       width: double.infinity,
                              //       decoration:
                              //           BoxDecoration(color: Color(0xffffdb24)),
                              //       child: Icon(
                              //         Icons.ios_share_rounded,
                              //         size: 30,
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }
            return Container();
          }),
    ));
  }
}
