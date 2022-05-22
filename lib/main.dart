import 'package:dreamcatcher/routes/create_dream.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'routes/home.dart';
import 'routes/create_dream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Color.fromRGBO(227, 209, 229, 1),
              primaryColorDark: Color.fromRGBO(163, 107, 172, 1),
              fontFamily: "Comfortaa"),
          home: const Home(),
          routes: {'create_dream': (context) => const CreateDream()});
    });
  }
}
