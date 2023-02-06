import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/app_bottom_navigation_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/modules/chat/message_screen.dart';
import 'package:freelancer/modules/home/flcer/bloc/flcer_home_bloc.dart';
import 'package:freelancer/modules/home/flcer/flcer_home_page.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_bloc.dart';
import 'package:freelancer/modules/profile/screen/saved_project_screen.dart';
import 'package:freelancer/modules/profile/user_profile_screen.dart';

class FlcerHomeScreen extends StatefulWidget {
  const FlcerHomeScreen({Key? key}) : super(key: key);

  @override
  State<FlcerHomeScreen> createState() => _FlcerHomeScreenState();
}

class _FlcerHomeScreenState extends State<FlcerHomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          BlocProvider(
            create: (context) => FlcerHomeBloc(),
            child: const FlcerHomePage(),
          ),
          // const SavedProjectScreen(),
          BlocProvider(
            create: (context) => SavedProjectBloc(),
            child: const SavedProjectScreen(),
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
