import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  ScrollController scrollController = ScrollController();
  ScrollController secScrollController = ScrollController();
  int? SelectedClass;
  List className = [
    "KG 1",
    "KG 2",
    "Grade 1",
    "Grade 2",
    "Grade 3",
    "Grade 4",
    "Grade 5",
    "Grade 6",
    "Grade 7",
    "Grade 8",
    "Grade 9",
    "Grade 10",
    "Grade 11",
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SelectedClass = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Column(
              children: [
                Container(
                    height: 75,
                    child: Center(child: Text("الصفوف"))),
                Container(
                  height: 6,
                  color: secondaryColor,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: className.length,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          SelectedClass = index;
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                           decoration: BoxDecoration( color: SelectedClass==index ? primaryColor:Colors.transparent,borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Text(className[index],style: SelectedClass==index ? TextStyle(color: Colors.white):null,))),
                      ),
                    );
                  },),
                ),
              ],
            ),
          ),
          Container(
            width: 5,
            color:  secondaryColor,
          ),
          if(SelectedClass == null)
            Expanded(
              child: SizedBox(
                child: Center(child: Text("يرجى إختيار احد الصفوف لمشاهدة تفاصيله",style: TextStyle(fontSize: 20),)),
              ),
            )
          else
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("عربي",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                    Container(height: 75,width:3,color: Colors.grey.shade300,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("لغات",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
                Container(height: 5,color: secondaryColor,),
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("طالب عربي "+index.toString(),style: TextStyle(fontSize: 18))),
                              ),
                            ),
                            Container(height: 75,width:3,color: Colors.grey.shade300,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("طالب لغات "+index.toString(),style: TextStyle(fontSize: 18),)),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 3,color: Colors.grey.shade300,)
                      ],
                    );
                  },),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
