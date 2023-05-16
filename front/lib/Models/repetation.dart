enum Repetation { never,daily, weekly, monthly, yearly }

class TimeData {
  String getday(int index) {
    return [
      "sunday",
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
      "saturday"
    ][index];
  }

  String getmonth(int index) {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
    ][index];
  }
}
