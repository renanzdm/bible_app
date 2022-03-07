enum VersionsType {ptAa, ptNvi, ptAcf,enBbe,enKjv}

class VersionsModel {
  final VersionsType name;
  final String value;
  final String description;
  VersionsModel({
    this.description = '',
    this.name = VersionsType.ptNvi,
    this.value = '',
  });
}
