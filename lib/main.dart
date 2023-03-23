import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'date_picker_views.dart';
import 'exapmle_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SlidingViewportOnSelection.withSampleData())),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child:DatePickerViews()
            )
          ],
        ),
      ),
    );
  }
}

// main.dart
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'KindaCode.com',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   DateTimeRange? _selectedDateRange;
//
//   // This function will be triggered when the floating button is pressed
//   void _show() async {
//     final DateTimeRange? result = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2022, 1, 1),
//       lastDate: DateTime(2030, 12, 31),
//       currentDate: DateTime.now(),
//       saveText: 'Done',
//     );
//
//     if (result != null) {
//       // Rebuild the UI
//       print(result.start.toString());
//       setState(() {
//         _selectedDateRange = result;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('KindaCode.com')),
//       body: _selectedDateRange == null
//           ? const Center(
//         child: Text('Press the button to show the picker'),
//       )
//           : Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Start date
//             Text(
//               "Start date: ${_selectedDateRange?.start.toString().split(' ')[0]}",
//               style: const TextStyle(fontSize: 24, color: Colors.blue),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             // End date
//             Text(
//                 "End date: ${_selectedDateRange?.end.toString().split(' ')[0]}",
//                 style: const TextStyle(fontSize: 24, color: Colors.red))
//           ],
//         ),
//       ),
//       // This button is used to show the date range picker
//       floatingActionButton: FloatingActionButton(
//         onPressed: _show,
//         child: const Icon(Icons.date_range),
//       ),
//     );
//   }
// }
