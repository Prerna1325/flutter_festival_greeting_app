import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFestivalDescription extends StatefulWidget {
  MyFestivalDescription(
      {Key? key, this.festival_id, this.religions_id, this.image})
      : super(key: key);
  final dynamic festival_id;
  final religions_id;
  var image;

  @override
  State<MyFestivalDescription> createState() => _MyFestivalDescriptionState();
}

class _MyFestivalDescriptionState extends State<MyFestivalDescription> {
  final firebaseDb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    topRight: Radius.circular(80)),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Description: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            FestivalDescription()
          ],
        ),
      ),
    );
  }

  Widget FestivalDescription() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseDb
            .collection('festive_category')
            .where('festival_id', isEqualTo: widget.festival_id)
            .snapshots(),
        builder: (context, snapshot) {
          var description = snapshot.data?.docs[0]['description'];
          print(' description::::::::${description}');
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
          } else {


            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${description}',
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black)));
          }
        });
  }
}

