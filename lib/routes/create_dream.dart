import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CreateDream extends StatefulWidget {
  const CreateDream({Key? key}) : super(key: key);

  @override
  State<CreateDream> createState() => _CreateDreamState();
}

class _CreateDreamState extends State<CreateDream> {
  late List<bool> isSelectedEmotions = [
    false,
    false,
    false,
    false,
    false,
    false
  ];
  late List<bool> isSelectedPlaces;
  late List<bool> isSelectedPeople;
  late Map<String, dynamic> data;

  static const List<IconData> icons = [
    Icons.sentiment_satisfied_outlined,
    Icons.sentiment_dissatisfied_outlined,
    Icons.monitor_heart_outlined,
    Icons.videogame_asset,
    Icons.category,
    Icons.cake,
  ];

  // TODO: Add new people/places to data.json with input
  // TODO: Add new dream to data.json on save
  // TODO: Save date as string
  // TODO: Change input to modal
  // TODO: Form validation
  // TODO: Add snackbar on save success

  DateTime selectedDate = DateTime.now();

  bool addNewPlace = false;
  bool addNewPerson = false;
  bool saved = false;
  bool dataLoaded = false;

  void readJson() async {
    print('called');
    final String response = await rootBundle.loadString('assets/data.json');
    final jsonData = await json.decode(response);

    setState(() {
      data = jsonData;
      isSelectedPlaces = List.generate(data['places'].length, (index) => false);
      isSelectedPeople = List.generate(data['people'].length, (index) => false);
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
    Color primaryColor = Theme.of(context).primaryColor;
    Color primaryColorDark = Theme.of(context).primaryColorDark;

    void popAlert() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Dream not saved'),
              content: const Text('Changes will be discarded'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        if (saved) return true;
        popAlert();
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                child: Wrap(
                  spacing: 2.h,
                  runSpacing: 2.h,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            size: 5.w,
                          ),
                          onPressed: () {
                            if (saved) Navigator.pop(context);
                            popAlert();
                          },
                        ),
                        SizedBox(
                          width: 70.w,
                          child: const TextField(
                            decoration:
                                InputDecoration(hintText: "Untitled Dream"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 84.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          TextButton(
                            child: Row(
                              children: [
                                Text(
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ",
                                  style: TextStyle(color: primaryColorDark),
                                ),
                                Icon(
                                  Icons.date_range,
                                  size: 5.w,
                                  color: primaryColorDark,
                                )
                              ],
                            ),
                            onPressed: () => showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2023),
                            ).then((currentDate) {
                              if (currentDate is! DateTime) return;
                              setState(() => selectedDate = currentDate);
                            }),
                          ),
                        ],
                      ),
                    ),
                    const InputLabel(label: "theme"),
                    SizedBox(
                      width: 84.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(isSelectedEmotions.length, (i) {
                          return Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              color: isSelectedEmotions[i]
                                  ? primaryColor
                                  : Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 0.5.w),
                              borderRadius: BorderRadius.circular(0.5.w),
                            ),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              iconSize: 5.w,
                              icon: Icon(
                                icons[i],
                                color: Colors.black,
                              ),
                              onPressed: () => setState(() =>
                                  isSelectedEmotions[i] =
                                      !isSelectedEmotions[i]),
                            ),
                          );
                        }),
                      ),
                    ),
                    for (int i = 0; i < 2; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i == 0 ? "places" : "people",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          dataLoaded
                              ? AnimatedCrossFade(
                                  firstChild: SizedBox(
                                    width: 84.w,
                                    child: Wrap(
                                      spacing: 2.w,
                                      children: List.generate(
                                          i == 0
                                              ? data['places'].length + 1
                                              : data['people'].length + 1,
                                          (int index) {
                                        if ((i == 0 &&
                                                index ==
                                                    data['places'].length) ||
                                            index == data['people'].length) {
                                          return IconButton(
                                            icon: Icon(i == 0
                                                ? Icons.add_location_alt
                                                : Icons.person_add),
                                            onPressed: () {},
                                          );
                                        }

                                        var arr = i == 0
                                            ? isSelectedPlaces
                                            : isSelectedPeople;

                                        return TextButton(
                                          onPressed: () {
                                            setState(() {
                                              arr[index] = !arr[index];
                                            });
                                          },
                                          child: Text(
                                            i == 0
                                                ? data['places'][index]
                                                : data['people'][index],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: arr[index]
                                                ? primaryColor
                                                : Colors.white,
                                            side: BorderSide(
                                                width: 0.5.w,
                                                color: Colors.black),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  secondChild: SizedBox(
                                    width: 70.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: TextField(
                                        onSubmitted: (String val) {},
                                        maxLength: 32,
                                        decoration: InputDecoration(
                                          hintText: i == 0
                                              ? "Enter a new place"
                                              : "Enter a new person",
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.cancel),
                                            onPressed: () {
                                              setState(() {
                                                i == 0
                                                    ? addNewPlace = false
                                                    : addNewPerson = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  crossFadeState: (i == 0 && addNewPlace) ||
                                          (i == 1 && addNewPerson)
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 200),
                                )
                              : Container(),
                        ],
                      ),
                    const InputLabel(label: "description"),
                    SizedBox(
                      height: 30.h,
                      width: 84.w,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "I was ..."),
                        maxLines: null, // required for expands attribute
                        expands: true,
                        maxLength: 1000,
                      ),
                    ),
                    const InputLabel(label: "drawings"),
                    SizedBox(
                      height: 30.h,
                      width: 84.w,
                      child: Center(
                        child: IconButton(
                          iconSize: 20.h,
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Center(
                      child: OutlinedButton(
                        onPressed: () => saved = true,
                        child: const Text(
                          "save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(84.w, 5.h)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ),
                    // Text('share in the community')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 14.sp),
    );
  }
}
