import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_bloc.dart';
import 'package:freelancer/modules/search/models/list_search_flcer_result_widget.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/constants/string_constants.dart';

class ListSearchFlcerResultScreen extends StatelessWidget {
  const ListSearchFlcerResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchFlcerBloc = context.read<SearchFlcerBloc>();
    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.listFreelancer.toTitleCase()),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _searchFlcerBloc,
        child: const ListSearchFlcerResultWidget(),
      ),
    );
  }
}
