import 'package:date_format/date_format.dart';

class DateFormat {
  static const List<String> mmddhhnn = [mm, '月', dd, '日 ', HH, ':', nn];
  static const List<String> yymmdd = [yy, '/', mm, '/', dd];
  static const List<String> yyyymmddhhnn = [yyyy, '/', mm, '/', dd, ' ', HH, ':', nn];
  static const List<String> yyyymmdd = [yyyy, '/', mm, '/', dd, ' ', HH, ':', nn];
  static const List<String> nnss = [nn, ':', ss];
  static const List<String> hhnn = [HH, ':', nn];

  ///2020/12/12
  static String getYYYYMMDD(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, yyyymmdd);
  }

  ///12:12 分秒
  static String getNNSS(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, nnss);
  }

  ///12:12 时分
  static String getHHNN(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, hhnn);
  }

  ///12月12日 12:12
  static String getMMDDHHMM(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, mmddhhnn);
  }

  ///2020/12/12 12:12
  static String getYYYYMMDDHHNN(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, yyyymmddhhnn);
  }

  ///12/12/12
  static String getYYMMDD(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, yymmdd);
  }

  ///时间差 12天12时12分
  static String intervals(int startTime, int endTime) {
    int intervals = endTime - startTime;
    int days = intervals ~/ (1000 * 60 * 60 * 24);
    int hours = (intervals - days * (1000 * 60 * 60 * 24)) ~/ (1000 * 60 * 60);
    int minutes =
        (intervals - days * (1000 * 60 * 60 * 24) - hours * (1000 * 60 * 60)) ~/
            (1000 * 60);
    return days == 0
        ? hours == 0
            ? "$minutes分"
            : "$hours时$minutes分"
        : "$days天$hours时$minutes分";
  }

  ///时间差 12天12时12分
  static String interval(int intervals) {
    int days = intervals ~/ (1000 * 60 * 60 * 24);
    int hours = (intervals - days * (1000 * 60 * 60 * 24)) ~/ (1000 * 60 * 60);
    int minutes =
        (intervals - days * (1000 * 60 * 60 * 24) - hours * (1000 * 60 * 60)) ~/
            (1000 * 60);
    return days == 0
        ? hours == 0
            ? "$minutes分"
            : "$hours时$minutes分"
        : "$days天$hours时$minutes分";
  }

  /// 中午时间格式
  static String getMMdd_HHmm_CN(int time) {
    if (time == null || time < 1000) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return formatDate(dateTime, mmddhhnn);
  }

  ///分秒 12:12
  static String secondsToMs(int time) {
    int minute = time ~/ 60;
    int second = time % 60;
    return "${numberAdd0(minute)}:${numberAdd0(second)}";
  }

  static String numberAdd0(int number) {
    if (number > 10) {
      return number.toString();
    } else if (number >= 0) {
      return "0$number";
    } else {
      return "00";
    }
  }
}
