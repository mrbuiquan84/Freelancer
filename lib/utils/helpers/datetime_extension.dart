extension DateTimeExt on DateTime {
  String format({String sep = '/'}) {
    var formatted = toIso8601String().substring(0, 10);
    var spl = formatted.split('-');
    return [spl.last, spl[1], spl.first].join(sep);
  }

  static DateTime parse(String str, {String type = 'yyyyMMdd'}) {
    if (str.length >= 10) {
      str = str.substring(0, 10);
    }
    str = str.trim().replaceAll('/', '-');
    var spl = str.split('-').map((e) => e.trim().padLeft(2, '0')).toList();
    if (spl.last.length >= 4) {
      str = spl.reversed.join('-');
    }
    try {
      return DateTime.parse(str);
    } catch (e, s) {
      print(e.toString());
      print(str.toString());
      print(s.toString());
    }
    return DateTime(1970);
  }
}
