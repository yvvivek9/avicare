import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({super.key, required this.options, required this.onSelectChange, this.selectedValues = const []});

  final List<CustomDropDowns> options;
  final List<String> selectedValues;
  final void Function(List<String>) onSelectChange;

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  bool isExpanded = false;
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.selectedValues);
    setState(() {});
  }

  void clearSelection() {
    setState(() {
      selectedValues.clear();
      widget.onSelectChange(selectedValues);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: widget.options
          .map(
            (o) => ListTile(
              onTap: () {
                if (selectedValues.contains(o.value)) {
                  selectedValues.remove(o.value);
                } else {
                  selectedValues.add(o.value);
                }
                widget.onSelectChange(selectedValues);
                setState(() {});
              },
              leading: Checkbox(
                value: selectedValues.contains(o.value),
                onChanged: (value) {
                  if (selectedValues.contains(o.value)) {
                    selectedValues.remove(o.value);
                  } else {
                    selectedValues.add(o.value);
                  }
                  widget.onSelectChange(selectedValues);
                  setState(() {});
                },
              ),
              minLeadingWidth: 30,
              title: Row(
                children: [
                  Text(o.label),
                ],
              ),
            ),
          )
          .toList(),
      builder: (ctx, controller, _) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
              isExpanded = false;
            } else {
              controller.open();
              isExpanded = true;
            }
            setState(() {});
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: selectedValues.isEmpty
                      ? Text(
                          "-- Select --",
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          widget.options.where((o) => selectedValues.contains(o.value)).toList().join(", "),
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                SizedBox(width: 10),
                Icon(isExpanded ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropDowns {
  const CustomDropDowns({required this.label, required this.value});
  final String label;
  final String value;

  @override
  String toString() {
    return label;
  }
}
