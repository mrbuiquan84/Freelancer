import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/tick_check_box.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ListFilterItemsWidget<T> extends StatefulWidget {
  const ListFilterItemsWidget({
    Key? key,
    required this.items,
    required this.cate,
    this.selectedItems,
    this.onChanged,
  }) : super(key: key);
  final List<T> items;
  final String cate;
  final List<T>? selectedItems;
  final ValueChanged<List<T>>? onChanged;

  @override
  State<ListFilterItemsWidget<T>> createState() =>
      _ListFilterItemsWidgetState<T>();
}

class _ListFilterItemsWidgetState<T> extends State<ListFilterItemsWidget<T>> {
  late List<T?> _selectedItems;
  late final List<T?> _items;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // null -> Select all
    _items = [null, ...widget.items];
    _selectedItems =
        widget.selectedItems != null ? [...widget.selectedItems!] : [null];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RichText(
            text: TextSpan(
              text: widget.cate.toString(),
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: AppConst.fontNunito,
                fontWeight: FontWeight.w600,
                height: 24.0 / 18.0,
                color: AppColors.textColor,
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    width: 15.0,
                    height: 3.0,
                    color: AppColors.orangeAccent,
                  ),
                )
              ],
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300.0),
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            radius: const Radius.circular(kBorderRadius),
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 5.0),
              itemCount: _items.length,
              itemBuilder: _itemBuilder,
              controller: _scrollController,
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
            ),
          ),
        )
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var item = _items[index];
    return TickCheckBox(
      item: item,
      selected: _selectedItems.contains(item),
      onChanged: (selected) {
        if (selected) {
          _selectedItems.add(item);
        } else {
          _selectedItems.remove(item);
        }
        if (widget.onChanged != null) {
          if (_selectedItems.contains(null)) {
            widget.onChanged!([]);
            return;
          }
          widget.onChanged!(_selectedItems as List<T>);
        }
      },
    );
  }
}
