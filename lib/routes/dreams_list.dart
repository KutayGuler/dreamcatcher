import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dreamcatcher/components/dream_card.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class DreamsList extends StatefulWidget {
  const DreamsList({Key? key}) : super(key: key);

  @override
  State<DreamsList> createState() => _DreamsListState();
}

class _DreamsListState extends State<DreamsList> {
  bool clickedSearchBar = false;
  Duration searchFadeDuration = const Duration(milliseconds: 200);

  late Map<String, dynamic> dreams;
  late List<dynamic> sorted;
  bool dataLoaded = false;

  // Fetch content from the json file
  // TODO: Lift the dreams to mobx
  void readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final jsonData = await json.decode(response);
    setState(() {
      dreams = jsonData["dreams"];
      sorted = dreams.values.toList();
      sorted.sort((a, b) => b['date'].compareTo(a['date']));
      dataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!clickedSearchBar) return;
        setState(() => clickedSearchBar = false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: 100.w,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 5.w, bottom: 5.w, left: 10.w, right: 10.w),
                        width: 100.w,
                        child: Row(
                          children: [
                            Expanded(
                              child: AnimatedCrossFade(
                                duration: searchFadeDuration,
                                firstChild: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Good morning,",
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                    Text(
                                      "Selen",
                                      style: TextStyle(fontSize: 18.sp),
                                    )
                                  ],
                                ),
                                secondChild: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search for a dream",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    border: OutlineInputBorder(),
                                    suffixIconColor: Colors.black,
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                ),
                                crossFadeState: clickedSearchBar
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickedSearchBar = true;
                                });
                              },
                              child: AnimatedContainer(
                                duration: searchFadeDuration,
                                child: clickedSearchBar
                                    ? Container()
                                    : Icon(
                                        Icons.search,
                                        size: clickedSearchBar ? 0 : 10.w,
                                      ),
                              ),
                            ),
                            AnimatedCrossFade(
                              duration: searchFadeDuration,
                              firstChild: Icon(
                                Icons.person,
                                size: 10.w,
                              ),
                              secondChild: IconButton(
                                icon: Icon(
                                  Icons.filter_list,
                                  size: 10.w,
                                ),
                                onPressed: () {},
                              ),
                              crossFadeState: clickedSearchBar
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            )
                          ],
                        ),
                      ),
                      dataLoaded
                          ? Wrap(
                              runSpacing: 4.h,
                              children:
                                  List.generate(dreams.length, (int index) {
                                var key = dreams.keys.firstWhere(
                                    (id) => id == sorted[index]["id"]);
                                return DreamCard(
                                  title: dreams[key]['title'],
                                  date: dreams[key]['date'],
                                  places: dreams[key]['places'],
                                  people: dreams[key]['people'],
                                  id: dreams[key]['id'],
                                );
                              }),
                            )
                          : Container()
                    ],
                  ),
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
