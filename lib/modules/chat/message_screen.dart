import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/chat/widget/chat_circle_avatar.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unreadMessageIndex = [0, 1];

    Widget _itemBuilder(BuildContext context, int index) {
      var subTitleTextStyle = const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 24.0 / 14.0,
        color: AppColors.gray,
      );
      return ListTile(
        selectedTileColor: AppColors.lightIrisBlue,
        selected: unreadMessageIndex.contains(index),
        leading: const ChatCircleAvatar(
            avatar:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJZG-8Pk5VYr_MOP4Ks3uEeZdArTUAizNRwg&usqp=CAU'),
        title: const Text(
          'Bùi Anh Quân',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            height: 24.0 / 16.0,
            color: AppColors.messageNameTitleColor,
          ),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Xin chào!',
                style: subTitleTextStyle,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 3.0,
              width: 3.0,
              decoration: const BoxDecoration(
                color: AppColors.gray,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5.0),
            Text(
              '14:00',
              style: subTitleTextStyle,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          StringConst.chat.toTitleCase(),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: _itemBuilder,
      ),
    );
  }
}
