import 'package:flutter/material.dart';

class DatePickerViews extends StatefulWidget {
  const DatePickerViews({Key? key}) : super(key: key);

  @override
  State<DatePickerViews> createState() => _DatePickerViewsState();
}

class _DatePickerViewsState extends State<DatePickerViews> {
  DateTimeRange _selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final TextEditingController _startDateTextFormController =
      TextEditingController();
  final TextEditingController _endDateTextFormController =
      TextEditingController();

  @override
  void initState() {
    _addListenersToTextControllers();
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
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: ElevatedButton(
          onPressed: () => _datePicker(), child: const Text('выбрать период')),
    );
  }

  Widget _editDateWidget(DateTime dateTime) {
    final bool isStartDate = identical(_selectedDateRange.start, dateTime);
    final hint = isStartDate ? 'Начало периода' : 'Конец периода';
    final controller =
        isStartDate ? _startDateTextFormController : _endDateTextFormController;
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: hint,
          )),
    );
  }

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

  void _addListenersToTextControllers() {
    //пришлось делать прокси функции, так как dart не воспринимает функции с аргументами
    _startDateTextFormController.addListener(_startDateListener);
    _endDateTextFormController.addListener(_endDateListener);
  }

  void _disposeTextControllers() {
    for (var element in <TextEditingController>[
      _startDateTextFormController,
      _endDateTextFormController
    ]) {
      element.dispose();
    }
  }

  void _startDateListener() {
    _dateTextFormListener(_startDateTextFormController);
  }

  void _endDateListener() {
    _dateTextFormListener(_endDateTextFormController);
  }

  void _dateTextFormListener(TextEditingController controller) {
    _cutText(controller, 10);
  }

  void _cutText(TextEditingController controller, int length) {
    var value = controller.text;
    if (value.length > length) {
      controller.text = value.substring(0, length);
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }
  }

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  @override
  void dispose() {
    _disposeTextControllers();
    super.dispose();
  }
}
