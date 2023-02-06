import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/modules/home/empler/get_empler_home_data_result.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_bloc.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/form/outline_text_form_field.dart';
import '../../../../common/widgets/layout/flcer_detail_card.dart';
import '../../../../core/constants/asset_path.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../utils/data/city.dart';
import '../../../../utils/data/error_state_action.dart';
import '../../../../utils/data/load_state_actions.dart';
import '../../../../utils/ui/app_num.dart';
import '../../../bloc/app_repo.dart';
import '../../empler/empler_home_bloc.dart';

class ListFlcerScreen extends StatefulWidget {
  const ListFlcerScreen({Key? key}) : super(key: key);

  @override
  State<ListFlcerScreen> createState() => _ListFlcerScreenState();
}

class _ListFlcerScreenState extends State<ListFlcerScreen> {
  final _searchController = TextEditingController();
  late final EmplerHomeBloc _homeBloc;
  late final SearchFlcerBloc _searchBloc;
  late final Info info;
  late final AppRepo _appRepo;

  final double _textFieldHeight = 40;
  final double _textFieldPadding = 15;

  @override
  void initState() {
    _searchBloc = context.read<SearchFlcerBloc>();
    _appRepo = context.read<AppRepo>();
    // _info = _searchBloc.lastSearch ??
    _homeBloc = context.read<EmplerHomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Info> _flcers = [];
    _homeBloc.loadData();
    FlcerDetailCard _itemBuilder(Info flcer) {
      return FlcerDetailCard(
        id: flcer.id,
        name: flcer.name,
        location: City.fromId(flcer.cityId, list: _appRepo.cities).toString(),
        skills: flcer.listSkill.map((e) => e.toString()).toList(),
        rating: double.parse(flcer.vote ?? "0"),
        avatar: flcer.srcAvt,
        job: flcer.userJob,
        favoriteButton: flcer.savedFlc,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      appBar: AppAppBar(
        title: Text(" Danh sách Freelancer"),
        centerTitle: true,
        extraHeight: 55,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: EdgeInsets.only(
              top: kStatusbarHeight + _textFieldHeight + _textFieldPadding,
              right: 20,
              left: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'Nhập từ khóa cần tìm:',
                    height: 40,
                    prefixIcon: AppAsset.icSearch,
                    controller: _searchController,
                    padding: EdgeInsets.zero,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      _searchBloc.reset();
                      _searchBloc.searchFlcer(
                        keyword: value,
                        whenError: ErrorStateActions.rebuild,
                        whenLoad: LoadStateActions.rebuild,
                      );
                    },
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: InkWell(
                    child: Container(
                      width: 40,
                      height: 40.0,
                      color: AppColors.primaryColor,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAsset.icLevels,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
          color: AppColors.white,
          height: double.infinity,
          child: RefreshIndicator(
            onRefresh: () => _homeBloc.loadData(),
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
                child: Column(
                  children: [
                    const SizedBox(height: kSizedBoxHeight),
                    ..._flcers
                        .map(
                          (e) => Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 15.0 / 2),
                            child: _itemBuilder(e),
                          ),
                        )
                        .toList(),
                  ],
                )),
          )),
    );
  }
}
