import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> toAR(Map<String, PlutoColumnType> data) {
  List<PlutoColumn> columns = data.entries.map((entry) {
    return PlutoColumn(
      title: entry.key,
      field: entry.key,
      type: entry.value,
      enableAutoEditing: false,
      enableColumnDrag: false,
      enableEditingMode: false,
      hide: entry.key == data.keys.first, // إخفاء العمود الأول
    );
  }).toList();

  return columns;
}