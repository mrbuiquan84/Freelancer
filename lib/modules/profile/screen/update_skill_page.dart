import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/tick_check_box.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import '../../../common/models/cate_data.dart';
import '../../../common/models/job_cate.dart';
import '../../../common/widgets/button/cate_button.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../bloc/app_repo.dart';

class UpdateSkillPage extends StatefulWidget {
  const UpdateSkillPage({Key? key}) : super(key: key);

  @override
  State<UpdateSkillPage> createState() => _UpdateSkillPageState();
}

class _UpdateSkillPageState extends State<UpdateSkillPage> {
  late final AppRepo _appRepo;
  @override
  void initState() {
    super.initState();
    _appRepo = context.read<AppRepo>();
  }

  var _selectedSkill = '';
  List<Skill> skillItemsOfSelected = [];

  @override
  Widget build(BuildContext context) {
    // _appRepo = context.read<AppRepo>();
    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final skill = flcerInfoBloc.flcerInfo!.skill;
    List<JobCate> selectedSkills = skill.skillDetail;

    var titleStyle = AppTextStyles.cateHeaderStyle.copyWith(
      color: AppColors.primaryColor,
    );

    var subTitleStyle = AppTextStyles.cateHeaderStyle.copyWith(
      color: AppColors.primaryColor,
      height: 24.0 / (AppTextStyles.cateHeaderStyle.fontSize ?? 18.0),
    );
    Widget _listJobCateButton = Container(
      color: AppColors.white,
      child: Column(
        children: [
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 86 / 100,
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: kPadding(context) / 20 * 12),
            shrinkWrap: true,
            children: _appRepo.jobCates.asMap().entries.map(
              (e) {
                var id = e.key;
                var jobCate = e.value;
                return CateButton(
                  data: CateData.fromCate(jobCate),
                  color: [1, 3, 4, 6, 9, 11].contains(id)
                      ? AppColors.orangeAccent
                      : null,
                  onPressed: () async {
                    await _appRepo.getListSkill(id: jobCate.id);

                    setState(() {
                      skillItemsOfSelected = _appRepo.skill;
                      _selectedSkill = jobCate.jobCate;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );

    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: kPadding(context), vertical: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConst.skill,
              style: titleStyle,
            ),
            const SizedBox(height: kScaffoldBodyVerticalPadding),
            _listJobCateButton,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                StringConst.selectedSkill,
                style: subTitleStyle,
              ),
            ),
            Wrap(
              children: selectedSkills
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(e.toString()),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                text: TextSpan(
                  text: StringConst.selectSkill,
                  style: subTitleStyle,
                  children: [
                    TextSpan(
                      text: _selectedSkill,
                      style: subTitleStyle.copyWith(
                        color: AppColors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...skillItemsOfSelected.asMap().entries.map(
              (e) {
                var index = e.key;
                var item = e.value;
                return TickCheckBox(
                  item: item,
                  selected: false,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
              ),
              child: Center(
                child: AppElevatedButton(
                  label: StringConst.update,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: kButtonLabelVerticalPadding,
                  ),
                  labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                  elevation: 0.0,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
