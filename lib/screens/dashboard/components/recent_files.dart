import 'dart:math';

import 'package:vision_dashboard/models/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Request",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Request Id"),
                ),
                DataColumn(
                  label: Text("Provider"),
                ),
                DataColumn(
                  label: Text("Car"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),

                DataColumn(
                  label: Text("Location"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [

      DataCell(Text(fileInfo.recId!)),
      DataCell(Text(fileInfo.provider!)),
      DataCell(Text(fileInfo.car!)),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.location!)),
    ],
  );
}
