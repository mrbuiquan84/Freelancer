import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/app_bottom_navigation_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/modules/home/nonflcer_home_page.dart';

import '../signup/screen/flcer_signup_screen.dart';
import 'flcer/bloc/flcer_home_bloc.dart';

class NonFlcerHomeScreen extends StatefulWidget {
  const NonFlcerHomeScreen({Key? key}) : super(key: key);

  @override
  State<NonFlcerHomeScreen> createState() => _NonFlcerHomeState();
}

class _NonFlcerHomeState extends State<NonFlcerHomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          BlocProvider(
            create: (context) => FlcerHomeBloc(),
            child: const NonFlcerHomePage(),
          ),
          const FlcerSignupScreen(),
          const FlcerSignupScreen(),
          const FlcerSignupScreen(),
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
