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
                    itemCount: classNameList.length,
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
                            child: Center(child: Text(classNameList[index],style: SelectedClass==index ? TextStyle(color: Colors.white):null,))),
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
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text("يرجى إختيار احد الصفوف لمشاهدة تفاصيله",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)),
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
