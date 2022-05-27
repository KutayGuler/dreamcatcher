import 'package:flutter/material.dart';
import 'package:dreamcatcher/components/dream_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sizer/sizer.dart';

import '../observables.dart';

class DreamsList extends StatefulWidget {
  const DreamsList({Key? key}) : super(key: key);

  @override
  State<DreamsList> createState() => _DreamsListState();
}

class _DreamsListState extends State<DreamsList> {
  bool clickedSearchBar = false;
  String _titleFilter = "";
  Duration searchFadeDuration = const Duration(milliseconds: 200);

  // TODO: (later) Skeleton loading

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        width: 100.w,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
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
                              // TODO: Add a visual filter component that filters by date, place, people
                            ),
                            AnimatedContainer(
                              duration: searchFadeDuration,
                              child: IconButton(
                                onPressed: () => setState(() {
                                  clickedSearchBar = !clickedSearchBar;
                                }),
                                iconSize: 10.w,
                                icon: Icon(
                                  clickedSearchBar
                                      ? Icons.search_off
                                      : Icons.search,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.person),
                              iconSize: 10.w,
                              onPressed: () {
                                Navigator.pushNamed(context, 'profile');
                              },
                            ),
                          ],
                        ),
                      ),
                      Observer(builder: (context) {
                        return g<S>().allData["dreams"]?.length != 0
                            ? Wrap(
                                runSpacing: 4.h,
                                children: List.generate(
                                    g<S>().sortedDreams.length + 1,
                                    (int index) {
                                  if (index == 0) {
                                    var len = g<S>().sortedDreams.length;

                                    return AnimatedContainer(
                                      width: 80.w,
                                      height: clickedSearchBar ? 15.h : 0,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: clickedSearchBar
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: TextField(
                                                    onChanged: (String title) {
                                                      setState(() =>
                                                          _titleFilter = title);
                                                      g<S>().sortDreamsByTitle(
                                                          title);
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Search for a dream",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 2),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                AnimatedOpacity(
                                                  opacity: _titleFilter == ""
                                                      ? 0
                                                      : 1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeOut,
                                                  child: Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.w),
                                                      child: Text(
                                                          "found ${len == 0 ? "no" : len} matching dream${len > 1 ? "s" : ""}"),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    );
                                  }

                                  var dream = g<S>().sortedDreams[index - 1];

                                  return DreamCard(
                                    title: dream['title'],
                                    date: dream['date'],
                                    places: dream['places'],
                                    people: dream['people'],
                                    id: dream['id'],
                                  );
                                }),
                              )
                            : SizedBox(
                                height: 50.h,
                                child: const Center(
                                  child: Text(
                                      "You have not logged any dreams yet."),
                                ),
                              );
                      })
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
