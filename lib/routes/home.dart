import 'package:dreamcatcher/components/dream_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool clickedSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: SizedBox(
          width: 100.w,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    width: 100.w,
                    child: Row(
                      children: [
                        // TODO: Fade search bar
                        Expanded(
                          child: clickedSearchBar
                              ? TextFormField()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Good morning,",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      "Selen",
                                      style: TextStyle(fontSize: 16.sp),
                                    )
                                  ],
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              clickedSearchBar = true;
                            });
                          },
                          child: Icon(
                            Icons.search,
                            size: 10.w,
                          ),
                        ),
                        Icon(
                          Icons.person,
                          size: 10.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80.w,
                    height: 88.h,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 2,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return const DreamCard(
                            title: "Happy Mouse", date: "18.02.2022");
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 4.h,
                  right: 5.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "create_dream");
                    },
                    elevation: 0,
                    shape: CircleBorder(
                        side: BorderSide(width: 0.4.w, color: Colors.black)),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
