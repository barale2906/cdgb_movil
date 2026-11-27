/// Campos de la hoja de vida técnica de un equipo y a qué tipo aplican.
abstract final class TechnicalProfileFields {
  /// Campos de texto (o número) de la hoja de vida.
  static const textFields = [
    'manufacturer',
    'country_of_origin',
    'accessories',
    'usage_recommendations',
    'invima_registry',
    'voltage',
    'current',
    'power',
    'frequency',
    'operating_conditions',
    'processor',
    'ram',
    'storage',
    'operating_system',
    'ip_address',
    'mac_address',
    'hostname',
    'manufacture_year',
    'useful_life_years',
  ];

  /// Campos con valores fijos (listas desplegables).
  static const choiceFields = [
    'acquisition_mode',
    'risk_class',
    'biomedical_class',
    'power_source',
  ];

  /// Si [field] aplica al tipo de equipo: los de cómputo no llevan los
  /// campos biomédicos y al revés.
  static bool applies(String field, {required bool biomedical}) =>
      switch (field) {
        'invima_registry' ||
        'risk_class' ||
        'biomedical_class' ||
        'power_source' ||
        'voltage' ||
        'current' ||
        'power' ||
        'frequency' ||
        'operating_conditions' => biomedical,
        'processor' ||
        'ram' ||
        'storage' ||
        'operating_system' ||
        'ip_address' ||
        'mac_address' ||
        'hostname' => !biomedical,
        _ => true,
      };
}
