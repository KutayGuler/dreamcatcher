import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sizer/sizer.dart';
import '../observables.dart';
import 'package:uuid/uuid.dart';

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

  DateTime selectedDate = DateTime.now();

  Map<String, dynamic> dream = {
    "id": "",
    "date": "",
    "title": "",
    "themes": [],
    "places": [],
    "people": [],
    "description": "",
  };

  void saveDream(BuildContext context) {
    g<S>().addDream(dream);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved ' + dream["title"]),
      ),
    );
  }

  static const List<IconData> icons = [
    Icons.sentiment_satisfied_outlined,
    Icons.sentiment_dissatisfied_outlined,
    Icons.monitor_heart_outlined,
    Icons.videogame_asset,
    Icons.category,
    Icons.cake,
  ];

  // TODO: Ask if dream logs are going to be editable

  var uuid = const Uuid();

  void initialize() {
    setState(() {
      dream["date"] = selectedDate.toString().split(" ")[0];
      data = g<S>().allData;
      isSelectedPlaces = List.generate(data['places'].length, (index) => false);
      isSelectedPeople = List.generate(data['people'].length, (index) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color primaryColorDark = Theme.of(context).primaryColorDark;

    double _borderWidth = 0.5.w;
    double _width = 80.w;

    void popInput(String label) {
      var _inputValue = "";

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  Text("Add new " + (label == "places" ? "place" : "person")),
              content: TextField(
                autofocus: true,
                onChanged: (String val) {
                  _inputValue = val;
                },
                maxLength: 32,
                decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    g<S>().addToData("places", _inputValue);
                    setState(() {
                      label == "places"
                          ? isSelectedPlaces.add(false)
                          : isSelectedPeople.add(false);
                      // data[label].add(_inputValue);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('DONE'),
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        if (dream["title"] != "" &&
            dream["description"] != "" &&
            dream["places"].isNotEmpty) {
          saveDream(context);
        }
        return true;
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
                    SizedBox(
                      width: _width,
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
                              setState(() {
                                selectedDate = currentDate;
                                dream["date"] =
                                    currentDate.toString().split(" ")[0];
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    const InputLabel(label: "title"),
                    SizedBox(
                      width: _width,
                      child: TextField(
                        onChanged: (String val) {
                          setState(() => dream["title"] = val);
                        },
                        maxLength: 24,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: _borderWidth),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: _borderWidth),
                          ),
                        ),
                      ),
                    ),
                    const InputLabel(label: "theme"),
                    SizedBox(
                      width: _width,
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
                              border: Border.all(
                                  color: Colors.black, width: _borderWidth),
                              borderRadius: BorderRadius.circular(_borderWidth),
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
                    ...List.generate(2, (int i) {
                      String _label = "places";
                      List _isSelected = isSelectedPlaces;
                      IconData _iconData = Icons.add_location_alt;

                      if (i == 1) {
                        _label = "people";
                        _isSelected = isSelectedPeople;
                        _iconData = Icons.person_add;
                      }

                      return Observer(builder: (context) {
                        var _arr = g<S>().allData[_label];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _label,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(height: 2.h),
                            // TODO: Add show all button to increase height, make two different variables for height
                            AnimatedContainer(
                              height: 8.h,
                              duration: Duration(milliseconds: 200),
                              child: ClipRect(
                                child: SizedBox(
                                  width: _width,
                                  child: Wrap(
                                    spacing: 2.w,
                                    // TODO: Could make list elements into a widget that scales on mount
                                    children: List.generate(_arr.length + 1,
                                        (int index) {
                                      if (index == _arr.length) {
                                        return IconButton(
                                          icon: Icon(_iconData),
                                          onPressed: () => popInput(_label),
                                        );
                                      }

                                      return TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isSelected[index] =
                                                !_isSelected[index];
                                            for (var i = 0;
                                                i < _isSelected.length;
                                                i++) {
                                              if (_isSelected[i]) {
                                                dream[_label].add(_arr[i]);
                                              }
                                            }
                                          });
                                        },
                                        child: Text(
                                          _arr[index],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: _isSelected[index]
                                              ? primaryColor
                                              : Colors.white,
                                          side: BorderSide(
                                              width: _borderWidth,
                                              color: Colors.black),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                    }),
                    const InputLabel(label: "description"),
                    SizedBox(
                      height: 30.h,
                      width: _width,
                      child: TextFormField(
                        onChanged: (String val) {
                          setState(() {
                            dream["description"] = val;
                          });
                        },
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: _borderWidth),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: _borderWidth),
                          ),
                        ),
                        maxLines: null, // required for expands attribute
                        expands: true,
                        maxLength: 1000,
                        cursorColor: Colors.black,
                      ),
                    ),
                    const InputLabel(label: "drawings"),
                    SizedBox(
                      height: 30.h,
                      width: _width,
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
                        onPressed: () {
                          saveDream(context);
                        },
                        child: const Text(
                          "save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(_width, 5.h)),
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
