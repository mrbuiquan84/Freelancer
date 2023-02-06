import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/layout/flcer_detail_card.dart';
import 'package:freelancer/common/widgets/layout/job_card.dart';
import 'package:freelancer/utils/data/city.dart';

class SearchFlcerInputModel {
  int? sort;
  FlcerDetailCard? categoryId;
  FlcerDetailCard? skillId;
  City? workCity;
  String? keyword;
  int page;
  int searchLimit;

  SearchFlcerInputModel({
    this.sort,
    this.categoryId,
    this.skillId,
    this.workCity,
    this.keyword,
    this.page = 1,
    this.searchLimit = 10,
  });

  Map<String, dynamic> toJson() => {
        'sort': sort,
        'skill_id': skillId?.id,
        'category_id': categoryId?.id,
        'work_city': workCity?.citId,
        'keyword': keyword,
        'page': page,
        'limit': searchLimit,
      };

  @override
  String toString() => toJson().toString();
}
