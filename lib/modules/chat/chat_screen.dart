import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/chat/widget/chat_circle_avatar.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.name,
    required this.avatar,
  }) : super(key: key);
  final String name;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    var _inputController;
    var _currentUserId = '0';

    var messages = [
      Message(id: '0', senderId: '0', message: 'Xin chào bạn!', recieveId: '1'),
      Message(id: '1', senderId: '1', message: 'Xin chào!', recieveId: '0'),
      Message(
          id: '0',
          recieveId: '0',
          senderId: '1',
          message:
              'Chúng tôi đã xem hồ sơ của bạn và chúng tôi thấy bạn rất phù hợp với dự án của chúng tôi. Chúng tôi rất mong muốn được làm việc cùng bạn.'),
      Message(id: '0', senderId: '0', message: 'Xin chào bạn!', recieveId: '0'),
    ];

    return Scaffold(
      appBar: AppAppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 10.0,
            ),
            child: ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: kSizedBoxHeight),
                itemBuilder: (_, index) {
                  var message = messages[index];
                  var messageContainer = MessageContainer(
                    message: message,
                    currentUserId: _currentUserId,
                  );
                  if (message.senderId == _currentUserId) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: messageContainer,
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChatCircleAvatar(
                          avatar: avatar,
                          imgSize: 42.0,
                          onlineDotSize: 12.0,
                        ),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: messageContainer,
                        ),
                      ],
                    );
                  }
                }),
          ),
          Container(
            height: 70.0,
            padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGray.withOpacity(0.25),
                  offset: const Offset(0.0, -1.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: StringConst.inputContent,
                    controller: _inputController,
                    padding: EdgeInsets.zero,
                    prefixIcon: AppAsset.icSmile,
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAsset.icSend),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: AppColors.lightIrisBlue,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppAsset.icDocument),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String id;
  final String senderId;
  final String message;
  final String recieveId;

  Message({
    required this.id,
    required this.senderId,
    required this.message,
    required this.recieveId,
  });
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    Key? key,
    required this.message,
    required this.currentUserId,
  }) : super(key: key);
  final Message message;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      color: message.senderId != currentUserId
          ? AppColors.orangeFade
          : AppColors.lightIrisBlue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 8.0, 5.0),
        child: Text(
          message.message,
          textHeightBehavior: const TextHeightBehavior(
            leadingDistribution: TextLeadingDistribution.proportional,
          ),
          style: AppTextStyles.textStyle,
        ),
      ),
    );
  }
}
