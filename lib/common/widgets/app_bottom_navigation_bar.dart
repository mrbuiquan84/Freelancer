import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.iconAssets,
    this.initIndex = 0,
    this.onChanged,
  }) : super(key: key);
  final List<String> iconAssets;
  final int initIndex;
  final ValueChanged<int>? onChanged;

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initIndex;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: kBotNavBarHeight,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(
          top: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.iconAssets.asMap().entries.map((e) {
          var id = e.key;
          var asset = e.value;
          var itemWidth =
              (width - 2 * width * 0.02 - (widget.iconAssets.length - 1)) /
                  widget.iconAssets.length;
          return _buildItem(
            id: id,
            asset: asset,
            width: itemWidth,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem({
    required int id,
    required String asset,
    double? width,
  }) {
    var selected = id == _currentIndex;
    var button = IconButton(
      onPressed: () {
        if (id != _currentIndex) {
          setState(() {
            _currentIndex = id;
            if (widget.onChanged != null) {
              widget.onChanged!(id);
            }
          });
        }
      },
      padding: EdgeInsets.zero,
      splashRadius: kSplashRadius,
      icon: SvgPicture.asset(
        asset,
        color: selected ? AppColors.primaryColor : AppColors.inactiveColor,
      ),
    );
    return SizedBox(
      width: width,
      height: double.infinity,
      child: selected
          ? Column(
              children: [
                Expanded(child: button),
                SvgPicture.asset(AppAsset.icSelectedNavbarItemUnderline),
              ],
            )
          : button,
    );
  }
}
