enum weekEnum {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
  Empty,
}

String weeksName(weekEnum deptRepair) {
  switch (deptRepair) {
    case weekEnum.Monday:
      return "Monday";
    case weekEnum.Tuesday:
      return "Tuesday";
    case weekEnum.Wednesday:
      return "Wednesday";
    case weekEnum.Thursday:
      return "Thursday";
    case weekEnum.Friday:
      return "Friday";
    case weekEnum.Saturday:
      return "Saturday";
    case weekEnum.Sunday:
      return "Sunday";
    default:
      return "";
  }
}

int weekEnumValue(weekEnum weekName) {
  switch (weekName) {
    case weekEnum.Monday:
      return 1;
    case weekEnum.Tuesday:
      return 2;
    case weekEnum.Wednesday:
      return 3;
    case weekEnum.Thursday:
      return 4;
    case weekEnum.Friday:
      return 5;
    case weekEnum.Saturday:
      return 6;
    case weekEnum.Sunday:
      return 7;
    default:
      return 0;
  }
}

weekEnum weekEnumString(int weekEnumIndex) {
  switch (weekEnumIndex) {
    case 1:
      return weekEnum.Monday;
    case 2:
      return weekEnum.Tuesday;
    case 3:
      return weekEnum.Wednesday;
    case 4:
      return weekEnum.Thursday;
    case 5:
      return weekEnum.Friday;
    case 6:
      return weekEnum.Saturday;
    case 7:
      return weekEnum.Sunday;
    default:
      return weekEnum.Empty;
  }
}