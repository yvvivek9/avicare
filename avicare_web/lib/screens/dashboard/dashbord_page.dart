import 'package:avicare_web/constants/custom_colors.dart';
import 'package:avicare_web/screens/dashboard/widget/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:avicare_web/utils/utils.dart';
import '../../controller/main_controller.dart';
import 'package:avicare_web/models/user.dart';

// Controller to manage map state
class DashboardController extends GetxController {
  final selectedCountry = 'Country Specific'.obs;
  final stateData = <String, dynamic>{}.obs;
  final highlightedStates = <String>[].obs;
  final markers = Rx<List<Marker>>([]);

  void selectCountry(String country) {
    selectedCountry.value = country;
  }

  void addStateData(String state, dynamic data) {
    stateData[state] = data;
    highlightedStates.add(state);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final users = await User.fetchUserList();
      safePrint(users);
      markers.value = users
          .map(
            (u) => Marker(
              point: LatLng(double.parse(u.latitude ?? "0"), double.parse(u.longitude ?? "0")),
              child: Tooltip(
                message: u.name,
                child: Icon(
                  Icons.location_pin,
                  size: 20.h,
                  color: Colors.red,
                ),
              ),
            ),
          )
          .toList();
    } catch (e) {
      safePrint(e);
      showErrorSnackBar(content: "Error fetching user data");
    }
  }
}

class DashboardPage extends StatelessWidget {
  final controller = Get.put(DashboardController());
  final List<Map<String, dynamic>> statusData = [
    {
      'status': 'Active regularly',
      'locations': 'Mumbai, Pune, Delhi, Haryana',
    },
    {
      'status': 'Less active',
      'locations': 'Kolkata, Rajasthan',
    },
    {
      'status': 'Dormant',
      'locations': 'Kerala',
    },
  ];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 55.h),
            // Stats cards row
            _buildStatsCards(),
            // Maps row
            // World Map
            SizedBox(
              width: 674.w,
              height: 388.h,
              child: Obx(() => _buildWorldMap(controller.markers.value)),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 670.w,
              height: 350.h,
              child: StatisticsChartWidget(),
            ),
            // Country specific map
          ],
        ),
        SizedBox(width: 24.w),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: CustomColors.grey,
                  height: 54.h,
                  width: 358.w,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      labelText: 'Search by state',
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                Container(
                  width: 54.h,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: CustomColors.grey,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Icon(
                    Icons.settings,
                    size: 32.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 65.h),
            SizedBox(
              height: 800.h,
              width: 440.w,
              child: _buildCountryMap(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorldMap(List<Marker> markers) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(20.5937, 78.9629), // Centered on India
            initialZoom: 4,
            interactionOptions: InteractionOptions(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: markers,
            ),
            // Add GeoJSON layer for country boundaries
            // You'll need to load and parse GeoJSON data
            // This is a simplified example
          ],
        ),
      ),
    );
  }

  Widget _buildCountryMap() {
    return Obx(() => AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User by Region (${controller.selectedCountry.value})',
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 400.w,
                      height: 450.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FlutterMap(
                          options: MapOptions(
                            // Adjust center based on selected country
                            initialCenter: LatLng(20.5937, 78.9629),
                            initialZoom: 5,
                            interactionOptions: InteractionOptions(),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            // Add GeoJSON layer for state boundaries
                            // This will be populated based on selected country
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Row(
                    children: [
                      Text('User by Region',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 16.h),
                      Text(
                        '(${controller.selectedCountry.value})',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 384.w, // Adjust width as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.black,
                          width: 1.w,
                        ),
                        verticalInside: BorderSide(
                          color: Colors.black,
                          width: 1.w,
                        ),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(125.w),
                        // Adjust the width for status column
                        1: FlexColumnWidth(),
                        // Locations column takes remaining space
                      },
                      children: statusData.map((row) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  row['status'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  row['locations'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildStatsCards() {
    return Row(
      spacing: 16.w,
      children: [
        _buildStatCard(
          'Total Customers',
          '39,785',
          Colors.purple.shade100,
          'assets/images/customers_icon.png',
        ),
        _buildStatCard(
          'Total Sales',
          '21,1111',
          Colors.blue.shade100,
          'assets/images/sales_icon.png',
        ),
        _buildStatCard(
          'Total Sales',
          '\$ 41537',
          Colors.green.shade100,
          'assets/images/money_icon.png',
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color, String icon) {
    return SizedBox(
      width: 214.w,
      height: 120.h,
      child: Card(
        color: color,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    icon,
                    width: 24.w,
                    height: 24.h,
                  )
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
