import 'dart:io';
import 'package:festive_app/new_bg_screen.dart';
import 'package:festive_app/religion_category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen(
      {Key? key,
      required this.image,
      required this.name,
      required this.fest_category_id,
      required this.fest_category_quotes})
      : super(key: key);
  final String image;
  final String name;
  final int fest_category_id;
  final int fest_category_quotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyBgScreen(
      height: 150,
      UpperChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyReligionScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Lottie.asset(
                            'assets/animations/93492-home-icon.json',
                            width: 42,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      LowerChild: Hero(
        tag: 'background',
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    topRight: Radius.circular(80)),
                color: Color(0xff361c56),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 12.0,
                    spreadRadius: 2,
                    offset: Offset(
                      -10,
                      15,
                    ),
                  )
                ]),
            child: SingleChildScrollView(
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            final url = Uri.parse(image);
                            final res = await http.get(url);
                            final bytes = res.bodyBytes;
                            final temp = await getTemporaryDirectory();
                            final path = '${temp.path}/image.jpg';
                            File(path).writeAsBytes(bytes);

                            await Share.shareFiles([path]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffffdb24),
                                borderRadius: BorderRadius.circular(10)),
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Share ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Lottie.network(
                                    'https://assets6.lottiefiles.com/packages/lf20_b1h2fd/share_02.json',
                                    width: 40,
                                  )
                                  // Image.asset(
                                  //   'assets/images/export-share-icon.webp',
                                  //   height: 22,
                                  // )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          // onTap: () async {
                          //   final url = Uri.parse(image);
                          //   print('url of image: ...................${url}');
                          //   final tempDir = await getTemporaryDirectory();
                          //   final path = '${tempDir.path}/myfile.jpg';
                          //   await Dio().download(url.toString(), path);
                          //   await GallerySaver.saveImage(path, toDcim: true)
                          //       .then((value) => {print('Image is saved')});
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text('Downloaded to gallery. ')));
                          // },
                          child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffdb24),
                            borderRadius: BorderRadius.circular(10)),
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' Download',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Lottie.network(
                                  'https://assets4.lottiefiles.com/packages/lf20_hdmkzp2n.json',
                                  width: 55)

                              //Icon(Icons.download),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    ));
  }
}
