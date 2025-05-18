import 'package:flutter/material.dart';

class FancyRadioButton extends StatefulWidget {
  final List<ButtonItem> items;
  final ValueChanged<dynamic> onSelection;

  final String headerTitle;
  final TextStyle headerTitleTextStyle;
  final String referenceLine;
  final TextStyle referenceLineTextStyle;

  final int? initialSelectedItemIndex;
  final AllowDisplayType displayType;
  final Widget? selectedButton;
  final Size selectedButtonSize;
  final Widget? unSelectedButton;
  final Size unSelectedButtonSize;
  final double spaceBetweenItems;
  final EdgeInsets? buttonItemPadding;
  final double spaceBeforeItemTitle;
  final BoxShape buttonShape;
  final bool useBorderRadius;
  final double buttonBorderRadius;
  final Size buttonSize;
  final double? itemFontSize;
  final FontStyle? itemFontStyle;
  final FontWeight? itemFontWeight;
  final TextDecoration? itemTextDecoration;
  final double listviewHeight;

  final bool buttonTitleClickable;
  final Color itemActiveColor;
  final Color itemActiveBorderColor;
  final Color itemInActiveBorderColor;
  final Widget? itemTrailing;
  final Color itemActiveTitleColor;
  final Color itemInActiveTitleColor;
  final Icon? filterActionIcon;
  final Color? filterSplashColor;
  final List<FilterItem>? filterItems;
  final WrapAlignment? wrapAlignment;
  final double? wrapViewRunSpacing;
  final int gridViewCrossAxisCount;
  final double gridViewMainAxisSpacing;
  final double gridViewCrossAxisSpacing;
  final double gridViewChildAspectRatio;
  final String? itemTitleFontFamily;
  final bool? sendIndexInReturn;

