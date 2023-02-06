import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/notif_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class NonUserHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  NonUserHomeAppBar({
    Key? key,
    this.onNotifButtonPressed,
    this.notifButtonKey,
    this.onTapSearchField,
  }) : super(key: key);

  final VoidCallback? onNotifButtonPressed;
  final Key? notifButtonKey;
  final VoidCallback? onTapSearchField;

  TextStyle _buildAppbarTextStyle({Color? color}) {
    return AppTextStyles.appbarTitleTxtStyle.copyWith(
      fontStyle: FontStyle.italic,
      fontSize: 22.0,
      color: color,
      height: 28.0 / 22.0,
    );
  }

  final double _searchFieldVerticalPadding = 15.0;
  final double _toolbarHeight = 25.0 + 30.0;
  final TextEditingController _searchController = TextEditingController();
  @override
  Size get preferredSize => Size.fromHeight(
      _toolbarHeight + 2 * _searchFieldVerticalPadding + kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var nameWidget = RichText(
      text: TextSpan(
        text: StringConst.welcome + ' ',
        style: _buildAppbarTextStyle(),
        children: [
          TextSpan(
            text: "Freelancer",
            style: _buildAppbarTextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );

    var logo = Image.asset(
      AppAsset.imgLogo,
      height: 30.0,
      fit: BoxFit.fitHeight,
    );
    var searchBar = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: AppTextField(
            hint: StringConst.searchKeyJobEtc,
            height: 40,
            readOnly: true,
            controller: _searchController,
            prefixIcon: AppAsset.icSearch,
            elevation: 0.0,
            fillColor: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            textColor: AppColors.white,
            padding: EdgeInsets.zero,
            onTapTextField: onTapSearchField,
          ),
        ),
        const SizedBox(width: kSizedBoxWidth),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            child: Container(
              width: 45.0,
              height: 40.0,
              color: AppColors.primaryColor,
              padding: const EdgeInsets.all(7.0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAsset.icLevels,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
    return SliverAppBar(
      shape: AppBorderAndRadius.defaultAppBarBorder,
      backgroundColor: AppColors.white,
      expandedHeight: 200 - kStatusbarHeight, // leadingWidth: 250,
      pinned: true,
      floating: true,
      snap: false,
      elevation: 4.0,
      forceElevated: true,
      title: logo,
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: kPadding(context)),
          child: NotifButton(
            onNotifButtonPressed: onNotifButtonPressed,
            notifButtonKey: notifButtonKey,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ConstrainedBox(
              child: FittedBox(child: nameWidget),
              constraints: const BoxConstraints(maxHeight: 22),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        stretchModes: const [StretchMode.fadeTitle],
        collapseMode: CollapseMode.pin,
        background: Padding(
          padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
          child: searchBar,
        ),
      ),
    );
  }
}
