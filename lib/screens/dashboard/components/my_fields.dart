import 'package:vision_dashboard/models/MyFiles.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'Total_info_Widget.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TotalBarChartWidget(index: 0,);
  }
}


