import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ScreenWithTabLayout extends StatefulWidget {
  const ScreenWithTabLayout({
    Key? key,
    required this.tabLabels,
    required this.tabs,
    required this.appBarTitle,
  }) : super(key: key);
  final List<String> tabLabels;
  final List<Widget> tabs;
  final String appBarTitle;

  @override
  State<ScreenWithTabLayout> createState() => _ScreenWithTabLayoutState();
}

class _ScreenWithTabLayoutState extends State<ScreenWithTabLayout>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final ValueNotifier<int> _index = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabLabels.length,
      vsync: this,
    );
  }

  final _tabSelectedLabelTextStyle = AppTextStyles.tabLabelTextStyle.copyWith(
    color: AppColors.white,
  );
  final _tabUnSelectedLabelTextStyle = AppTextStyles.tabLabelTextStyle;

  Widget buildTab({
    required String label,
    required int index,
  }) {
    var selected = _index.value == index;
    return Tab(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 158.0,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius10),
          border: !selected ? Border.all(color: AppColors.primaryColor) : null,
          color: selected ? AppColors.orangeAccent : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0.0, 3.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 10.0),
        child: Text(
          label,
          textHeightBehavior: const TextHeightBehavior(
            leadingDistribution: TextLeadingDistribution.even,
          ),
          style: selected
              ? _tabSelectedLabelTextStyle
              : _tabUnSelectedLabelTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = Padding(
      padding:
          const EdgeInsets.symmetric(vertical: kScaffoldBodyVerticalPadding),
      child: Container(
        color: AppColors.white,
        child: ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (_, value, __) {
            return TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              indicatorPadding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              onTap: (index) {
                _index.value = index;
              },
              tabs: List.generate(
                widget.tabLabels.length,
                (index) => buildTab(
                  label: widget.tabLabels[index],
                  index: index,
                ),
              ).toList(),
              // buildTab(label: StingConst.capacityProfile),
            );
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppAppBar(
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Column(
        children: [
          tabBar,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs,
            ),
          ),
        ],
      ),
    );
  }
}
