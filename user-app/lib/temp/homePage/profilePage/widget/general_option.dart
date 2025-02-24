import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget generalOption({
  required String title,
  required IconData prefixIcon,
  Widget? switchWidget,
  Function()? onTap,
}) {
  return ListTile(
    onTap: onTap,
    minTileHeight: 60.h,
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(60.r),
    ),
    leading: Icon(prefixIcon),
    title: Text(title),
    trailing: switchWidget ?? Icon(Icons.arrow_forward_ios),
  );
}

class CollapsibleOption extends StatefulWidget {
  const CollapsibleOption({super.key, required this.title, required this.prefixIcon, required this.options});

  final String title;
  final IconData prefixIcon;
  final List<Widget> options;

  @override
  State<CollapsibleOption> createState() => _CollapsibleOptionState();
}

class _CollapsibleOptionState extends State<CollapsibleOption> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          onTap: () => setState(() {
            isExpanded = !isExpanded;
          }),
          minTileHeight: 60.h,
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.r),
          ),
          leading: Icon(widget.prefixIcon),
          title: Text(widget.title),
          trailing: isExpanded ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.arrow_forward_ios),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                    children: widget.options,
                  ),
              )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
