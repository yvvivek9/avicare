import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownController extends GetxController {
  final RxBool isOpen = false.obs;
  final RxString selectedItem = ''.obs;
  final RxInt hoveredIndex = (-1).obs;

  void toggleDropdown() => isOpen.value = !isOpen.value;

  void setSelectedItem(String item) => selectedItem.value = item;

  void setHoveredIndex(int index) => hoveredIndex.value = index;
}

class FancyDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final Function(String) onChanged;
  final double width;
  String? title;
  IconData? prefixIcon;
  final String uniqueTag;
  bool border;

  FancyDropdown({
    super.key,
    this.title,
    this.prefixIcon,
    this.border = true,
    required this.items,
    required this.onChanged,
    this.hint = 'Select an item',
    this.width = 200,
  }) : uniqueTag = UniqueKey().toString() {
    Get.put(DropdownController(), tag: uniqueTag);
  }

  DropdownController get controller =>
      Get.find<DropdownController>(tag: uniqueTag);
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown(BuildContext context) {
    if (controller.isOpen.value) {
      _removeOverlay();
    } else {
      _createOverlay(context);
    }
    controller.toggleDropdown();
  }

  void _createOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: width.w,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.h),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(100.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: BoxConstraints(
                maxHeight: 200.h,
                minWidth: width.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) => MouseRegion(
                  onEnter: (_) => controller.setHoveredIndex(index),
                  onExit: (_) => controller.setHoveredIndex(-1),
                  child: GestureDetector(
                    onTap: () {
                      controller.setSelectedItem(items[index]);
                      onChanged(items[index]);
                      _toggleDropdown(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.hoveredIndex.value == index
                            ? Colors.blue.withOpacity(0.1)
                            : items[index] == controller.selectedItem.value
                                ? Colors.blue.withOpacity(0.05)
                                : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              items[index],
                              style: TextStyle(
                                color: items[index] ==
                                        controller.selectedItem.value
                                    ? Colors.blue
                                    : Colors.black,
                                fontSize: 16.sp,
                                fontWeight: items[index] ==
                                        controller.selectedItem.value
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (items[index] == controller.selectedItem.value)
                            Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 18.sp,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () => _toggleDropdown(context),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                SizedBox(height: 5.h),
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 5.h),
              ],
              Container(
                width: width.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                  border: border
                      ? Border.all(
                          color: controller.isOpen.value
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 1.5,
                        )
                      : null,
                  boxShadow: controller.isOpen.value
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        if (prefixIcon != null) ...[
                          Icon(
                            prefixIcon,
                            color: Colors.grey,
                            size: 24.sp,
                          ),
                          SizedBox(width: 10.w),
                        ],
                        Text(
                          controller.selectedItem.value.isEmpty
                              ? hint
                              : controller.selectedItem.value,
                          style: TextStyle(
                            color: controller.selectedItem.value.isEmpty
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: controller.isOpen.value ? 0.5 : 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: controller.isOpen.value
                                ? Colors.blue
                                : Colors.grey,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
