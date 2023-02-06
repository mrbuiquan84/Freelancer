import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class LoadMoreWidget extends StatefulWidget {
  const LoadMoreWidget({
    Key? key,
    this.loadButton,
    this.onLoad,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Widget? loadButton;
  final Future Function()? onLoad;

  @override
  State<LoadMoreWidget> createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  final ScrollController _controller = ScrollController();
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    if (!_controller.hasClients && _visible.value) {
      _visible.value = false;
    }
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          if (_visible.value) {
            _visible.value = false;
          }
        }
      } else {
        if (!_visible.value) {
          _visible.value = true;
        }
      }
    });
  }

  final GlobalKey<_LoadMoreButtonState> _buttonKey =
      GlobalKey<_LoadMoreButtonState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          widget.child,
          ValueListenableBuilder<bool>(
            valueListenable: _visible,
            child: LoadMoreButton(
              key: _buttonKey,
              onPressed: () async {
                if (widget.onLoad != null) {
                  await widget.onLoad!();
                  _buttonKey.currentState!.changeState();
                }
              },
            ),
            builder: (context, visible, child) {
              return Visibility(
                visible: visible,
                child: child!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class LoadMoreButton extends StatefulWidget {
  const LoadMoreButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final VoidCallback? onPressed;

  @override
  _LoadMoreButtonState createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _isLoading = false;
  final Duration _duration = const Duration(milliseconds: 300);
  final Widget _downIcon = const Icon(
    Icons.arrow_downward,
    key: ValueKey('arrow'),
  );
  final _indicatorIcon = const SizedBox(
    key: ValueKey('circular'),
    height: 16,
    width: 16,
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primaryColor,
      strokeWidth: 2.0,
    ),
  );

  void changeState() => setState(() => _isLoading = !_isLoading);

  @override
  Widget build(BuildContext context) {
    var _button = SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          changeState();
          await Future.delayed(_duration);
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        icon: AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(0.0, 0.5), end: Offset.zero),
              ),
              child: FadeTransition(
                opacity: animation.drive(Tween(begin: 0, end: 1)),
                child: child,
              ),
            );
          },
          child: _isLoading ? _indicatorIcon : _downIcon,
        ),
        label: const Text('Tải thêm'),
        style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
    );
    return _button;
  }
}
