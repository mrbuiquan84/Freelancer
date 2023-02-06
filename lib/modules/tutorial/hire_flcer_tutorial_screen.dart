import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class HireFlcerTutorialScreen extends StatelessWidget {
  const HireFlcerTutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _indexHeaderTextStyle = const TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 100.0,
      height: 136.0 / 100.0,
      color: Color(0xFF08827C),
    );

    TextStyle _headerTextStyle = const TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 18.0,
      height: 24.55 / 18.0,
      color: AppColors.primaryColor,
    );

    Widget _buildHeader({
      required int index,
      required String header,
    }) =>
        SizedBox(
          width: double.infinity,
          child: RichText(
            text: TextSpan(
              text: index.toString(),
              style: _indexHeaderTextStyle,
              children: [
                TextSpan(
                  text: header,
                  style: _headerTextStyle,
                )
              ],
            ),
          ),
        );

    Widget _buildDetailTutorStep({
      required Widget header,
      required String helper,
      required String imgAsset,
    }) =>
        Column(
          children: [
            header,
            Text(
              helper,
              style: AppTextStyles.normalTextStyle(height: 25.0).copyWith(
                letterSpacing: 1.05,
              ),
            ),
            const SizedBox(height: 30.0),
            Image.asset(imgAsset),
          ],
        );

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.tutorial.toTitleCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding(context),
            vertical: 20.0,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConst.tutorHireFlcer,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    height: 27.66 / 18.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Stack(
                  children: [
                    Column(
                      children: [
                        _buildStepRow(
                          iconAsset: AppAsset.icLaptop,
                          index: 1,
                          text: StringConst.postJob,
                        ),
                        _buildStepRow(
                          iconAsset: AppAsset.icUser,
                          index: 2,
                          text: StringConst.selectFlcer,
                        ),
                        _buildStepRow(
                          iconAsset: AppAsset.icChat1,
                          index: 3,
                          text: StringConst.contactWork,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 100.0 / 2 + 22.68 / 2,
                      right: 0.0 + 15.0 / 2,
                      child: SvgPicture.asset(AppAsset.icOutlinedRotatedArrow1),
                    ),
                    Positioned(
                      bottom: 100.0 - 22.68 / 2,
                      right: 100.0,
                      child: SvgPicture.asset(AppAsset.icOutlinedRotatedArrow2),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                const Text(
                  StringConst.postJobToHireFlcerToday,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    height: 27.28 / 20.0,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                AppElevatedButton(
                  label: StringConst.postJobByProject,
                  onPressed: () {},
                  primary: AppColors.orangeAccent,
                  elevation: 0.0,
                  width: MediaQuery.of(context).size.width -
                      2 * 2 * kPadding(context),
                ),
                const SizedBox(height: 25.0),
                AppElevatedButton(
                  label: StringConst.postParttimeJob,
                  onPressed: () {},
                  elevation: 0.0,
                  width: MediaQuery.of(context).size.width -
                      2 * 2 * kPadding(context),
                ),
                _buildDetailTutorStep(
                  header: _buildHeader(index: 1, header: 'Vào mục đăng dự án'),
                  helper:
                      "Bấm vào nút đăng dự án hiển thị trên thanh Menu.  Chọn đăng việc theo dự án hoặc đăng việc bán thời gian.  Mẫu đăng việc của Vieclam88.vn đã sẵn sàng để bạn sử dụng.",
                  imgAsset: AppAsset.imgTutorPostJobStep1,
                ),
                _buildDetailTutorStep(
                  header:
                      _buildHeader(index: 2, header: 'Điền đầy đủ thông tin'),
                  helper:
                      "Sau khi vào mục Đăng việc theo dự án hoặc Đăng việc bán thời gian, bạn hãy điền đầy đủ thông tin tuyển dụng chúng tôi đã cho sẵn.",
                  imgAsset: AppAsset.imgTutorPostJobStep2,
                ),
                _buildDetailTutorStep(
                  header: _buildHeader(index: 3, header: 'Đăng dự án'),
                  helper:
                      "Sau khi đã điền đầy đủ thông tin vào Form của Vieclam88.vn bạn hãy ấn nút Đăng việc",
                  imgAsset: AppAsset.imgTutorPostJobStep3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStepRow({
  required String iconAsset,
  required int index,
  required String text,
}) {
  var isLeft = !(index % 2 == 0);
  var color = isLeft ? AppColors.primaryColor : AppColors.orangeAccent;
  var container = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      color: AppColors.white,
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color(0xFFDBDBDB),
        width: 0.3,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0.0, 4.0),
          blurRadius: 4.0,
        ),
      ],
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 15.0,
            backgroundColor: color,
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontSize: 15.0,
                height: 22.68 / 15.0,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        Center(
          child: SvgPicture.asset(
            iconAsset,
            height: 50.0,
            width: 50.0,
            fit: BoxFit.cover,
            color: color,
          ),
        ),
      ],
    ),
  );
  var text2 = Text(
    text,
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      height: 27.21 / 18.0,
      color: color,
    ),
  );
  var children = [
    container,
    const SizedBox(width: 20.0),
    text2,
  ];
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: isLeft ? children : (children.reversed.toList()),
      ),
    ),
  );
}
