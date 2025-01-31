import 'package:get/get.dart';

class WorkoutController extends GetxController {
  final RxList<double> weeklyData1 = <double>[85, 90, 82, 88, 92, 85, 87].obs;
  final RxList<double> weeklyData2 = <double>[90, 85, 88, 90, 85, 88, 90].obs;
  final RxList<double> weeklyData3 = <double>[85, 90, 85, 90, 85, 90, 85].obs;
  final RxList<String> weekDays =
      ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'].obs;
  final RxInt selectedTab = 0.obs;
}
