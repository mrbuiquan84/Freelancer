import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/widgets/layout/select_page_layout.dart';
import 'package:freelancer/common/widgets/on_error_widget.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/city.dart';

class SelectDistrictPage extends StatelessWidget {
  const SelectDistrictPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<City> choices = [];
    List<City> initChoice = [];

    var _cityBloc = context.read<CityBloc>();

    // _cityBloc.getCities();
    return BlocConsumer(
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
            helperText:
                'Nhập để tìm kiếm hoặc chọn 1 trong các tỉnh thành dưới đây',
            onAppliedButtonPressed: (value) {
              AppRouter.back(context, result: value);
            },
          );
        });
  }
}
