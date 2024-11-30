class Params {
  double? fajr;
  String? isha;

  Params({this.fajr, this.isha});

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        fajr: (json['Fajr'] as num?)?.toDouble(),
        isha: json['Isha'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Fajr': fajr,
        'Isha': isha,
      };
}
