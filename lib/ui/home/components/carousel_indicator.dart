import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/carousel_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselIndicator extends StatelessWidget {
  final List<String> imageURLs;

  CarouselIndicator(this.imageURLs);

  @override
  Widget build(BuildContext context) {
    CarouselProvider carousel = Provider.of<CarouselProvider>(context);

    return Row(
      children: imageURLs.map((url) {
        int index = imageURLs.indexOf(url);
        return Container(
          width: (carousel.current == index) ? 14.r : 8.r,
          height: 8.r,
          margin: EdgeInsets.symmetric(
            horizontal: 3.r,
          ),
          decoration: BoxDecoration(
            shape: (carousel.current == index) ? BoxShape.rectangle : BoxShape.circle,
            color: (carousel.current == index) ? accentColor : baseColor,
            borderRadius: (carousel.current == index) ? BorderRadius.circular(8) : null,
          ),
        );
      }).toList(),
    );
  }
}