import 'package:avicare/model/old/individual_dates_model.dart';
import 'package:intl/intl.dart';

DateTime today = DateTime.now();
List<String> dates = getCurrentWeekDates();

List<String> getCurrentWeekDates() {
  int currentWeekday = today.weekday; // Monday = 1, Sunday = 7

  // Find start of the week (Monday)
  DateTime startOfWeek = today.subtract(Duration(days: currentWeekday - 1));

  // Generate list of dates (Monday to Sunday)
  List<String> weekDates = List.generate(7, (index) {
    DateTime date = startOfWeek.add(Duration(days: index));
    return DateFormat('dd').format(date); // Format as "YYYY-MM-DD"
  });

  return weekDates;
}

List<IndividualDatesModel> individualDatesData = [
  IndividualDatesModel(date: dates[0], isSelected: today.day.toString() == dates[0], day: "Mon", isToday: today.day.toString() == dates[0]),
  IndividualDatesModel(date: dates[1], isSelected: today.day.toString() == dates[1], day: "Tue", isToday: today.day.toString() == dates[1]),
  IndividualDatesModel(date: dates[2], isSelected: today.day.toString() == dates[2], day: "Wed", isToday: today.day.toString() == dates[2]),
  IndividualDatesModel(date: dates[3], isSelected: today.day.toString() == dates[3], day: "Thu", isToday: today.day.toString() == dates[3]),
  IndividualDatesModel(date: dates[4], isSelected: today.day.toString() == dates[4], day: "Fri", isToday: today.day.toString() == dates[4]),
  IndividualDatesModel(date: dates[5], isSelected: today.day.toString() == dates[5], day: "Sat", isToday: today.day.toString() == dates[5]),
  IndividualDatesModel(date: dates[6], isSelected: today.day.toString() == dates[6], day: "Sun", isToday: today.day.toString() == dates[6]),
];

// List<IndividualDatesModel> individualDatesData = [
//   IndividualDatesModel(
//     date: "11",
//     isSelected: false,
//     day: "Mon",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "12",
//     isSelected: true,
//     day: "Tue",
//     isToday: true,
//   ),
//   IndividualDatesModel(
//     date: "13",
//     isSelected: false,
//     day: "Wed",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "14",
//     isSelected: false,
//     day: "Thu",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "15",
//     isSelected: true,
//     day: "Fri",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "16",
//     isSelected: false,
//     day: "Sat",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "17",
//     isSelected: false,
//     day: "Sun",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "11",
//     isSelected: false,
//     day: "Mon",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "12",
//     isSelected: true,
//     day: "Tue",
//     isToday: true,
//   ),
//   IndividualDatesModel(
//     date: "13",
//     isSelected: false,
//     day: "Wed",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "14",
//     isSelected: false,
//     day: "Thu",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "15",
//     isSelected: true,
//     day: "Fri",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "16",
//     isSelected: false,
//     day: "Sat",
//     isToday: false,
//   ),
//   IndividualDatesModel(
//     date: "17",
//     isSelected: false,
//     day: "Sun",
//     isToday: false,
//   ),
// ];
