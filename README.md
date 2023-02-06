# Freelance (Timviec365.com.vn)

## Getting Started
- Chạy `flutter pub get`
## TOC

* [1 số lưu ý trước khi bắt đầu dự án](#1-số-lưu-ý-trước-khi-bắt-đầu-dự-án)
* [File thiết kế](#File-thiết-kế)
* [Cấu trúc thư mục](#Cấu-trúc-thư-mục)
* [Routing](#Routing)
* ## 1 số lưu ý trước khi bắt đầu dự án

1. **Không** cập nhật flutter sdk, các dependency nếu nó đang chạy tốt,
2. Bật tự động format code trên ide

## File thiết kế

> [App Việc làm theo giờ (Site .com) – Figma](https://www.figma.com/file/38JSGmLOFlugGU6c2HKT0N/freelancer.com.vn-(SỬA)?node-id=2101%3A632))

## Cấu trúc thư mục

- Tất cả các file/thư mục (nếu ko có ví dụ) được đặt tên theo kiểu `snake_case`

```dart

  lib
   # các bloc có thể dùng chung cho toàn app
   # hoặc quản lý các bloc khác (bloc lớn quản lý các bloc nhỏ hơn)
  ├── blocs
  ├── common                          # lưu các thành phần chung
  │    # các `model` có thể dùng chung cho toàn app
  │    # mỗi 1 file chỉ chứa trong đấy 1 class
  │    # 1 class có thể có nhiều phương thức fromJson khác nhau (như fromResultFilterJson, fromResultSearchJson...)
  │   ├── models
  │   └── widgets                     # các `widget` có thể dùng chung
  │       ├── buttons                 # các button có thể dùng lại
  │           ├── InputButton.dart
  │           └── PillButton.dart
  │
  │       ├── CustomScaffold.dart
  │       └── CustomTextField.dart
  ├── core                            # lõi của dự án
  │   ├── constants
  │       ├── address.dart            # Chứa các địa chỉ api
  │       ├── asset_path.dart         # đường dẫn tới các asset: image, icon
  │       ├── string_constants.dart   # khai báo các chuỗi lặp lại như: Họ và tên, Ngày sinh...
  │
  │        # các giá trị mặc định/cấu hình của app
  │        # vd: các giá trị lưu vào Local Storage, date format (d/M/y), ...
  │       └── app_constants.dart
  │
  │   └── theme
  │       ├── app_color.dart            #Chứa các mã màu của toàn app
  │       └── app_text_style.dart       #Chứa các style của App
  │
   # đại diện cho tầng data (data-layer) của app
   # thực hiện kết nối tới server/database để nhận dữ liệu
  ├── data
  │   ├── http
  │           (tùy chọn)
  │       ├── interceptors
  │       ├── api.dart
  │       ├── code.dart               # request status code
  │       └── result_data.dart
 # các tính năng đuợc chia thành các module con để dễ quản lý (bên dưới là ví dụ 1 số thư mục)
  ├── modules
  │   ├── account_management
  │   ├── dashboard                   # là `1` màn hình và không có nhiều màn con
  │	   # trong trường hợp 1 màn hình có `nhiều` bloc, cubit
  │       ├── blocs                   # các bloc, cubit đc dùng trong màn hình này
  │
  │	   # nếu số lượng bloc và cubit nhiều -> có thể tách riêng các cubit thành 1 thư mục
  │       ├── cubits                  # các cubit đc dùng trong màn hình này
  │
  │	   # trong trường hợp 1 màn hình chỉ có 1 bloc hoặc cubit
  │	   # và trong tương lai tính năng/module này ko có sự bổ sung các thành phần mới
  │       ├── latest_post_cubit       # cubit quản lý bài viết mới nhất
  │       ├── models                  # các model chỉ xuất hiện trong tính năng này
  │           ├── user_model.dart
  │           └── result_get_post.dart  # model lấy kết quả từ api có cấu trúc `result_{tên phương thức tương ứng}`
  │
  │       ├── widgets                 # các widget chỉ xuất hiện trong tính năng này
  │       ├── dashboard_screen.dart
  │
  │        # nếu như trong 1 màn hình có nhiều form như đăng ký, đăng tin...
  │        # có thể tách thành việc validate các form thành 1 hoặc nhiều controller riêng
  │       └── controller
  │
  │   ├── saved/favourite
  │   ├── settings                    # gồm `nhiều` màn hình
  │       ├── blocs
  │       ├── cubits
  │       ├── models
  │       ├── widgets
  │       ├── screens
  │           ├── screen_A.dart
  │           └── screen_B.dart
  │       └── controller
  │   └── user_profile                # là `1` màn hình nhưng lại chứa trong nó nhiều màn con
  │       ├── blocs
  │       ├── cubits
  │       ├── models
  │       ├── components              # chứa các màn con của màn user_profile
  │       ├── widgets
  │       └── user_profile_screen.dart
  ├── routes
  │    # Chứa các hàm static thực hiện navigate đến 1 màn hình khác
  │   ├── navigator.dart
  │
  │    # tên của các argument cho các màn
  │    # vd: khi chuyển sang 1 màn khác cần truyền argument như id hoặc value...
  │   ├── argument.dart
  │
  │    # các file khác tùy vào cách navigate
  │   ├── ...
  │
   # chứa các phương thức có thể dùng lại nhiều lần
   # các biến/phương thức ở dạng static const/final
  └── utils
      ├── data
          ├── data_utils.dart         # Chứa token, các dữ liệu được dùng lại nhiều lần trong app (danh sách thành phố)
         
           # các enum, class lưu các giá trị không đổi (mặc định) mà backend quy ước
           # bao gồm extension của mỗi enum
          ├── gender.dart             # enum giới tính: nam, nữ, không yêu cầu
          └── level.dart              # class cấp bậc
      ├── helpers
          ├── time_utils.dart
          └── validator.dart          # các validator cho form
      └── ui
      	  ├── animations              # các animation được custom riêng
      	  ├── painter_border          # các painter, border được custom riêng
               ├── DottedBorder.dart
               └── DashedVerticalLinePainter.dart

          ├── app_border.dart         # custom border (style, radius, ...)
          ├── app_padding.dart        # custom padding
          ...
          ├── app_color_padding.dart  # có thể gộp lại như thế này nếu ít
          ...
          ├── app_dialogs.dart        # các dialog của app
          └── widget_uitls.dart

```
## Naming Convention

> [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)
> [Flutter: Best Practices and Tips](https://medium.com/flutter-community/flutter-best-practices-and-tips-7c2782c9ebb5)

1 số quy tắc cần phải lưu ý:

- Sử dụng đường dẫn tương đối để import file
- Các hằng số, enum được đặt tên dưới dạng `lowerCamelCase`

```dart
const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = Random();
}

enum Gender {male, female}
```

## Routing

- Ví dụ: Chuyển sang màn hình khác và lấy kết quả.

```dart
    onPressed: () => AppRouter.toPage(context, AppPages.Example2)!
        .then((value) => result = value ?? ''),
```

- Ví dụ: Quay lại màn hình cũ.

```dart
    onPressed: () => AppRouter.back(context, result: 'abcd'),
```

- Để thêm một màn hình mới:

    1. Vào `router\app_pages.dart`, thêm vào `enum AppPages`:

    + Ví dụ: Thêm màn login trong thư mục `modules\auth` ⇒ Auth_Login

    2. Tìm đến hàm `AppPagesExtension.getPageConfig()` và thêm một case mới vào trong switch:

```dart
  PageBuilder get pageBuilder {
    switch (this) {
      case AppPages.Auth_Login:
        return PageConfig()..pageBuilder = () => LoginScreen();
```"# freelancer_com_vn" 
