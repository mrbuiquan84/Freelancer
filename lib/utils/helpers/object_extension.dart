extension ObjectExt on Object {
  bool stringCompareWith(s) =>
      toString().trim().toLowerCase() == s.toString().trim().toLowerCase();
}
