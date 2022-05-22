import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DreamCard extends StatelessWidget {
  const DreamCard({Key? key, required this.title, required this.date})
      : super(key: key);

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    List icons = [Icons.location_on, Icons.people];
    List texts = ["Primary school", "You, sister, uncle, Patrick"];

    return Container(
      width: 80.w,
      height: 75.w,
      decoration: BoxDecoration(
          border: Border.all(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(4.w))),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 1.h,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.sp),
          ),
          Icon(
            Icons.remove_red_eye,
            size: 20.w,
          ),
          Text(
            date,
            style: TextStyle(fontSize: 18.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Wrap(
            direction: Axis.vertical,
            children: List.generate(icons.length, (int i) {
              return Padding(
                padding: EdgeInsets.only(top: 1.w),
                child: Row(
                  children: [
                    Icon(
                      icons[i],
                      size: 5.w,
                    ),
                    Text(" " + texts[i])
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
