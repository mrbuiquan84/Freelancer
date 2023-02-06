import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/widgets/layout/screen_with_tab_layout.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/had_set_price_bloc/had_set_price_bloc.dart';
import 'package:freelancer/modules/profile/screen/empler_flcer_had_set_price_page.dart';
import 'package:freelancer/modules/profile/screen/empler_flcer_working_with_page.dart';
import 'package:freelancer/modules/profile/screen/empler_saved_flcer.dart';

import '../bloc/save_flcer_card_bloc/save_flcer_card_bloc.dart';
import '../bloc/working_flcer_bloc/working_flcer_card_bloc.dart';

class EmplerFlcerManagermentScreen extends StatelessWidget {
  const EmplerFlcerManagermentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = List.generate(
      5,
      (_) => Flcer.flcer,
    );
    // var flcerHadSetPricePage = EmplerFlcerHadSetPricePage(flcers: list);
    // var flcerWorkingWithPage = EmplerFlcerWorkingWithPage(flcers: list);
    var flcerHadSetPricePage = BlocProvider(
      create: (context) => HadSetPriceBloc(),
      child: const EmplerFlcerHadSetPricePage(),
    );
    var flcerWorkingWithPage = BlocProvider(
      create: (context) => WorkingFlcerBloc(),
      child: const EmplerFlcerWorkingWithPage(),
    );
    var savedFlcerPage = BlocProvider(
      create: (context) => SaveFlcerCardBloc(),
      child: const EmplerSavedFlcer(),
    );
    return ScreenWithTabLayout(
      tabLabels: [
        StringConst.hadSetPrice,
        StringConst.working,
        StringConst.saved,
      ],
      tabs: [
        flcerHadSetPricePage,
        flcerWorkingWithPage,
        savedFlcerPage,
      ],
      appBarTitle: StringConst.flcerManagement,
    );
  }
}
