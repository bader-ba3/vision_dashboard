import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Widget Item(text) {
      return Container(
        width: MediaQuery.sizeOf(context).width/3,
        padding: EdgeInsets.all(15),
        // decoration: BoxDecoration(color: Colors.black12,b),
        child: Row(
          children: [
            Text(text,style: TextStyle(fontSize: 22),),
            Spacer(),
            Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ) ;
    }

    return Scaffold(body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Settings",style: TextStyle(fontSize: 30),),
        ),
        Item("Application Version"),
        Item("terms and conditions"),
        Item("Update Application"),
        Item("Error Logs"),
        Item("Stop Application"),
      ],
    ),);

  }

}
