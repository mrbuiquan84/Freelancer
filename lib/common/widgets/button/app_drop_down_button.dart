import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';

class AppDropDownButton<T> extends StatefulWidget {
  const AppDropDownButton({
    Key? key,
    required this.choices,
    this.initChoice,
    this.radius,
    this.borderColor,
    this.buttonTextStyle,
    this.width,
    this.itemHeight = 40.0,
    this.itemTextStyles,
    this.iconSize,
    this.onTap,
    this.onExpand,
    this.padding,
  }) : super(key: key);

  final List<T> choices;
  final T? initChoice;
  final double? radius;
  final Color? borderColor;
  final TextStyle? buttonTextStyle;
  final double? width;
  final double itemHeight;
  final List<TextStyle>? itemTextStyles;
  final double? iconSize;
  final ValueChanged<T>? onTap;
  final VoidCallback? onExpand;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppDropDownButton<T>> createState() => _AppDropDownButtonState<T>();
}

class _AppDropDownButtonState<T> extends State<AppDropDownButton<T>> {
  bool _isExpanded = false;
  late List<T> _choices;
  late T _choice;
  late TextStyle _textStyle;
  int? _index;
  Color _color = Colors.transparent;

  @override
  void initState() {
    _choices = [...widget.choices];
    _choice = widget.initChoice ?? _choices[0];
    _textStyle = widget.buttonTextStyle ??
        const TextStyle(
          fontFamily: AppConst.fontNunito,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 28 / 16.0,
          color: AppColors.textColor,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.borderColor != null) {
      _color = widget.borderColor!;
    } else if (widget.itemTextStyles != null) {
      _index = widget.choices.indexWhere((e) => e == _choice);
      _color = widget.itemTextStyles![_index!].color!;
    }

    var icon = Positioned(
      right: 0.0,
      child: SvgPicture.asset(
        AppAsset.icArrowDropDown,
        height: widget.iconSize,
        width: widget.iconSize,
        fit: BoxFit.cover,
        color: _color,
      ),
    );

    var firstItem = Stack(
      alignment: Alignment.center,
      children: [
        _buildItem(item: _choice),
        icon,
      ],
    );

    var _height =
        _isExpanded ? _choices.length * widget.itemHeight : widget.itemHeight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: widget.width,
      height: _height,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 0),
        border: Border.all(
          color: _color,
          width: 1,
        ),
      ),
      child: _isExpanded
          ? ListView.builder(
              itemCount: widget.choices.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) => index == 0
                  ? firstItem
                  : _buildItem(
                      item: _choices[index],
                    ),
              shrinkWrap: true,
            )
          : firstItem,
    );
  }

  Widget _buildItem({
    required T item,
  }) {
    var text = Text(
      item.toString(),
      textHeightBehavior: AppConst.textHeightBehavior,
      style: widget.itemTextStyles == null
          ? _textStyle
          : widget.itemTextStyles![widget.choices.indexWhere(
              (e) => e == item,
            )],
    );
    return SizedBox(
      height: widget.itemHeight,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          if (widget.onTap != null && _isExpanded) {
            widget.onTap!(item);
          } else if (!_isExpanded && widget.onExpand != null) {
            widget.onExpand!();
          }
          setState(() {
            _isExpanded = !_isExpanded;
            if (_choice != item) {
              _choice = item;
              _choices.remove(item);
              _choices.insert(0, item);
            }
          });
        },
        child: text,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: (widget.itemHeight - text.getSize().height) / 2,
          ),
          alignment: Alignment.centerLeft,
          minimumSize: Size.fromHeight(widget.itemHeight),
          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
