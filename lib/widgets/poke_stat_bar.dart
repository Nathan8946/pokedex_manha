import 'package:flutter/material.dart';

class PokeStatBar extends StatelessWidget {
  final String? label;
  final int? value;
  final int maxValue;
  final Color backgroundColor;
  final Color? foregroundColor;

  const PokeStatBar({
    Key? key,
    this.label,
    this.value,
    this.maxValue = 300,
    this.backgroundColor = Colors.black12,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(label!.toUpperCase())),
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                Container(
                  height: 14,
                  color: backgroundColor,
                ),
                Container(
                  width: 30.0,
                  height: 14,
                  color: foregroundColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}