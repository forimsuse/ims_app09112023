import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final Widget title;
  final Widget? subtitle;
  const ExpandedSection(
      {super.key, required this.child, required this.title, this.subtitle});

  @override
  State<ExpandedSection> createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    // _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck(bool expand) {
    if (expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  // @override
  // void didUpdateWidget(ExpandedSection oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _runExpandCheck();
  // }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: ExpansionTile(
              title: widget.title,
              subtitle: widget.subtitle,
              onExpansionChanged: (value) {
                _runExpandCheck(value);
              },
            )),
        SizeTransition(
            axisAlignment: 1.0, sizeFactor: animation, child: widget.child),
      ],
    );
  }
}
