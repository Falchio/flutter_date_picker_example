import 'package:flutter/material.dart';

class DatePickerViews extends StatefulWidget {
  const DatePickerViews({Key? key}) : super(key: key);

  @override
  State<DatePickerViews> createState() => _DatePickerViewsState();
}

class _DatePickerViewsState extends State<DatePickerViews> {
  DateTimeRange _selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final TextEditingController _dateTextFormController = TextEditingController();

  @override
  void initState() {
    _dateTextFormController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _editDateWidget(_selectedDateRange.start),
        _horizontalPadding(),
        _editDateWidget(_selectedDateRange.end),
        _horizontalPadding(),
        _selectDateRangeButton()
      ],
    );
  }

  Widget _selectDateRangeButton() {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: Expanded(
        child: ElevatedButton(
            onPressed: () => _datePicker(),
            child: const Text('выбрать период')),
      ),
    );
  }

  Widget _editDateWidget(DateTime dateTime) {
    final bool isStartDate = identical(_selectedDateRange.start, dateTime);
    final hint = isStartDate ? 'Начало периода' : 'Конец периода';
    return Container(
      constraints: const BoxConstraints(maxWidth: 170),
      child: Expanded(
          child: TextFormField(
              controller: _dateTextFormController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: hint,
              ))),
    );
  }

  Widget _horizontalPadding() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  void _datePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023, 1, 1),
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

  @override
  void dispose() {
    _dateTextFormController.dispose();
    super.dispose();
  }
}
