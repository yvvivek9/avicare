import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:avicare_web/models/exercise.dart';
import 'package:avicare_web/models/file.dart';

class GridTileWidget extends StatefulWidget {
  const GridTileWidget({
    super.key,
    required this.exercise,
    required this.handleDelete,
    required this.handleUpdate,
  });

  final Exercise exercise;
  final Function(Exercise) handleDelete;
  final Function(Exercise) handleUpdate;

  @override
  State<GridTileWidget> createState() => _GridTileWidgetState();
}

class _GridTileWidgetState extends State<GridTileWidget> {
  Uint8List? imageAsBytes;

  void getImageData() async {
    final imageData = await File.getFileByID(widget.exercise.image);
    setState(() {
      imageAsBytes = imageData;
    });
  }

  @override
  void initState() {
    super.initState();
    getImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // Add ClipRRect to respect container's border radius
            borderRadius: BorderRadius.circular(12.r),
            child: imageAsBytes != null
                ? Image.memory(
                    imageAsBytes!,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => widget.handleUpdate(widget.exercise..image = base64Encode(imageAsBytes!.toList())),
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 15),
                      Text(
                        "Edit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                MenuItemButton(
                  onPressed: () => widget.handleDelete(widget.exercise),
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 15),
                      Text(
                        "Delete",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
              builder: (ctx, controller, _) => IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            top: 170.h,
            child: SizedBox(
              width: 200.w,
              child: Text(
                widget.exercise.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
