import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/core/constants/asset_path.dart';

class CateData {
  CateData(this.cate, this.asset);

  final JobCate cate;
  final String asset;

  factory CateData.fromCate(JobCate data) {
    final String asset;
    switch (data.id) {
      case 1:
        asset = AppAsset.icCodingFolder;
        break;
      case 2:
        asset = AppAsset.icDesign;
        break;
      case 3:
        asset = AppAsset.icVideo;
        break;
      // case 4:
      //   asset = AppAsset.icDesign;
      //   break;
      case 5:
        asset = AppAsset.icFeather;
        break;
      case 6:
        asset = AppAsset.icGTranslate;
        break;
      case 7:
        asset = AppAsset.icBusinessCenter;
        break;
      case 8:
        asset = AppAsset.icFormat;
        break;
      case 9:
        asset = AppAsset.icCost;
        break;
      case 10:
        asset = AppAsset.icScale;
        break;
      case 11:
        asset = AppAsset.icBlueprint;
        break;
      case 12:
        asset = AppAsset.icMiners;
        break;
      default:
        asset = AppAsset.icDots;
        break;
    }
    return CateData(data, asset);
  }
  // static List<CateData> data = [
  //   CateData('IT & Lập trình', AppAsset.icCodingFolder),
  //   CateData('Thiết kế', AppAsset.icDesign),
  //   CateData('Video', AppAsset.icVideo),
  //   CateData('Xây dựng', AppAsset.icMiners),
  //   CateData('Viết lách', AppAsset.icFeather),
  //   CateData('Dịch thuật', AppAsset.icGTranslate),
  //   CateData('Kinh doanh', AppAsset.icBusinessCenter),
  //   CateData('Nhập liệu', AppAsset.icFormat),
  //   CateData('Kế toán', AppAsset.icCost),
  //   CateData('Luật', AppAsset.icScale),
  //   CateData('Kiến trúc', AppAsset.icBlueprint),
  //   CateData('Khác', AppAsset.icDots),
  // ];
}
