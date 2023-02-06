import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SearchInputModel {
  JobCate? categoryId;
  JobCate? skillId;
  City? workCity;
  JobType? type;
  String? keyword;
  int page;
  int searchLimit;

  SearchInputModel({
    this.categoryId,
    this.skillId,
    this.workCity,
    this.type,
    this.keyword,
    this.page = 1,
    this.searchLimit = kSearchLimit,
  });

  Map<String, dynamic> toJson() => {
        'skill_id': skillId?.id,
        'category_id': categoryId?.id,
        'work_city': workCity?.citId,
        'type': type?.id,
        'keyword': keyword,
        'page': page,
        'limit': searchLimit,
      };

  @override
  String toString() => toJson().toString();
}
