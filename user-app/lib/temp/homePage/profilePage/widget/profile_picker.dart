import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avatar_plus/avatar_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarPickerScreen extends StatefulWidget {
  const AvatarPickerScreen({super.key});

  @override
  State<AvatarPickerScreen> createState() => _AvatarPickerScreenState();
}

class _AvatarPickerScreenState extends State<AvatarPickerScreen> {
  String selectedAvatar = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Pick your avatar"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 avatars per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: avatarList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setState(() {
                    selectedAvatar = avatarList[index]["name"] as String;
                  }),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: avatarList[index]["name"] ==  selectedAvatar ? Border.all(color: Colors.blue, width: 2) : Border.all(color: Colors.black),
                    ),
                    child: avatarList[index]["widget"] as Widget,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: selectedAvatar != "" ? () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("dp", selectedAvatar);
                Get.back();
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}

final avatarList = [
  {
    "name": "sample1",
    "widget": AvatarPlus("sample1"),
  },
  {
    "name": "sample2",
    "widget": AvatarPlus("sample2"),
  },
  {
    "name": "sample3",
    "widget": AvatarPlus("sample3"),
  },
  {
    "name": "sample4",
    "widget": AvatarPlus("sample4"),
  },
  {
    "name": "sample5",
    "widget": AvatarPlus("sample5"),
  },
  {
    "name": "sample6",
    "widget": AvatarPlus("sample6"),
  },
  {
    "name": "sample7",
    "widget": AvatarPlus("sample7"),
  },
  {
    "name": "sample8",
    "widget": AvatarPlus("sample8"),
  },
  {
    "name": "sample9",
    "widget": AvatarPlus("sample9"),
  },
  {
    "name": "sample10",
    "widget": AvatarPlus("sample10"),
  },
  {
    "name": "sample11",
    "widget": AvatarPlus("sample11"),
  },
  {
    "name": "sample12",
    "widget": AvatarPlus("sample12"),
  },
  {
    "name": "sample13",
    "widget": AvatarPlus("sample13"),
  },
  {
    "name": "sample14",
    "widget": AvatarPlus("sample14"),
  },
  {
    "name": "sample15",
    "widget": AvatarPlus("sample15"),
  },
  {
    "name": "sample16",
    "widget": AvatarPlus("sample16"),
  },
  {
    "name": "sample17",
    "widget": AvatarPlus("sample17"),
  },
  {
    "name": "sample18",
    "widget": AvatarPlus("sample18"),
  },
  {
    "name": "sample19",
    "widget": AvatarPlus("sample19"),
  },
  {
    "name": "sample20",
    "widget": AvatarPlus("sample20"),
  },
];
