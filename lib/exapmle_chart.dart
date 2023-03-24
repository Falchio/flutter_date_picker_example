/// Example of the chart behavior that centers the viewport on domain selection.

import 'package:community_charts_flutter/community_charts_flutter.dart'
as charts;
import 'package:flutter/material.dart';

class SlidingViewportOnSelection extends StatelessWidget {
  final List<charts.Series<dynamic,String>> seriesList;
  final bool animate;

  SlidingViewportOnSelection(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SlidingViewportOnSelection.withSampleData() {
    return SlidingViewportOnSelection(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      behaviors: [
        // Add the sliding viewport behavior to have the viewport center on the
        // domain that is currently selected.
        charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        charts.PanAndZoomBehavior(),
      ],
      // Set an initial viewport to demonstrate the sliding viewport behavior on
      // initial chart load.
      domainAxis: charts.OrdinalAxisSpec(
          viewport: charts.OrdinalViewport('2018', 8)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
      OrdinalSales('2018', 33),
      OrdinalSales('2019', 80),
      OrdinalSales('2020', 21),
      OrdinalSales('2021', 77),
      OrdinalSales('2022', 8),
      OrdinalSales('2023', 12),
      OrdinalSales('2024', 42),
      OrdinalSales('2025', 70),
      OrdinalSales('2026', 77),
      OrdinalSales('2027', 55),
      OrdinalSales('2028', 19),
      OrdinalSales('2029', 66),
      OrdinalSales('2030', 27),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}