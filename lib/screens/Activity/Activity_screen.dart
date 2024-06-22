
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();}}


    /* SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<HomeViewModel>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: controller.controlMenu,
                      ),
                    if (!Responsive.isMobile(context))
                      Text(
                        "Activity",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset("assets/icons/Search.svg"),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 55,
                    width: 200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Add",
                      style: TextStyle(color: Color(0xff00308F), fontSize: 22),
                    )),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All Activities",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(

                          columnSpacing: defaultPadding,
                          columns: [
                            DataColumn(

                              label: Text("Activity Id"),
                            ),
                            DataColumn(
                              label: Text("Place"),
                            ),
                            DataColumn(
                              label: Text("Location"),
                            ),
                            DataColumn(
                              label: Text("Description"),
                            ),
                            DataColumn(
                              label: Text("Image"),
                            ),
                            DataColumn(
                              label: Text("Options"),
                            ),
                          ],
                          rows: List.generate(
                            listWorkingDriver.length,
                            (index) =>
                                workingDriverDataRow(listWorkingDriver[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget squrWidget(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Text(
              body,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
  DataRow workingDriverDataRow(
      ({
        String activityId,
        String place,
        String location,
        String description,
        String image,
String mode,
      }) record) {
    return DataRow(
      cells: [
        DataCell(Text(record.activityId)),
        DataCell(Text(record.place)),

        DataCell(ElevatedButton(
          onPressed: (){},
          child: Text("Locate",style: TextStyle(color: primaryColor),),
        )),
        DataCell(Text(record.description,maxLines: 3,)),
        DataCell(IconButton(
          onPressed: (){},
          icon: Icon(Icons.image_outlined),
        )),
        DataCell(Row(
          children: [

            IconButton(
              onPressed: (){},
              icon: Icon(Icons.mode_edit_outline_outlined),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.delete_outline_outlined),
            ),
          ],
        )),
      ],
    );
  }

  List<
      ({
      String activityId,
      String place,
      String location,
      String description,
      String image,
      String mode,

      })> listWorkingDriver = [

    (activityId: "ACT473829", place: "Corniche Al Qawasim St", location: "25.78282284978807, 55.943409982611534", description: "A distinctive tourist destination characterized by its beauty, a place to sit, and a beautiful sea.", questionImage: "",mode: ""),
      (activityId: "ACT298372", place: "Jumeirah Beach", location: "25.193473, 55.247164", description: "A popular beach with stunning views, perfect for relaxation and swimming.", questionImage: "https://example.com/image2.jpg",mode: ""),
      (activityId: "ACT837492", place: "Al Majaz Waterfront", location: "25.336985, 55.391001", description: "A scenic waterfront with many attractions and entertainment options.", questionImage: "https://example.com/image3.jpg",mode: ""),
      (activityId: "ACT129384", place: "Yas Island", location: "24.495655, 54.615089", description: "An iconic island with numerous attractions and activities for all ages.", questionImage: "https://example.com/image4.jpg",mode: ""),
      (activityId: "ACT983274", place: "Dubai Marina", location: "25.080683, 55.141654", description: "A modern marina with a variety of restaurants, shops, and entertainment venues.", questionImage: "https://example.com/image5.jpg",mode: ""),
      (activityId: "ACT472910", place: "Sheikh Zayed Grand Mosque", location: "24.412207, 54.474844", description: "A majestic mosque with beautiful architecture and serene surroundings.", questionImage: "https://example.com/image6.jpg",mode: ""),
      (activityId: "ACT092817", place: "Al Ain Oasis", location: "24.207500, 55.744722", description: "A lush oasis offering a tranquil escape with its greenery and walking paths.", questionImage: "https://example.com/image7.jpg",mode: ""),
      (activityId: "ACT349827", place: "Fujairah Fort", location: "25.138996, 56.334431", description: "A historical fort with rich cultural heritage and impressive architecture.", questionImage: "https://example.com/image8.jpg",mode: ""),
      (activityId: "ACT120938", place: "Hatta Dam", location: "24.791891, 56.117150", description: "A beautiful dam with picturesque views and outdoor activities.", questionImage: "https://example.com/image9.jpg",mode: ""),
      (activityId: "ACT984731", place: "Global Village", location: "25.065700, 55.208678", description: "A vibrant cultural and entertainment destination with a variety of attractions.", questionImage: "https://example.com/image10.jpg",mode: ""),
  ];


}

*/