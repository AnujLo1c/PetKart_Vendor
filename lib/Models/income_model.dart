class IncomeModel {
  final List<Map<String, dynamic>> incomeData;

  // Main Constructor with default values
  IncomeModel({
    double allCurrentGrossSales = 0.0,
    double allPreviousGrossSales = 0.0,
    double allCurrentEarnings = 0.0,
    double allPreviousEarnings = 0.0,
    double allCurrentProductSales = 0.0,
    double allPreviousProductSales = 0.0,
    double allCurrentTotalSales = 0.0,
    double allPreviousTotalSales = 0.0,
    double dayCurrentGrossSales = 0.0,
    double dayPreviousGrossSales = 0.0,
    double dayCurrentEarnings = 0.0,
    double dayPreviousEarnings = 0.0,
    double dayCurrentProductSales = 0.0,
    double dayPreviousProductSales = 0.0,
    double dayCurrentTotalSales = 0.0,
    double dayPreviousTotalSales = 0.0,
    double monthCurrentGrossSales = 0.0,
    double monthPreviousGrossSales = 0.0,
    double monthCurrentEarnings = 0.0,
    double monthPreviousEarnings = 0.0,
    double monthCurrentProductSales = 0.0,
    double monthPreviousProductSales = 0.0,
    double monthCurrentTotalSales = 0.0,
    double monthPreviousTotalSales = 0.0,
    double yearCurrentGrossSales = 0.0,
    double yearPreviousGrossSales = 0.0,
    double yearCurrentEarnings = 0.0,
    double yearPreviousEarnings = 0.0,
    double yearCurrentProductSales = 0.0,
    double yearPreviousProductSales = 0.0,
    double yearCurrentTotalSales = 0.0,
    double yearPreviousTotalSales = 0.0,
  }) : incomeData = [
    {
      'name': 'All',
      'currentGrossSales': allCurrentGrossSales,
      'previousGrossSales': allPreviousGrossSales,
      'currentEarnings': allCurrentEarnings,
      'previousEarnings': allPreviousEarnings,
      'currentProductSales': allCurrentProductSales,
      'previousProductSales': allPreviousProductSales,
      'currentTotalSales': allCurrentTotalSales,
      'previousTotalSales': allPreviousTotalSales,
    },
    {
      'name': 'Day',
      'currentGrossSales': dayCurrentGrossSales,
      'previousGrossSales': dayPreviousGrossSales,
      'currentEarnings': dayCurrentEarnings,
      'previousEarnings': dayPreviousEarnings,
      'currentProductSales': dayCurrentProductSales,
      'previousProductSales': dayPreviousProductSales,
      'currentTotalSales': dayCurrentTotalSales,
      'previousTotalSales': dayPreviousTotalSales,
    },
    {
      'name': 'Month',
      'currentGrossSales': monthCurrentGrossSales,
      'previousGrossSales': monthPreviousGrossSales,
      'currentEarnings': monthCurrentEarnings,
      'previousEarnings': monthPreviousEarnings,
      'currentProductSales': monthCurrentProductSales,
      'previousProductSales': monthPreviousProductSales,
      'currentTotalSales': monthCurrentTotalSales,
      'previousTotalSales': monthPreviousTotalSales,
    },
    {
      'name': 'Year',
      'currentGrossSales': yearCurrentGrossSales,
      'previousGrossSales': yearPreviousGrossSales,
      'currentEarnings': yearCurrentEarnings,
      'previousEarnings': yearPreviousEarnings,
      'currentProductSales': yearCurrentProductSales,
      'previousProductSales': yearPreviousProductSales,
      'currentTotalSales': yearCurrentTotalSales,
      'previousTotalSales': yearPreviousTotalSales,
    },
  ];

  // Named Constructor to initialize from a provided data list
  IncomeModel.fromData({required this.incomeData});

  // Factory constructor to create an instance from a Map
  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel.fromData(
      incomeData: List<Map<String, dynamic>>.from(map['incomeData'] ?? []),
    );
  }

  // Method to convert IncomeModel instance to Map
  Map<String, dynamic> toMap() {
    return {
      'incomeData': incomeData,
    };
  }

  // Method to update data in the incomeData list
  void updateIncomeData(String period, Map<String, double> updates) {
    for (var map in incomeData) {
      if (map['name'] == period) {
        updates.forEach((key, value) {
          map[key] = (map[key] ?? 0.0) + value; // Increment the value
        });
        break;
      }
    }
  }

  // Method to retrieve a specific field's data from the incomeData list
  double getIncomeData(String period, String field) {
    for (var map in incomeData) {
      if (map['name'] == period) {
        return map[field] ?? 0.0;
      }
    }
    return 0.0;
  }

  // Reset specific period data
  void resetIncomeData(String period) {
    for (var map in incomeData) {
      if (map['name'] == period) {
        map['previousGrossSales'] = map['currentGrossSales'] ?? 0.0;
        map['previousEarnings'] = map['currentEarnings'] ?? 0.0;
        map['previousProductSales'] = map['currentProductSales'] ?? 0.0;
        map['previousTotalSales'] = map['currentTotalSales'] ?? 0.0;

        map['currentGrossSales'] = 0.0;
        map['currentEarnings'] = 0.0;
        map['currentProductSales'] = 0.0;
        map['currentTotalSales'] = 0.0;
        break;
      }
    }
  }
}
