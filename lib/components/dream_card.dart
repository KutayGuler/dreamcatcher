import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../observables.dart';

class DreamCard extends StatelessWidget {
  const DreamCard(
      {Key? key,
      required this.title,
      required this.date,
      required this.places,
      required this.people,
      required this.id})
      : super(key: key);

  final String title;
  final String date;
  final List places;
  final List people;
  final String id;

  @override
  Widget build(BuildContext context) {
    List icons = [Icons.location_on, Icons.people];

    DateTime pd = DateTime.parse(date); // parsed date
    String formattedDate = "${pd.day}/${pd.month}/${pd.year}";

    return GestureDetector(
      onTap: () {
        g<S>().setCurrentDreamID(id);
        Navigator.pushNamed(context, "dream_details");
      },
      child: Container(
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
              formattedDate,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 1.h,
            ),
            ...List.generate(icons.length, (int i) {
              var arr = i == 0 ? places : people;
              if (arr.isEmpty) return Container();
              // TODO: Set max display length for these things (Google)

              return Padding(
                padding: EdgeInsets.only(top: 1.w),
                child: Row(
                  children: [
                    Icon(
                      icons[i],
                      size: 5.w,
                    ),
                    for (var j = 0; j < arr.length; j++)
                      Text(
                        " " +
                            arr[j].toString() +
                            (j + 1 == arr.length ? "" : ","),
                        style: TextStyle(fontSize: 14.sp),
                      )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
