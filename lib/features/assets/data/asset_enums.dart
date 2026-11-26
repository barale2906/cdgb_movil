/// Estado de un activo (`status`). Los textos se muestran desde l10n.
enum AssetStatus {
  operational('operational'),
  maintenance('maintenance'),
  outOfService('out_of_service'),
  available('available'),
  retired('retired'),
  unknown('unknown')
  ;

  const AssetStatus(this.value);

  final String value;

  static AssetStatus parse(Object? raw) => values.firstWhere(
    (status) => status.value == raw,
    orElse: () => unknown,
  );
}

enum AssetType {
  biomedical('biomedical'),
  computing('computing'),
  general('general'),
  unknown('unknown')
  ;

  const AssetType(this.value);

  final String value;

  static AssetType parse(Object? raw) => values.firstWhere(
    (type) => type.value == raw,
    orElse: () => unknown,
  );
}
