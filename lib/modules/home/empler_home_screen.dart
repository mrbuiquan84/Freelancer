import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/app_bottom_navigation_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/modules/chat/message_screen.dart';
import 'package:freelancer/modules/home/empler/empler_home_bloc.dart';
import 'package:freelancer/modules/home/empler_home_page.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_bloc.dart';
import 'package:freelancer/modules/profile/screen/empler_saved_flcer.dart';
import 'package:freelancer/modules/profile/user_profile_screen.dart';

class EmplerHomeScreen extends StatefulWidget {
  const EmplerHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmplerHomeScreen> createState() => _EmplerHomeScreenState();
}

class _EmplerHomeScreenState extends State<EmplerHomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          BlocProvider(
            create: (context) => EmplerHomeBloc(),
            child: const EmplerHomePage(),
          ),
          // const EmplerHomePage(),
          // const EmplerSavedFlcer(),
          BlocProvider(
            create: (context) => SaveFlcerCardBloc(),
            child: const EmplerSavedFlcer(),
          ),
          const MessageScreen(),
          const UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        iconAssets: const [
          AppAsset.icHome,
          AppAsset.icHeart,
          AppAsset.icChat,
          AppAsset.icProfileUser,
        ],
        onChanged: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
