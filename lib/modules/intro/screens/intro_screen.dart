import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  double? _dy;

  final _numberOfIntroPages = 4;

  List<String> listImages = [
    AppAsset.imgPage1,
    AppAsset.imgPage2,
    AppAsset.imgPage3,
    AppAsset.imgPage4,
  ];

  List<String> listTitles = [
    'Tại Sao Nên Tìm Việc Tại Vieclam88.com.vn ?',
    'Đáp Ứng Nhu Cầu Tìm Việc Ngay Lập Tức',
    'Lọc Việc Làm Phù Hợp Với Bạn',
    'Hỗ Trợ - Tư Vấn 24/7',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _dy ??= size.height - size.height * 0.2 - kPadding(context) * 2;
    return Scaffold(
      appBar: AppAppBar(
        elevation: 0,
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
            child: TextButton(
              onPressed: () {
                AppRouter.toPage(context, AppPages.waiting);
              },
              child: const Text(
                StringConst.skip,
                style: TextStyle(
                  color: AppColors.orangeAccent,
                  fontSize: 15,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _numberOfIntroPages,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.2 - kToolbarHeight),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kPadding(context)),
                        child: Text(
                          listTitles[index],
                          style: AppTextStyles.appbarTitleTxtStyle.copyWith(
                            fontSize: 26,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: kPadding(context) * 3),
                      Image.asset(
                        listImages[index],
                      ),
                      SizedBox(
                        height: 20,
                        width: size.width,
                      ),
                    ],
                  ),
                );
              }),
          Positioned(
            top: _dy,
            child: Center(
              child: _buildSelectors(
                length: _numberOfIntroPages,
                currentIndex: _currentIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSelectors({
    required int length,
    int currentIndex = 0,
  }) {
    return SizedBox(
      height: 8,
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Container(
            width: 20,
            margin: const EdgeInsets.only(right: kSeparatorHorizontalPadding),
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.orangeAccent
                  : AppColors.orangeFade,
              borderRadius: AppBorderAndRadius.defaultBorderRadius,
            ),
          );
        },
      ),
    );
  }
}
