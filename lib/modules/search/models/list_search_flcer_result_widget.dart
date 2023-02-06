import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/layout/flcer_detail_card.dart';
import 'package:freelancer/common/widgets/load_more_widget.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_bloc.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_state.dart';
import 'package:freelancer/modules/search/models/get_search_flcer_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../utils/ui/app_num.dart';

class ListSearchFlcerResultWidget extends StatefulWidget {
  const ListSearchFlcerResultWidget({Key? key}) : super(key: key);

  @override
  State<ListSearchFlcerResultWidget> createState() =>
      _ListSearchFlcerResultWidgetState();
}

class _ListSearchFlcerResultWidgetState
    extends State<ListSearchFlcerResultWidget> {
  late final SearchFlcerBloc _searchFlcerBloc;
  late final AppRepo _repo;

  @override
  void initState() {
    super.initState();
    _searchFlcerBloc = context.read<SearchFlcerBloc>();
    _repo = context.read<AppRepo>();
  }

  @override
  void dispose() {
    _searchFlcerBloc.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchFlcerBloc, SearchFlcerState>(
      bloc: _searchFlcerBloc,
      listenWhen: (_, state) =>
          state is SearchFlcerErrorState &&
              state.action == ErrorStateActions.alert ||
          state is SearchFlcerLoadState &&
              state.action == LoadStateActions.popup,
      listener: (_, state) {
        if (state is SearchFlcerErrorState) {
          showToast(state.error);
        }
      },
      buildWhen: (prev, state) =>
          state is SearchFlcerDoneState ||
          state is SearchFlcerLoadState &&
              state.action == LoadStateActions.rebuild ||
          state is SearchFlcerErrorState &&
              state.action == ErrorStateActions.rebuild,
      builder: (context, state) {
        if (state is SearchFlcerLoadState) {
          return const LoadWidget();
        } else if (state is SearchFlcerErrorState) {
          return ErrorActionWidget(
            error: state.error,
            onPressed: () => _searchFlcerBloc.searchFlcer(
              whenLoad: LoadStateActions.rebuild,
              whenError: ErrorStateActions.rebuild,
            ),
          );
        }
        final List<DataRender> flcers = _searchFlcerBloc.flcers;
        return LoadMoreWidget(
          onLoad: _searchFlcerBloc.searchFlcer,
          child: ListView.separated(
            itemCount: flcers.length,
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 15.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var flcer = flcers[index];
              return FlcerDetailCard(
                name: flcer.name,
                job: flcer.userJob ?? "Chưa cập nhật",
                id: flcer.id,
                location: flcer.citName,
                skills: flcer.listSkill.map((e) => e.toString()).toList(),
                rating: double.parse(flcer.vote ?? "0"),
                avatar: flcer.avatar,
                favoriteButton: flcer.savedFlc,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
          ),
        );
      },
    );
  }
}
