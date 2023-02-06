import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/layout/select_page_layout.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/city.dart';

class SelectCityUserPage extends StatelessWidget {
  const SelectCityUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _searchBloc = SearchBloc();
    var choices = [];
    late City initChoice;
    final AppTextField searchField;
    final _key = GlobalKey();

    var _cityBloc = context.read<CityBloc>();

    return Scaffold(
      // appBar: AppAppBar(
      //   title: Text(StringConst.cityLabel),
      //   centerTitle: true,
      // ),
      backgroundColor: AppColors.lightIrisBlue,
      body: BlocConsumer(
          bloc: _cityBloc,
          listener: (_, state) {
            if (state is CityLoadState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const AppDialog(),
              );
            }
          },
          builder: (context, state) {
            choices = (state as CityListState).cities;
            initChoice = state.selectedCities.isNotEmpty
                ? state.selectedCities[0]
                : choices[0];
            return SelectPageLayout(
                choices: choices,
                appBarTitle: StringConst.askCity,
                initValue: [initChoice],
                helperText: 'Nhập tỉnh / thành phố',
                onAppliedButtonPressed: ((value) =>
                    AppRouter.back(context, result: value)));
          }),
    );
  }
}
