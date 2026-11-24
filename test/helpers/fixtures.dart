import 'dart:convert';
import 'dart:io';

/// Lee `test/fixtures/<name>` como JSON.
Map<String, dynamic> fixture(String name) =>
    jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;
