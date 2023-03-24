import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test/date_formatter.dart';

class DatePickerViews extends StatefulWidget {
  const DatePickerViews({Key? key}) : super(key: key);

  @override
  State<DatePickerViews> createState() => _DatePickerViewsState();
}

class _DatePickerViewsState extends State<DatePickerViews> {
  final TextEditingController _startController =
      TextEditingController(text: DateTime.now().ddMMyyyy());
  final TextEditingController _endController =
      TextEditingController(text: DateTime.now().ddMMyyyy());

  final _startDateKey = GlobalKey<FormState>();
  final _endDateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _editDateWidget(isStartDate: true),
              _horizontalPadding(),
              _editDateWidget(isStartDate: false),
              _horizontalPadding(),
              _selectDateRangeButton()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _loadDataButton(),
          ]),
        ),
      ],
    );
  }

  Widget _selectDateRangeButton() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: ElevatedButton(
          onPressed: () => _datePicker(), child: const Text('Choice range')),
    );
  }

  Widget _editDateWidget({required bool isStartDate}) {
    final hint = isStartDate ? 'start DD.MM.YYYY' : 'end DD.MM.YYYY';
    final formKey = isStartDate ? _startDateKey : _endDateKey;
    final controller = isStartDate ? _startController : _endController;
    return Form(
      key: formKey,
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9\\.]')),
              LengthLimitingTextInputFormatter(10)
            ],
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validateDate,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: hint,
            )),
      ),
    );
  }

  ///https://stackoverflow.com/questions/62467842/flutter-textfield-input-validation-for-a-date/62833230#62833230
  ///https://regex101.com/r/wg2Mb3/1
  // final RegExp dateRegex = RegExp(
  //     '^([12][0-9]|3[01]|0?[1-9])\\.?\$|^([12][0-9]|3[01]|0?[1-9])\\.(0?[1-9]|1[012])\\.?\$|^([12][0-9]|3[01]|0?[1-9]).(0?[1-9]|1[012])\\.\$|^([12][0-9]|3[01]|0?[1-9])\\.(0?[1-9]|1[012])\\.\\d{0,4}\$');
  final RegExp dateRegex = RegExp(
      '^([12][0-9]|3[01]|0?[1-9])\\.(0?[1-9]|1[012])\\.(?<!\\d)(\\d{2}|\\d{4})(?!\\d)\$');

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter date, please';
    } else if (!dateRegex.hasMatch(value)) {
      return 'Wrong date format';
    }
    return null;
  }

  Widget _horizontalPadding() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  void _datePicker() async {
    final firstTransactionRecordDate = DateTime(2023, 1, 1);

    final DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: firstTransactionRecordDate,
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (dateTimeRange != null) {
      _startController.text = dateTimeRange.start.ddMMyyyy();
      _endController.text = dateTimeRange.end.ddMMyyyy();
    }
  }

  Widget _loadDataButton() {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: ElevatedButton(
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_startDateKey.currentState!.validate() &&
              _endDateKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.

            String start = _startController.text;
            String end = _endController.text;

            DateTime? startDate = _tryParseDate(start);
            DateTime? endDate = _tryParseDate(end);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Processing Data: start = ${startDate?.ddMMyyyy()}; end = ${endDate?.ddMMyyyy()}')),
            );
          }
        },
        child: const Text('Submit'),
      ),
    );
  }

  DateTime? _tryParseDate(String text) {
    try{
     String pattern ;
    } catch (e){
      print(e);
      return null;
    }
  }

  // List<DateParseHelper> helpers = [
  //   DateParseHelper(
  //       regExp: RegExp('^([12][0-9]|3[01]|0?[1-9])\$'),
  //       pattern: 'ddMMyyyy',
  //       isAddMonth: true,
  //       isAddYear: true), // 'd'|'dd'
  //   DateParseHelper(
  //       regExp: RegExp('^([12][0-9]|3[01]|0?[1-9])\\.\$'),
  //       pattern: 'dd.MMyyyy',
  //       isAddMonth: true,
  //       isAddYear: true) // 'd.'|'dd.'
  // ];
}

// class DateParseHelper {
//   final RegExp _regExp;
//   final String _pattern;
//   final bool _isAddMonth;
//   final bool _isAddYear;
//
//   DateParseHelper(
//       {required RegExp regExp,
//       required String pattern,
//       required bool isAddMonth,
//       required bool isAddYear})
//       : _isAddYear = isAddYear,
//         _isAddMonth = isAddMonth,
//         _pattern = pattern,
//         _regExp = regExp;
//
//   bool hasMatch(String text) {
//     return _regExp.hasMatch(text);
//   }
//
//   DateTime? tryParse(String text) {
//     final DateTime now = DateTime.now();
//
//     String newPattern = ; // как определить исходя из имеющихся RegExp сколько дней в дате? Два или один? Перекрывать все имеющиеся случаи RegExp не сильно хочется.
//
//     String adding = _pattern.replaceFirst('dd', '');
//
//     final String monthReplacement = _isAddMonth ? now.month.toString() : '';
//     adding = adding.replaceFirst('MM', monthReplacement);
//
//     final String yearReplacement = _isAddYear ? now.year.toString() : '';
//     adding = adding.replaceFirst('yyyy', yearReplacement);
//
//     final DateFormat dateFormat = DateFormat(_pattern);
//     try {
//       return dateFormat.parseStrict('$text$adding');
//     } catch (e) {
//       print(e);
//       print('pattern = $_pattern; text date = $text$adding');
//       return null;
//     }
//   }
// }
