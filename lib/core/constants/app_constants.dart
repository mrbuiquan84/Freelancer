import 'package:flutter/material.dart';

class AppConst {
  static const String appName = 'Freelance Vieclam88';

  static const String fontNunito = 'Nunito';

  static const String datePattern = 'd/M/y';

  static const String apiDatePattern = 'y-M-d';

  static const String timePattern = 'HH:mm';

  static const int refetchApiThreshold = 3;

  static const Duration timesToFetchCommonDataAgain = Duration(days: 7);

  static const int nextPageThreshold = 3;

  static const int maxNumberOfMessagesFromRecruiterIfTheyActivelySendMessage =
      3;

  static const TextHeightBehavior textHeightBehavior = TextHeightBehavior(
    leadingDistribution: TextLeadingDistribution.even,
  );
}
