import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';


class SignView extends StatefulWidget {
  SignView({Key? key}) : super(key: key);

  @override
  SignViewState createState() => SignViewState();
}

class SignViewState extends State<SignView> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(

                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: 400,
          width: 400,
          child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        child: SfSignaturePad(
                            key: signatureGlobalKey,
                            backgroundColor: Colors.white,
                            strokeColor: Colors.black,
                            minimumStrokeWidth: 1.0,
                            maximumStrokeWidth: 4.0),
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)))),
                SizedBox(height: 10),
                Row(children: <Widget>[

                  AppButton(text: "حفظ", onPressed: _handleSaveButtonPressed),
                  AppButton(text: "اعادة", onPressed: _handleClearButtonPressed),


                ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
        ));
  }
}