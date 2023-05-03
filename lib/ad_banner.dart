import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  AdBanner({Key? key}) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

BannerAd? myBanner;

class _AdBannerState extends State<AdBanner> {
  @override
  void initState() {
    // TODO: implement initState
    myBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/2934735716',
        listener: BannerAdListener(),
        request: AdRequest());
    myBanner?.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: myBanner!);
    final Container adContainer = Container(
      child: adWidget,
      width: myBanner?.size.width.toDouble(),
      height: myBanner?.size.height.toDouble(),
    );
    return Scaffold(
      body: content(adContainer),
    );
  }

  Widget content(Widget ads) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ads,
    );
  }
}
