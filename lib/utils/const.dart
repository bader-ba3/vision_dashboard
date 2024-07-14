abstract class Const {

  static const expensesCollection = "Expenses";
  static const eventCollection = "Events";
  static const waitManagementCollection = "WaitManagement";


  static const eventTypeStudent = 'eventTypeStudent';
  static const eventTypeParent = 'eventTypeParent';
  static const eventTypeEmployee = 'eventTypeEmployee';
  static const allEventType = [eventTypeStudent,eventTypeParent,eventTypeEmployee];
}

String getEventTypeFromEnum(data){
  if(data == Const.eventTypeStudent){
    return "طالب";
  }else if(data == Const.eventTypeParent){
    return "ولي أمر";
  }else if(data == Const.eventTypeEmployee){
    return "موظفين";
  }else {
    return "UNKNOWN";
  }
}