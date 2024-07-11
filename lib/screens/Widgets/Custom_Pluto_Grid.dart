import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';

class CustomPlutoGrid extends StatefulWidget {
  CustomPlutoGrid(
      {super.key, required this.onSelected, this.controller, this.idName});

  @override
  State<CustomPlutoGrid> createState() => _CustomPlutoGridState();
  final Function(PlutoGridOnSelectedEvent) onSelected;
final controller,idName;
}

class _CustomPlutoGridState extends State<CustomPlutoGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is state");

  }

  listener(){

  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      key:widget.controller.key ,
      columns: widget.controller.columns ,
      rows: widget.controller.rows,
      onChanged: (event) {
        print("onChanged");
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {

/*         stateManager = event.stateManager;
    stateManager.setShowColumnFilter(true);*/
        // widget.controller.stateManager=stateManager;
      },
      mode: PlutoGridMode.selectWithOneTap,
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
