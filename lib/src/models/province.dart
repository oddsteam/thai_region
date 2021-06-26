part of models;

class Province {
  Province._({
    required this.id,
    required this.region,
    required this.name,
    required this.district,
  });

  factory Province.fromMap(
    Map<String, dynamic> data, {
    List<District>? district,
  }) =>
      Province._(
        id: data['id'],
        region: getRegion(data['region']),
        name: Translator.fromMap(data['name']),
        district: district
            ?.map((d) =>
              District._(
                id: d.id,
                name: d.name,
                provinceId: data['id'],
                subDistrict: d.subDistrict,
              ))
            .toList(growable: false)
          ?? const [],
      );

  final int id;
  final Region region;
  final Translator name;
  final List<District> district;

  Map<String, dynamic> toMap() =>
      {
        'id': id,
        'region': region.translate.toMap(),
        'name': name.toMap(),
      };

  Map<String, dynamic> toAllMap() =>
      {
        'id': id,
        'region': region.translate.toMap(),
        'name': name.toMap(),
        'district': district.map((d) => d.toAllMap()),
      };

  @override
  String toString({
    Locale locale = const Locale('en'),
  }) {
    final _name = name.toString(locale: locale);
    final _region = region.translate.toString(locale: locale);

    return "Province(id: $id, region: $_region, name: $_name)";
  }
}