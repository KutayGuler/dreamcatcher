import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateDream extends StatefulWidget {
  const CreateDream({Key? key}) : super(key: key);

  @override
  State<CreateDream> createState() => _CreateDreamState();
}

class _CreateDreamState extends State<CreateDream> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> isSelectedEmotions = [false, false, false, false, false, false];
  List<bool> isSelectedPlaces = [
    false,
    false,
  ];
  List<Icon> icons = [
    Icon(Icons.face),
    Icon(Icons.face),
    Icon(Icons.monitor_heart_outlined),
    Icon(Icons.videogame_asset),
    Icon(Icons.category),
    Icon(Icons.cake),
  ];

  var selectedDate = DateTime.now();

  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color primaryColorDark = Theme.of(context).primaryColorDark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.w),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 2.h,
              runSpacing: 2.h,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 5.w,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Log a dream",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                        size: 4.w,
                        color: primaryColorDark,
                      )
                    ],
                  ),
                  // TODO: Customize date picker colors
                  // TODO: customize input outline colors
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
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'title',
                  ),
                ),
                DropdownButton<String>(
                  // TODO: Add border to all input fields
                  hint: Text("place"),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text(
                  "theme",
                  style: TextStyle(fontSize: 14.sp),
                ),
                Center(
                  child: ToggleButtons(
                    renderBorder: false,
                    constraints: BoxConstraints(maxWidth: 12.w),
                    selectedColor: Colors.black,
                    fillColor: primaryColor,
                    splashColor: primaryColor,
                    children: List.generate(6, (i) {
                      // TODO: Figure out margin
                      return Container(
                          width: 10.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(0.5.w),
                          margin: EdgeInsets.all(2.w),
                          child: icons[i]);
                    }),
                    onPressed: (int index) {
                      setState(() {
                        isSelectedEmotions[index] = !isSelectedEmotions[index];
                      });
                    },
                    isSelected: isSelectedEmotions,
                  ),
                ),

                Text(
                  "people",
                  style: TextStyle(fontSize: 14.sp),
                ),
                Row(
                  children: [
                    TextButton(
                      child: Text("+"),
                      onPressed: () {},
                    ),
                    ToggleButtons(
                      selectedColor: Colors.black,
                      fillColor: primaryColor,
                      splashColor: primaryColor,
                      children: <Widget>[
                        Text("mom"),
                        Text("Tom"),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          isSelectedPlaces[index] = !isSelectedPlaces[index];
                        });
                      },
                      isSelected: isSelectedPlaces,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                  child: TextFormField(
                    initialValue: "Describe your dream",
                    expands: true,
                    maxLines: null,
                    maxLength: 1000,
                  ),
                ),
                // Text("add drawings"),
                // Container(width: 5.w, height: 5.w),
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "save",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(84.w, 5.h)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorDark)),
                  ),
                ),
                // Text('share in the community')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
