import 'dart:typed_data';

import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/tls_adapter.dart';

void main() {
  test('sin certificado no se cambia el adaptador por defecto', () {
    expect(pinnedAdapter(null, strict: true), isNull);
    expect(pinnedAdapter(null, strict: false), isNull);
  });

  test('con certificado se usa un adaptador propio', () {
    final bytes = Uint8List.fromList([1, 2, 3]);
    expect(pinnedAdapter(bytes, strict: true), isA<IOHttpClientAdapter>());
    expect(pinnedAdapter(bytes, strict: false), isA<IOHttpClientAdapter>());
  });
}
