import 'package:get/get.dart';
import 'package:petkart_vendor/Models/income_model.dart';

class DashboardAllReportController extends GetxController {
  var selectedTab = 'All'.obs;

  // Injected data from the previous screen
  late IncomeModel data;

  // Map structure for different report categories with injected values
  final Map<String, List<Map<String, String>>> reports = {};

  @override
  void onInit() {
    super.onInit();

    // Retrieve the IncomeModel data from Get.arguments
    data = Get.arguments;

    // Print the IncomeModel data to the console
    print("IncomeModel data received from previous screen: $data");

    // Populate the reports map based on the received data
    reports.addAll({
      'All': [
        {'label': 'Earnings', 'value': data.getIncomeData("All", 'currentGrossSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("All", 'currentGrossSales'), data.getIncomeData("All", 'previousGrossSales'))},
        {'label': 'Total Orders', 'value': data.getIncomeData("All", 'currentEarnings').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("All", 'currentGrossSales'), data.getIncomeData("All", 'previousGrossSales'))},
        {'label': 'Total Products', 'value': data.getIncomeData("All", 'currentProductSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("All", 'currentGrossSales'), data.getIncomeData("All", 'previousGrossSales'))},
        {'label': 'Gross Sales', 'value': data.getIncomeData("All", 'currentTotalSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("All", 'currentGrossSales'), data.getIncomeData("All", 'previousGrossSales'))},
      ],
      'Today': [
        {'label': 'Earnings', 'value': data.getIncomeData("Day", 'currentGrossSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Day", 'currentGrossSales'), data.getIncomeData("Day", 'previousGrossSales'))},
        {'label': 'Total Orders', 'value': data.getIncomeData("Day", 'currentEarnings').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Day", 'currentGrossSales'), data.getIncomeData("Day", 'previousGrossSales'))},
        {'label': 'Total Products', 'value': data.getIncomeData("Day", 'currentProductSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Day", 'currentGrossSales'), data.getIncomeData("Day", 'previousGrossSales'))},
        {'label': 'Gross Sales', 'value': data.getIncomeData("Day", 'currentTotalSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Day", 'currentGrossSales'), data.getIncomeData("Day", 'previousGrossSales'))},
      ],
      'This Month': [
        {'label': 'Earnings', 'value': data.getIncomeData("Month", 'currentGrossSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Month", 'currentGrossSales'), data.getIncomeData("Month", 'previousGrossSales'))},
        {'label': 'Total Orders', 'value': data.getIncomeData("Month", 'currentEarnings').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Month", 'currentGrossSales'), data.getIncomeData("Month", 'previousGrossSales'))},
        {'label': 'Total Products', 'value': data.getIncomeData("Month", 'currentProductSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Month", 'currentGrossSales'), data.getIncomeData("Month", 'previousGrossSales'))},
        {'label': 'Gross Sales', 'value': data.getIncomeData("Month", 'currentTotalSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Month", 'currentGrossSales'), data.getIncomeData("Month", 'previousGrossSales'))},
      ],
      'This Year': [
        {'label': 'Earnings', 'value': data.getIncomeData("Year", 'currentGrossSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Year", 'currentGrossSales'), data.getIncomeData("Year", 'previousGrossSales'))},
        {'label': 'Total Orders', 'value': data.getIncomeData("Year", 'currentEarnings').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Year", 'currentGrossSales'), data.getIncomeData("Year", 'previousGrossSales'))},
        {'label': 'Total Products', 'value': data.getIncomeData("Year", 'currentProductSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Year", 'currentGrossSales'), data.getIncomeData("Year", 'previousGrossSales'))},
        {'label': 'Gross Sales', 'value': data.getIncomeData("Year", 'currentTotalSales').toStringAsFixed(1),
          'change': getGrowth(data.getIncomeData("Year", 'currentGrossSales'), data.getIncomeData("Year", 'previousGrossSales'))},
      ],
    });
  }
  String getGrowth(curr,prev) {
    if(prev==0)return '0%';
    double d=(((curr+prev)/prev)*100);

    return d<=0?'O%':d.toStringAsFixed(1)+'%';
  }

  // This method retrieves the current report based on the selected tab
  List<Map<String, String>> get currentReport => reports[selectedTab.value] ?? [];
}
