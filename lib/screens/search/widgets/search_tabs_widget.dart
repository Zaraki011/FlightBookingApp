import 'package:flutter/material.dart';

class SearchTabsWidget extends StatelessWidget {
  final String tabText;
  final bool tabBorder;
  final Color tabColor;

  const SearchTabsWidget(
      {super.key,
      this.tabText = "",
      this.tabBorder = false,
      this.tabColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      width: size.width * .44,
      decoration: BoxDecoration(
          color: tabColor,
          borderRadius: tabBorder == false
              ? const BorderRadius.horizontal(left: Radius.circular(46))
              : const BorderRadius.horizontal(right: Radius.circular(46))),
      child: Center(child: Text(tabText)),
    );
  }
}