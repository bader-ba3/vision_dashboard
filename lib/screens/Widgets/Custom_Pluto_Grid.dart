import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';

class CustomPlutoGrid extends StatefulWidget {
  CustomPlutoGrid(
      {super.key,
      required this.onSelected,
      this.controller,
      this.idName,
      this.onRowDoubleTap});

  @override
  State<CustomPlutoGrid> createState() => _CustomPlutoGridState();
  final Function(PlutoGridOnSelectedEvent) onSelected;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final controller, idName;
}

class _CustomPlutoGridState extends State<CustomPlutoGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  listener() {}

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      key: widget.controller.key,
      columns: widget.controller.columns,
      rows: widget.controller.rows,
      onChanged: (event) {
        print("onChanged");
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {

    /*    event.stateManager.insertColumns(0,  event.stateManager.columns.map(
              (e) {
            return PlutoColumn(title: e.title.toString().tr, field: e.field, type: e.type);
          },
        ).toList());*/
     /*   event.stateManager.columns.map(
          (e) {
            return PlutoColumn(title: e.title.tr, field: e.field, type: e.type);
          },
        ).toList();*/
/*         stateManager = event.stateManager;
    stateManager.setShowColumnFilter(true);*/
        // widget.controller.stateManager=stateManager;
      },
      mode: PlutoGridMode.selectWithOneTap,
      onRowDoubleTap: widget.onRowDoubleTap,
      onSelected: widget.onSelected,
      configuration: PlutoGridConfiguration(
        shortcut: PlutoGridShortcut(
          actions: {
            // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):PlutoGridShortcutAction(),
          },
        ),
        style: PlutoGridStyleConfig(
            enableRowColorAnimation: true,
            activatedColor: Colors.white.withOpacity(0.5),
            gridBackgroundColor: Colors.transparent,
            evenRowColor: secondaryColor.withOpacity(0.5),
            cellTextStyle: Styles.headLineStyle3.copyWith(color: primaryColor),
            gridPopupBorderRadius: BorderRadius.all(Radius.circular(15)),
            gridBorderRadius: BorderRadius.all(Radius.circular(15)),
            gridBorderColor: Colors.transparent),
        localeText: PlutoGridLocaleText.arabic(),
      ),
      rowColorCallback: (PlutoRowColorContext rowColorContext) {
        if (checkIfPendingDelete(
            affectedId: rowColorContext.row.cells[widget.idName]?.value)) {
          return Colors.red.withOpacity(0.3);
        }
        return Colors.transparent;
      },
      createFooter: (stateManager) {
        stateManager.setPageSize(40, notify: false); // default 40
        return PlutoPagination(stateManager);
      },
    );
  }
}

PlutoGrid CustomPlutoGrids(
    controller, Function(PlutoGridOnSelectedEvent) onSelected, idName) {
  late final PlutoGridStateManager stateManager;

  return PlutoGrid(
    columns: controller.columns,
    rows: controller.rows,
    onChanged: (event) {
      print("object");
    },
    onRowDoubleTap: (event) {
      print("object");
      // stateManager.notifyListeners();
    },
    onLoaded: (PlutoGridOnLoadedEvent event) {
      stateManager = event.stateManager;
      stateManager.setShowColumnFilter(true);
    },
    mode: PlutoGridMode.selectWithOneTap,
    onSelected: onSelected,
    configuration: PlutoGridConfiguration(
      shortcut: PlutoGridShortcut(
        actions: {
          // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):PlutoGridShortcutAction(),
        },
      ),
      style: PlutoGridStyleConfig(
          enableRowColorAnimation: true,
          activatedColor: Colors.white.withOpacity(0.5),
          gridBackgroundColor: Colors.transparent,
          evenRowColor: secondaryColor.withOpacity(0.5),
          cellTextStyle: Styles.headLineStyle3.copyWith(color: primaryColor),
          gridPopupBorderRadius: BorderRadius.all(Radius.circular(15)),
          gridBorderRadius: BorderRadius.all(Radius.circular(15)),
          gridBorderColor: Colors.transparent),
      localeText: PlutoGridLocaleText.arabic(),
    ),
    rowColorCallback: (PlutoRowColorContext rowColorContext) {
      if (checkIfPendingDelete(
          affectedId: rowColorContext.row.cells[idName]?.value)) {
        return Colors.red.withOpacity(0.3);
      }
      return Colors.transparent;
    },
  );
}
