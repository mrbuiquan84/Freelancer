import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/app_padding.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final VoidCallback? onPressedSuffix;
  final VoidCallback? onTapTextField;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final dynamic suffixIcon;
  final dynamic prefixIcon;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Key? formKey;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final String? label;
  final bool isRequired;
  final Widget? trailing;
  final double? height;
  final String? helperText;
  final TextStyle? hintTxtStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final TextStyle? labelTextStyle;
  final TextStyle inputTextStyle;
  final Color? iconColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? helperTextPadding;
  final TextInputAction? textInputAction;

  const AppTextField({
    Key? key,
    required this.hint,
    this.controller,
    this.padding = const EdgeInsets.only(bottom: kTextFieldBottomPadding),
    this.textInputAction,
    this.labelTextStyle,
    this.onPressedSuffix,
    this.onTapTextField,
    this.isPassword = false,
    this.keyboardType = TextInputType.multiline,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLength,
    this.maxLines,
    this.inputFormatters,
    this.formKey,
    this.validator,
    this.textAlign = TextAlign.start,
    this.elevation = kElevation,
    this.label,
    this.isRequired = false,
    this.trailing,
    this.height,
    this.helperText,
    this.hintTxtStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    this.inputTextStyle = AppTextStyles.inputTextStyle,
    this.iconColor,
    this.contentPadding,
    this.helperTextPadding,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  final GlobalKey _key = GlobalKey();
  late final EdgeInsetsGeometry _textFieldPadding;
  late final int? _maxLines;
  String? _error;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    if (widget.isPassword) {
      _maxLines = 1;
    } else {
      _maxLines = widget.maxLines;
    }
    _textFieldPadding = widget.padding;
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;
    if (!widget.isPassword) {
      if (widget.suffixIcon == null) {
        suffixIcon = null;
      } else {
        suffixIcon = Padding(
          padding: const EdgeInsets.only(right: kTextFieldIconPadding),
          child: (widget.suffixIcon! is String)
              ? SvgPicture.asset(
                  widget.suffixIcon!,
                  color: widget.iconColor ?? AppColors.hintColor,
                )
              : widget.suffixIcon,
        );
      }
    } else {
      suffixIcon = Padding(
        padding: const EdgeInsets.only(right: kTextFieldIconPadding),
        child: IconButton(
          icon: _obscureText
              ? const Icon(
                  Icons.visibility_outlined,
                  color: AppColors.hintColor,
                )
              : SvgPicture.asset(
                  AppAsset.icVisibilityOff,
                  color: AppColors.hintColor,
                ),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          splashRadius: 20,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      );
    }

    Widget? prefix;
    if (widget.prefixIcon != null) {
      if (widget.prefixIcon is! String) {
        prefix = widget.prefixIcon;
      } else {
        prefix = SvgPicture.asset(
          widget.prefixIcon!,
          color: widget.textColor ?? AppColors.hintColor,
          height: 20.0,
          width: 20.0,
          fit: BoxFit.cover,
        );
      }
    }
    var fieldBorderRadius = widget.borderRadius ?? BorderRadius.circular(10.0);

    var _hintTextStyle = widget.inputTextStyle
        .copyWith(color: widget.textColor ?? AppColors.hintColor);

    Widget textFormField = TextFormField(
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.validator != null) {
          _error = widget.validator!(value);
          return _error;
          // setState(() {
          //   if (error != null) {}
          // });
        }
      },
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      onTap: widget.onTapTextField,
      readOnly: widget.readOnly,
      maxLines: _maxLines,
      obscureText: _obscureText,
      obscuringCharacter: '∗',
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textAlign: widget.textAlign,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: widget.inputTextStyle
          .copyWith(color: widget.textColor ?? AppColors.textColor),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: _hintTextStyle,
        hintMaxLines: widget.maxLines,
        errorMaxLines: 2,
        helperMaxLines: 2,
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
                borderRadius: fieldBorderRadius,
                borderSide:
                    const BorderSide(color: AppColors.inactiveColor, width: 1)),
        disabledBorder: AppBorderAndRadius.outlineInputDisabledBorder
            .copyWith(borderRadius: fieldBorderRadius),
        focusedBorder: widget.focusedBorder ??
            AppBorderAndRadius.outlineInputFocusedBorder
                .copyWith(borderRadius: fieldBorderRadius),
        errorBorder: AppBorderAndRadius.outlineInputErrorBorder
            .copyWith(borderRadius: fieldBorderRadius),
        focusedErrorBorder: AppBorderAndRadius.outlineInputErrorBorder
            .copyWith(borderRadius: widget.borderRadius),
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: widget.height != null
            ? EdgeInsets.symmetric(
                horizontal: 20,
                vertical: (widget.height! -
                        _hintTextStyle.height! * _hintTextStyle.fontSize!) /
                    2,
              )
            : widget.contentPadding ?? AppPadding.formFieldContentPadding,
        isDense: true,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kTextFieldIconPadding,
                ),
                child: prefix,
              ),
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: suffixIcon,
        constraints: const BoxConstraints(
            // minHeight: widget.height ?? 60,
            // maxHeight:
            //     widget.height != null ? widget.height! * 2 : double.infinity,
            ),
      ),
    );

    Widget? label;
    if (widget.label != null || widget.trailing != null) {
      label = Padding(
        padding: const EdgeInsets.only(bottom: kTextFieldLabelBottomPadding),
        child: Row(
          children: [
            if (widget.label != null)
              RichText(
                text: TextSpan(
                  text: widget.label,
                  style: widget.labelTextStyle ?? AppTextStyles.hintTxtStyle,
                  children: [
                    if (widget.isRequired)
                      TextSpan(
                        text: ' *',
                        style: AppTextStyles.hintTxtStyle.apply(
                          color: AppColors.red,
                        ),
                      ),
                  ],
                ),
              ),
            if (widget.trailing != null && widget.label != null)
              SizedBox(
                width: kPadding(context) / 2,
              ),
            if (widget.trailing != null) Expanded(child: widget.trailing!),
          ],
        ),
      );
    }

    Widget? helper;
    if (widget.helperText != null) {
      helper = Padding(
        padding: widget.helperTextPadding ??
            const EdgeInsets.only(
              bottom: kTextFieldLabelBottomPadding,
            ),
        child: Text(
          widget.helperText!,
          style: AppTextStyles.hintTxtStyle.copyWith(
            fontSize: 15,
          ),
        ),
      );
    }

    var field = Column(
      key: _key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) label,
        if (widget.helperText != null) helper!,
        textFormField,
      ],
    );

    return Padding(
      padding: _textFieldPadding,
      child: widget.formKey == null
          ? field
          : Form(
              child: field,
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
    );
  }
}
