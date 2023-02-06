import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../auth/bloc/auth_bloc.dart';

class UpdateCapacityProfilePage extends StatelessWidget {
  const UpdateCapacityProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    var _projectNameController;
    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final capacity = flcerInfoBloc.flcerInfo!.proficiency;
    var listImg = capacity.img;
    var listProject = capacity.file;
    var _numOfItems = listImg.length;
    return Container(
      color: AppColors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: kPadding(context), vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 158 / 102,
                ),
                shrinkWrap: true,
                children: [
                  ...List.generate(
                    _numOfItems + 1,
                    (index) {
                      // var bgImage = const CachedNetworkImageProvider(
                      //   'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80',
                      // );
                      // var imgButtonWidth = scrSize.width * 0.4;
                      var imgButtonAspectRatio = 2.0;
                      return AspectRatio(
                        aspectRatio: imgButtonAspectRatio,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: AppColors.borderColor,
                            ),
                            color: AppColors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow10,
                                blurRadius: 5.0,
                              )
                            ],
                            image: index != _numOfItems && listImg.isNotEmpty
                                ? DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        listImg[index]),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: index != _numOfItems
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: _buildCancelButton(),
                                )
                              : Center(
                                  child: SvgPicture.asset(
                                    AppAsset.icUpload,
                                    width: scrSize.width * 50 / 375,
                                    color: AppColors.gray,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
            ..._ProjectData.data
                .map((e) => _buildProjectContainer(project: e))
                .toList(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                StringConst.addYourCapacityProfile,
                style: TextStyle(
                  fontFamily: AppConst.fontNunito,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  height: 24.59 / 16.0,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            AppTextField(
              hint: StringConst.inputProjectName,
              controller: _projectNameController,
              elevation: 0.0,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              color: AppColors.gray2,
              radius: const Radius.circular(kBorderRadius10),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppOutlinedButton(
                    onPressed: () {},
                    child: '+ ' + StringConst.upload,
                    borderRadius: BorderRadius.circular(kBorderRadius10),
                    labelTextStyle: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      height: 23.05 / 15.0,
                      color: AppColors.primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Expanded(
                    child: Text(
                      StringConst.uploadProjectHelper,
                      style: TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        height: 23.05 / 15.0,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
              ),
              child: Center(
                child: AppElevatedButton(
                  label: StringConst.update,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: kButtonLabelVerticalPadding,
                  ),
                  elevation: 0.0,
                  labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProjectContainer({
    required _ProjectData project,
  }) {
    var textStyle = AppTextStyles.textStyle.copyWith(
      height: 31.71 / (AppTextStyles.textStyle.fontSize ?? 16.0),
      color: const Color(0xFF444444),
    );
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: textStyle,
                  ),
                ),
                _buildCancelButton(),
              ],
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
            height: 1.0,
            thickness: 1.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            project.fileName,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8.0),
          AppElevatedButton(
            label: StringConst.download,
            elevation: 0,
            onPressed: () {},
            primary: AppColors.orangeAccent,
            labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
            padding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 22.0),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildCancelButton({
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: SvgPicture.asset(
        AppAsset.icCircleCancel,
        height: 20.0,
        width: 20.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String fileName;

  _ProjectData({
    required this.title,
    required this.fileName,
  });

  static final data = [
    _ProjectData(
      title: 'Thiết kế 2D triển khai nội thất',
      fileName: 'Thiet_ke_trien_khai_noi_that_2D.pdf',
    ),
    _ProjectData(
      title: 'Thiết kế 2D triển khai nội thất',
      fileName: 'Thiet_ke_trien_khai_noi_that_2D.pdf',
    ),
  ];
}
