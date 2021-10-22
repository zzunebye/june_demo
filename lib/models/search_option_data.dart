class SearchOptionData {
  List<double> monthly_rate = [0, 99999];
  int limit;
  List<String> district;
  List time = [];
  String term = '';

  SearchOptionData.empty({
    this.limit = 10,
    this.district = const [],
    this.time = const [],
  });

  @override
  List<Object>? get props => [limit, district, time, monthly_rate];

  SearchOptionData(
    this.limit,
    this.district,
    this.time,
    this.monthly_rate,
    this.term,
  );
}
