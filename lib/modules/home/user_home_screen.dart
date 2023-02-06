import 'package:flutter/material.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/home/empler_home_screen.dart';
import 'package:freelancer/modules/home/flcer/flcer_home_screen.dart';
import 'package:freelancer/utils/data/user_type.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    late final Widget child;

    onUserTypeCase(
      CurrentUser.of(context).userType,
      flcerFunc: () => child = const FlcerHomeScreen(),
      emplerFunc: () => child = const EmplerHomeScreen(),
      other: () => child = Container(),
    );

    return child;
  }
}
