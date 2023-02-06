import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/list_search_result_widget.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

class ListSearchResultScreen extends StatelessWidget {
  const ListSearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchBloc = context.read<SearchBloc>();
    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.work.toTitleCase()),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _searchBloc,
        child: const ListSearchResultWidget(),
      ),
    );
  }
}