  FancyRadioButton({
    super.key,
    required this.items,
    required this.onSelection,
    this.initialSelectedItemIndex,
    this.displayType = AllowDisplayType.listviewVertical,
    this.spaceBetweenItems = 15.0,
    this.buttonItemPadding,
    this.spaceBeforeItemTitle = 5.0,
    this.buttonShape = BoxShape.circle,
    this.buttonBorderRadius = 50.0,
    this.buttonSize = const Size(18.0, 18.0),
    this.useBorderRadius = false,
    this.itemFontSize,
    this.itemFontStyle,
    this.itemFontWeight,
    this.itemTextDecoration,
    this.selectedButton,
    this.unSelectedButton,
    this.listviewHeight = 20.0,
    this.headerTitle = "",
    this.referenceLine = "",
    this.buttonTitleClickable = false,
    this.headerTitleTextStyle = const TextStyle(
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    this.referenceLineTextStyle = const TextStyle(
      fontSize: 12.0,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    this.itemActiveColor = Colors.black,
    this.itemActiveBorderColor = Colors.black,
    this.itemInActiveBorderColor = Colors.black,
    this.itemTrailing,
    this.itemActiveTitleColor = Colors.black,
    this.itemInActiveTitleColor = Colors.black,
    this.filterSplashColor,
    this.filterActionIcon,
    this.filterItems,
    this.wrapAlignment,
    this.wrapViewRunSpacing,
    this.gridViewCrossAxisCount = 3,
    this.gridViewMainAxisSpacing = 10.0,
    this.gridViewCrossAxisSpacing = 10.0,
    this.gridViewChildAspectRatio = 5.0,
    this.itemTitleFontFamily = "",
    this.sendIndexInReturn,
    this.selectedButtonSize = const Size(20.0, 20.0),
    this.unSelectedButtonSize = const Size(18.0, 18.0),
  }) : assert(
         items.isNotEmpty,
         "***taRadioButtonItems***\n--Must not be empty",
       ),
       assert(
         !(items.length < 2),
         "***taRadioButtonItems***\n--Items must be greater than or equal to 2",
       );

  @override
  FancyRadioButtonState createState() => FancyRadioButtonState();
}

class FancyRadioButtonState extends State<FancyRadioButton> {
  FilterAction selectedFilterAction = FilterAction.all;
  List<ButtonItem> _items = [];
  List<ButtonItem> _actualItems = [];
  bool initialValue = true;

  @override
  void initState() {
    super.initState();
    addInitialData();
  }

  @override
  void didUpdateWidget(covariant FancyRadioButton oldWidget) {
    if (oldWidget.initialSelectedItemIndex != widget.initialSelectedItemIndex) {
      setState(() {
        initialValue = true;
      });
      addInitialData();
    }
    super.didUpdateWidget(oldWidget);
  }

  void addInitialData() {
    _items.clear();
    _actualItems.clear();
    _items = List.from(widget.items);
    _actualItems = List.from(widget.items);
  }

  void resetToActualData() {
    _items.clear();
    for (final eachData in _actualItems) {
      _items.add(eachData);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filterItems != null) {
      if (widget.filterItems!.isEmpty || widget.filterItems!.length < 2) {
        assert(false, "***filterItems***\n---There must be 2 Items");
      }
    }
    if (widget.initialSelectedItemIndex != null) {
      if (widget.initialSelectedItemIndex! >= widget.items.length) {
        assert(
          false,
          "***initialSelectedItemIndex***\n--Selected index value is Out of range",
        );
      }
    }
    if (widget.filterItems != null) {
      if (widget.filterItems!.isNotEmpty) {
        bool requiredToAdd = true;
        for (final eachFilterData in widget.filterItems!) {
          if (eachFilterData.action == FilterAction.all) {
            requiredToAdd = false;
            break;
          }
        }
        if (requiredToAdd) {
          widget.filterItems!.insert(
            0,
            FilterItem(title: "All", action: FilterAction.all),
          );
        }
      }
    }
    if (initialValue) {
      if (widget.initialSelectedItemIndex != null) {
        widget.items[widget.initialSelectedItemIndex!]._status = true;
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _headerSection(),
        if (widget.displayType == AllowDisplayType.listviewHorizontal) ...{
          SizedBox(height: widget.listviewHeight, child: _radioButtons()),
        } else ...{
          Flexible(child: _radioButtons()),
        },
      ],
    );
  }

  Widget _headerSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.headerTitle.isNotEmpty)
                Text(widget.headerTitle, style: widget.headerTitleTextStyle),
              if (widget.referenceLine.isNotEmpty)
                Text(
                  widget.referenceLine,
                  style: widget.referenceLineTextStyle,
                ),
            ],
          ),
        ),
        if (widget.filterItems != null) ...{
          if (widget.filterItems!.isNotEmpty) ...{filterActionsPopUp()},
        },
      ],
    );
  }

  PopupMenuItem eachFilterActionButton({
    required String title,
    required FilterAction action,
  }) {
    return PopupMenuItem(
      value: action,
      height: 18.0,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
        color:
            action == selectedFilterAction
                ? widget.filterSplashColor != null
                    ? widget.filterSplashColor!.withAlpha(70)
                    : Theme.of(context).primaryColor.withAlpha(70)
                : Colors.transparent,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
          ),
        ),
      ),
    );
  }

  Widget filterActionsPopUp() {
    return Theme(
      data: ThemeData(
        splashColor: widget.filterSplashColor ?? Theme.of(context).primaryColor,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        tooltip: "Apply filters",
        padding: EdgeInsets.zero,
        onSelected: (selectedAction) {
          setState(() {
            resetToActualData();
            selectedFilterAction = selectedAction as FilterAction;
            switch (selectedAction) {
              case FilterAction.all:
                resetToActualData();
                break;
              case FilterAction.showSelected:
                _items =
                    _actualItems.where((element) {
                      return element._status!;
                    }).toList();
                break;
              case FilterAction.showUnSelected:
                _items =
                    _actualItems.where((element) {
                      return !element._status!;
                    }).toList();
                break;
              case FilterAction.showEnabled:
                _items =
                    _actualItems.where((element) {
                      return element.isEnabled;
                    }).toList();
                break;
              case FilterAction.showDisabled:
                _items =
                    _actualItems.where((element) {
                      return !element.isEnabled;
                    }).toList();
                break;
              case FilterAction.showAscending:
                _items.sort((a, b) {
                  return a.title.toString().compareTo(b.title.toString());
                });
                break;

              case FilterAction.showDescending:
                _items.sort((a, b) {
                  return b.title.toString().compareTo(a.title.toString());
                });
                break;
            }
          });
        },
        elevation: 1.0,
        icon:
            widget.filterActionIcon ?? const Icon(Icons.filter_alt, size: 20.0),
        offset: const Offset(-20.0, 35.0),
        itemBuilder: (context) {
          return widget.filterItems!.map((eachFilterData) {
            return eachFilterActionButton(
              title: eachFilterData.title,
              action: eachFilterData.action,
            );
          }).toList();
        },
      ),
    );
  }

  Widget _radioButtons() {
    switch (widget.displayType) {
      case AllowDisplayType.gridview:
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: widget.gridViewMainAxisSpacing,
            crossAxisSpacing: widget.gridViewCrossAxisSpacing,
            childAspectRatio: widget.gridViewChildAspectRatio,
            addSemanticIndexes: false,
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            padding: EdgeInsets.zero,
            crossAxisCount: widget.gridViewCrossAxisCount,
            children:
                _items.map((eachItem) {
                  return _radioButtonItem(
                    eachButtonItem: eachItem,
                    indexValue: _items.indexOf(eachItem),
                  );
                }).toList(),
          ),
        );
      case AllowDisplayType.wrapView:
        return Wrap(
          runSpacing: widget.wrapViewRunSpacing ?? 5.0,
          alignment: widget.wrapAlignment ?? WrapAlignment.start,
          spacing: widget.spaceBetweenItems,
          children:
              _items.map((eachItem) {
                return _radioButtonItem(
                  eachButtonItem: eachItem,
                  indexValue: _items.indexOf(eachItem),
                );
              }).toList(),
        );
      case AllowDisplayType.listviewHorizontal:
        return SizedBox(
          height: widget.listviewHeight,
          child: _buttonsInListview(),
        );
      default:
        return _buttonsInListview();
    }
  }

  Widget _buttonsInListview() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection:
            widget.displayType == AllowDisplayType.listviewHorizontal
                ? Axis.horizontal
                : Axis.vertical,
        itemCount: _items.length,
        itemBuilder: (context, listIndex) {
          final eachItem = _items[listIndex];
          return Padding(
            padding:
                widget.buttonItemPadding ??
                EdgeInsets.only(
                  bottom:
                      widget.displayType == AllowDisplayType.listviewVertical
                          ? widget.spaceBetweenItems
                          : 0.0,
                  right:
                      widget.displayType == AllowDisplayType.listviewHorizontal
                          ? widget.spaceBetweenItems
                          : 0.0,
                ),
            child: _radioButtonItem(
              eachButtonItem: eachItem,
              indexValue: listIndex,
            ),
          );
        },
      ),
    );
  }

  void _onSelection({required int indexValue}) {
    setState(() {
      for (final eachData in _items) {
        eachData._status = false;
      }
      for (final eachData in _actualItems) {
        eachData._status = false;
      }
      _items[indexValue]._status = true;
      _actualItems[indexValue]._status = true;
      initialValue = false;
    });
    if (widget.sendIndexInReturn != null) {
      if (widget.sendIndexInReturn!) {
        widget.onSelection({
          "key": _items[indexValue].key,
          "indexValue": indexValue,
        });
      } else {
        widget.onSelection(_items[indexValue].key);
      }
    } else {
      widget.onSelection(_items[indexValue].key);
    }
  }

  Widget _buttonTitleWidget({
    required ButtonItem eachButtonItem,
    required int indexValue,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap:
          widget.buttonTitleClickable && _items[indexValue].isEnabled
              ? () {
                _onSelection(indexValue: indexValue);
              }
              : null,
      child: Text(
        eachButtonItem.title,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: widget.itemTitleFontFamily,
          color:
              !_items[indexValue].isEnabled
                  ? Colors.grey
                  : eachButtonItem._status!
                  ? widget.itemActiveTitleColor
                  : widget.itemInActiveTitleColor,
          fontSize: widget.itemFontSize ?? 18.0,
          fontStyle: widget.itemFontStyle ?? FontStyle.normal,
          fontWeight: widget.itemFontWeight ?? FontWeight.normal,
          decoration: widget.itemTextDecoration ?? TextDecoration.none,
        ),
      ),
    );
  }

  Widget _radioButtonItem({
    required ButtonItem eachButtonItem,
    required int indexValue,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap:
              _items[indexValue].isEnabled
                  ? () {
                    _onSelection(indexValue: indexValue);
                  }
                  : null,
          child:
              widget.selectedButton == null
                  ? Container(
                    width: widget.buttonSize.width,
                    height: widget.buttonSize.height,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            !_items[indexValue].isEnabled
                                ? Colors.grey
                                : eachButtonItem._status!
                                ? widget.itemActiveBorderColor
                                : widget.itemInActiveBorderColor,
                        width: 1.3,
                      ),
                      shape: widget.buttonShape,
                      borderRadius:
                          widget.useBorderRadius
                              ? BorderRadius.all(
                                Radius.circular(widget.buttonBorderRadius),
                              )
                              : null,
                    ),
                    child:
                        eachButtonItem._status!
                            ? Container(
                              decoration: BoxDecoration(
                                color:
                                    eachButtonItem.isEnabled
                                        ? widget.itemActiveColor
                                        : Colors.grey,
                                shape: widget.buttonShape,
                                borderRadius:
                                    widget.useBorderRadius
                                        ? BorderRadius.all(
                                          Radius.circular(
                                            widget.buttonBorderRadius,
                                          ),
                                        )
                                        : null,
                              ),
                              margin: const EdgeInsets.all(1.7),
                            )
                            : Container(),
                  )
                  : !_items[indexValue].isEnabled
                  ? SizedBox(
                    width: widget.buttonSize.width,
                    height: widget.buttonSize.height,
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: SizedBox(
                          width: widget.buttonSize.width,
                          height: widget.buttonSize.height,
                        ),
                      ),
                    ),
                  )
                  : eachButtonItem._status!
                  ? SizedBox(
                    width: widget.selectedButtonSize.width,
                    height: widget.selectedButtonSize.height,
                    child: FittedBox(child: widget.selectedButton),
                  )
                  : SizedBox(
                    width: widget.unSelectedButtonSize.width,
                    height: widget.unSelectedButtonSize.height,
                    child: FittedBox(
                      child:
                          widget.unSelectedButton ??
                          Container(
                            decoration: BoxDecoration(
                              shape: widget.buttonShape,
                              border: Border.all(
                                width: 1.3,
                                color: widget.itemInActiveBorderColor,
                              ),
                            ),
                            child: SizedBox(
                              width: widget.unSelectedButtonSize.width,
                              height: widget.unSelectedButtonSize.height,
                            ),
                          ),
                    ),
                  ),
        ),
        SizedBox(width: widget.spaceBeforeItemTitle),
        widget.itemTrailing == null
            ? Flexible(
              child: _buttonTitleWidget(
                eachButtonItem: eachButtonItem,
                indexValue: indexValue,
              ),
            )
            : Expanded(
              child: _buttonTitleWidget(
                eachButtonItem: eachButtonItem,
                indexValue: indexValue,
              ),
            ),
        widget.itemTrailing ?? Container(),
      ],
    );
  }
}

class ButtonItem {
  final dynamic key;
  final String title;
  final bool isEnabled;
  bool? _status;

  ButtonItem({required this.key, required this.title, this.isEnabled = true})
    : _status = false;
}

class FilterItem {
  final String title;
  final FilterAction action;

  FilterItem({required this.title, required this.action})
    : assert(
        title.isNotEmpty,
        "***TARadioButtonFilterItems.title***\n--Title can't be empty for $action",
      );
}

enum AllowDisplayType {
  listviewHorizontal,
  listviewVertical,
  gridview,
  wrapView,
}

enum FilterAction {
  all,
  showSelected,
  showUnSelected,
  showEnabled,
  showDisabled,
  showAscending,
  showDescending,
}
