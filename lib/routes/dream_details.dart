import 'package:dreamcatcher/observables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DreamDetails extends StatefulWidget {
  const DreamDetails({Key? key}) : super(key: key);

  @override
  State<DreamDetails> createState() => _DreamDetailsState();
}

class _DreamDetailsState extends State<DreamDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(builder: (context) {
          return Text(
              "Ha burası detay sayfasu" + g<S>().currentDreamID.toString());
        }),
      ),
    );
  }
}
