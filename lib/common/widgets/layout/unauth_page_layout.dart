import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/unauthenticated_appbar.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class UnAuthPageLayout extends StatelessWidget {
  const UnAuthPageLayout({
    Key? key,
    this.child,
    this.appBarTitle,
  }) : super(key: key);
  final Widget? child;
  final String? appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          UnAuthAppBar(
            title: appBarTitle,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.095,
            ),
          ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
              child: child,
            ),
          ),
          // )
        ],
      ),
    );
  }
}
