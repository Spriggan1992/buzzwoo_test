extension StringX on String {
  String get emptyData => isEmpty || contains('Aggregates') ? 'No data' : this;
}
