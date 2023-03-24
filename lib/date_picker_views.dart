import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

class DatePickerViews extends StatefulWidget {
  const DatePickerViews({Key? key}) : super(key: key);

  @override
  State<DatePickerViews> createState() => _DatePickerViewsState();
}

class _DatePickerViewsState extends State<DatePickerViews> {
  DateTimeRange _selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

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
              _editDateWidget(_selectedDateRange.start),
              _horizontalPadding(),
              _editDateWidget(_selectedDateRange.end),
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

  Widget _editDateWidget(DateTime dateTime) {
    final bool isStartDate = identical(_selectedDateRange.start, dateTime);
    final hint = isStartDate ? 'start DD.MM.YYYY' : 'end DD.MM.YYYY';
    final formKey = isStartDate ? _startDateKey : _endDateKey;
    return Form(
      key: formKey,
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validateDate,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9\\.]')),
              LengthLimitingTextInputFormatter(10)
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: hint,
            )),
      ),
    );
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter date, please';
    } else if (!dateRegex.hasMatch(value)) {
      return 'Wrong date format';
    }
    return null;
  }

  ///https://regex101.com/r/wg2Mb3/1
  final RegExp dateRegex = RegExp(
      '^([12][0-9]|3[01]|0?[1-9])\\.?\$|^([12][0-9]|3[01]|0?[1-9])\\.(0?[1-9]|1[012])\\.?\$|^([12][0-9]|3[01]|0?[1-9]).(0?[1-9]|1[012])\\.\$|^([12][0-9]|3[01]|0?[1-9])\\.(0?[1-9]|1[012])\\.\\d{0,4}\$');

  Widget _horizontalPadding() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  void _datePicker() async {
    final firstTransactionRecordDate = DateTime(2023, 1, 1);

    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: firstTransactionRecordDate,
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  DateTimeRange? get selectedDateRange => _selectedDateRange;

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
        child: const Text('Submit'),
      ),
    );
  }
}
