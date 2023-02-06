import 'package:flutter/material.dart';

enum UserType {
  freelancer,
  employer,
  guest,
}

onUserTypeCase(
  UserType variable, {
  VoidCallback? flcerFunc,
  VoidCallback? emplerFunc,
  VoidCallback? other,
}) {
  switch (variable) {
    case UserType.freelancer:
      if (flcerFunc != null) {
        flcerFunc();
      }
      break;
    case UserType.employer:
      if (emplerFunc != null) {
        emplerFunc();
      }
      break;
    case UserType.guest:
      if (other != null) {
        other();
      }
      break;
  }
}
