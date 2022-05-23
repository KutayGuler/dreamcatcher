import 'package:dreamcatcher/routes/create_dream.dart';
import 'package:dreamcatcher/routes/dream_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'observables.dart';
import 'routes/home.dart';
import 'routes/create_dream.dart';

void main() {
  runApp(const MyApp());
  setup();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              // TODO: Create primary swatch out of a Material Color
              primarySwatch: Colors.purple,
              primaryColor: const Color.fromRGBO(227, 209, 229, 1),
              primaryColorDark: const Color.fromRGBO(163, 107, 172, 1),
              fontFamily: "Comfortaa"),
          home: const Home(),
          routes: {
            'create_dream': (context) => const CreateDream(),
            'dream_details': (context) => const DreamDetails(),
          });
    });
  }
}
