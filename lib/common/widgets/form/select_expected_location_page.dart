import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/string_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_router.dart';
import '../../../utils/data/city.dart';
import '../../bloc/city/city_state.dart';
import '../../bloc/city/select_city_bloc.dart';
import '../appbar/app_bar.dart';
import '../layout/select_page_layout.dart';
import '../popup/app_dialog.dart';
import 'outline_text_form_field.dart';

class SelectExpectedLocationPage extends StatelessWidget {
  const SelectExpectedLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _searchBloc = SearchBloc();
    var choices = [];
    late City initChoice;
    final AppTextField searchField;
    final _key = GlobalKey();

    var _cityBloc = context.read<CityBloc>();

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.cityExpectedLabel),
        centerTitle: true,
      ),
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
