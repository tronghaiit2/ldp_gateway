import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

final List<String> imgList = [
  "assets/images/Logo.png",
  "assets/images/main_icon.png",
  "assets/images/Logo.png",
  "assets/images/Logo.png",
  "assets/images/main_icon.png",
];

final List<Widget> imageSliders = imgList
    .map((item) => coinInformation())
    .toList();

Container coinInformation() {
  return Container(
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.inputBorder,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
        color: AppColors.gray,
      ),
      padding: EdgeInsets.only(top: 10, bottom: 5),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Bitcoin', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.main_blue,),
              overflow: TextOverflow.ellipsis),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blue,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
                foregroundImage: AssetImage('assets/images/main_icon.png')),
          ),
          GridView.count(
            primary: false,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 2,
            childAspectRatio: 5,
            children: <Widget>[
              Text('Khả dụng', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,),
                  overflow: TextOverflow.ellipsis),
              Text('Đã dùng', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,),
                  overflow: TextOverflow.ellipsis),
              Text('100000\$', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red200,),
                  overflow: TextOverflow.ellipsis),
              Text('100000\$', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red150,),
                  overflow: TextOverflow.ellipsis),

            ],
          )
        ],
      )
  );
}

class ConisCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConisCarouselState();
}

class _ConisCarouselState extends State<ConisCarousel> {
  int _current = 0;
  int _max = imgList.length;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 0.8,
              enlargeCenterPage: false,
              pageSnapping: true,
              aspectRatio: 1.75,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Text((_current+1).toString() + "/" + _max.toString(), textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.main_blue,),
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}
