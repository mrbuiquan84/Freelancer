import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/utils/data/city.dart';

class AppRepo {
  List<JobCate> jobCates = [];
  List<City> cities = [];
  List<Skill> skill = [];

  Future<ResultData> getListJobCate({int? id}) async {
    var res = await httpManager.netFetch(
      ApiAddress.getSkill,
      queryPrams: id != null ? {'category_id': id} : null,
    );
    if (res.result) {
      try {
        if (id == null) {
          res.data = List<JobCate>.from(res.data['list'].map(
            (x) => JobCate.fromJobCate(x),
          ));
        } else {
          res.data = List<Skill>.from(res.data['keytag'].map(
            (x) => Skill.fromJson(x),
          ));
        }
        // res.data = List<JobCate>.from(
        //     (id == null ? res.data['list'] : res.data['keytag']).map(
        //   (x) => JobCate.fromListSkill(x),
        // ));
        // res.data = (res.data['list'] as List)
        //     .map((e) => JobCate.fromJobCate(e))
        //     .toList();
        if (jobCates.isEmpty) {
          jobCates = res.data;
        }
      } catch (e) {
        return ResultData(
          error: Error(message: e.toString()),
          result: false,
        );
      }
    }
    return res;
  }

  Future<ResultData> getListSkill({required int id}) async {
    var res = await httpManager
        .netFetch(ApiAddress.getSkill, queryPrams: {'category_id': id});
    if (res.result) {
      try {
        res.data =
            List<Skill>.from(res.data['keytag'].map((x) => Skill.fromJson(x)));
        skill = res.data;
      } catch (e) {
        return ResultData(
          error: Error(message: e.toString()),
          result: false,
        );
      }
    }
    return res;
  }
  // Future getListJobCate() async {
  //   var res = await httpManager.netFetch(ApiAddress.getSkill);
  //   if (res.result) {
  //     try {
  //       res.data = (res.data['list'] as List)
  //           .map((e) => JobCate.fromJobCate(e))
  //           .toList();
  //       if (jobCates.isEmpty) {
  //         jobCates = res.data;
  //       }
  //     } catch (e) {
  //       return ResultData(
  //         error: Error(message: e.toString()),
  //         result: false,
  //       );
  //     }
  //   }
  //   return res;
  // }

  Future<ResultData> getProvince({int? id}) async {
    var res = await httpManager.netFetch(
      ApiAddress.getProvince,
      queryPrams: id != null ? {'city_id': id} : null,
    );
    if (res.result) {
      try {
        res.data = List<City>.from(
          (id == null ? res.data['list'] : res.data['district']).map(
            (x) => City.fromJson(x),
          ),
        );
        if (cities.isEmpty) {
          cities = res.data;
        }
      } catch (e) {
        return ResultData(
          error: Error(message: e.toString()),
          result: false,
        );
      }
    }
    return res;
  }
}
