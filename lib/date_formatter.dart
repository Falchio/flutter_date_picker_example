extension DateFormatter on DateTime {
  String ddMMyy() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString().substring(2, 4)}';
  }

  String ddMMyyyy() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString()}';
  }
}
