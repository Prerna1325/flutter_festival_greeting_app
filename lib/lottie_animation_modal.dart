import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'festival_screen.dart';

class MyLottieAnimation extends StatefulWidget {
  MyLottieAnimation(
      {Key? key,
      required this.id,
      required this.festival_image,
      required this.festival_quotes,
      this.religions_id,
      this.image,
      this.religion_name})
      : super(key: key);
  final String id;
  final int festival_image;
  final int festival_quotes;
  var religions_id;
  var religion_name;
  var image;

  @override
  State<MyLottieAnimation> createState() => _MyLottieAnimationState();
}

class _MyLottieAnimationState extends State<MyLottieAnimation>
    with TickerProviderStateMixin {
  final firebaseDb = FirebaseFirestore.instance;
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // String getAnimPath(String id) {
  //   switch (id) {
  //     case "0":
  //       return 'assets/animations/dussehra.json';
  //       break;
  //     case "1":
  //       return 'assets/animations/holi colour.json';
  //       break;
  //     case "2":
  //       return 'assets/animations/77204-kalash.json';
  //       break;
  //     case "3":
  //       return 'assets/animations/77204-kalash.json';
  //       break;
  //     case "4":
  //       return 'assets/animations/129129-happy-ganesh-chaturthi-wishes.json';
  //       break;
  //     case "5":
  //       return 'assets/animations/72875-raksha-bandhan.json';
  //       break;
  //     case "6":
  //       return 'assets/animations/101354-durga-ma.json';
  //       break;
  //     case "7":
  //       return 'assets/animations/93591-merry-christmas.json';
  //       break;
  //     case "8":
  //       return 'assets/animations/82933-happy-diwali.json';
  //       break;
  //     case "9":
  //       return 'assets/animations/91901-happy-lohri.json';
  //       break;
  //     default:
  //       return 'assets/animations/dussehra.json';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: firebaseDb
              .collection('festive_category')
              .where("festival_id", isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ));
            }
            return Center(
              child: Lottie.network(snapshot.data!.docs[0]['animation'],
                  fit: BoxFit.cover,
                  controller: _controller, onLoaded: (compos) {
                _controller
                  ..duration = Duration(milliseconds: 1000)
                  ..forward().whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFestivalScreen(
                                id: widget.id,
                                image: snapshot.data!.docs[0]['image'][0],
                                religion_name: widget.religion_name,
                                religions_id: widget.religions_id,
                                fest_category_id: widget.festival_image,
                                fest_category_quotes: widget.festival_quotes,
                                name: snapshot.data!.docs[0]['name'],
                              ))));
              }),
            );
            // return lottieAnimation(snapshot, getAnimPath(widget.id));
          }),
    );
  }

// Widget lottieAnimation(AsyncSnapshot snapshot, String path) {
//   return Center(
//     child: Lottie.asset(path, controller: _controller, onLoaded: (compos) {
//       _controller
//         ..duration = Duration(milliseconds: 1000)
//         ..forward().whenComplete(() => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => MyFestivalScreen(
//                       fest_category_id: widget.festival_image,
//                       fest_category_quotes: widget.festival_quotes,
//                       name: snapshot.data!.docs[0]['name'],
//                       selectedCountry: widget.selectedCountry,
//                     ))));
//     }),
//   );
// }
}
