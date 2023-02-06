import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/on_error_widget.dart';
import 'package:freelancer/utils/data/city.dart';

import '../../../core/constants/string_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_router.dart';
import '../../bloc/city/city_state.dart';
import '../layout/select_page_layout.dart';
import '../popup/app_dialog.dart';

class SelectDistrictUserPage extends StatelessWidget {
  const SelectDistrictUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<City> choices = [];
    List<City> initChoice = [];

    var _cityBloc = context.read<CityBloc>();

    return Scaffold(
      // appBar: AppAppBar(
      //   title: Text(StringConst.districtLabel),
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
                builder: (_) => const AppDialog(
                  content: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CityListState) {
              choices = state.cities;
              initChoice = state.selectedCities.isNotEmpty
                  ? state.selectedCities
                  : choices;
            } else if (state is CityErrorState) {
              return Scaffold(
                body: Center(
                  child: OnErrorWidget(
                    error: state.error,
                    onPressed: () {},
                  ),
                ),
              );
            }
            return SelectPageLayout(
              choices: choices,
              appBarTitle: StringConst.askCity,
              initValue: initChoice,
              helperText: 'Nhập quận / huyện',
              onAppliedButtonPressed: (value) {
                AppRouter.back(context, result: value);
              },
            );
          }),
    );
  }
}
