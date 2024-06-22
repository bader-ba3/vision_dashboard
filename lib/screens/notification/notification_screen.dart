import 'package:flutter/material.dart';
import '../../constants.dart';

class NotificationScreen extends StatefulWidget {
   NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isToAll = true;
  String? gender ;
  String? location ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send Notification",style: TextStyle(color: Color(0xff00308F),fontSize: 30),),
            SizedBox(height: 50,),
            SizedBox(
              height: 75,
              width: 400,
              child:  TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
            //  width: double.infinity,
              child:  Container(
                decoration: BoxDecoration( borderRadius: const BorderRadius.all(Radius.circular(10)),color: secondaryColor),
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Body",
                    // fillColor: secondaryColor,
                    // filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Row(
              children: [
                Checkbox(
                    
                    fillColor: WidgetStateProperty.all(primaryColor),
                    value: isToAll, onChanged: (_)=>setState(() {
                  isToAll=_!;
                })),
                SizedBox(width: 5,),
                Text("Send To All User",style: TextStyle(color: Color(0xff00308F),fontSize: 22),)
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Checkbox(
                    fillColor: WidgetStateProperty.all(primaryColor),

                    value: !isToAll, onChanged: (_)=>setState(() {
                  isToAll=!_!;
                })),
                SizedBox(width: 5,),
                Text("Send with Filter",style: TextStyle(color: Color(0xff00308F),fontSize: 22),)
              ],
            ),
            SizedBox(height: 25,),
            IgnorePointer(
              ignoring: isToAll,
              child: Opacity(
                opacity: isToAll ?0.5:1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: 400,
                          child:  Row(
                            children: [
                              Text("Age of User",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Start",
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("To",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "End",
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 2,),
                        SizedBox(
                          height: 75,
                          width: 400,
                          child:  Row(
                            children: [
                              Text("Gender",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: DropdownButton( isExpanded: true,value: gender,items: ["male","female"].map((e) => DropdownMenuItem(value: e,child: Text(e))).toList(), onChanged: (value) { setState(() {
                                    gender = value;
                                  }); },)
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Row(
                      children: [
                        SizedBox(
                          height: 75,
                          width: 400,
                          child:  Row(
                            children: [
                              Text("Payment Range",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Start",
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("To",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "End",
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 2,),
                        SizedBox(
                          height: 75,
                          width: 400,
                          child:  Row(
                            children: [
                              Text("Location",style: TextStyle(color: Color(0xff00308F),fontSize: 22),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: location,items: ["Rak","Quasim"].map((e) => DropdownMenuItem(value: e,child: Text(e))).toList(), onChanged: (value) { setState(() {
                                  location = value;
                                  }); },)
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
           // Spacer(),
            SizedBox(height: defaultPadding,),
           Center(
             child: Container(
               height: 75,
               width: 400,
               decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(15)),
                 child: Center(child: Text("Send",style: TextStyle(color: Color(0xff00308F),fontSize: 22),)),
             ),
           )
          ],
        ),
      ),
    );
  }
}
