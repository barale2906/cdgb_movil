// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medsys_patient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedsysAppointment {

@JsonKey(name: 'codcontrol') String get controlCode;@JsonKey(name: 'fecha') String? get date;@JsonKey(name: 'hora') String? get time;@JsonKey(name: 'servicio') String? get serviceName;@JsonKey(name: 'estado') String? get status;
/// Create a copy of MedsysAppointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedsysAppointmentCopyWith<MedsysAppointment> get copyWith => _$MedsysAppointmentCopyWithImpl<MedsysAppointment>(this as MedsysAppointment, _$identity);

  /// Serializes this MedsysAppointment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedsysAppointment&&(identical(other.controlCode, controlCode) || other.controlCode == controlCode)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,controlCode,date,time,serviceName,status);

@override
String toString() {
  return 'MedsysAppointment(controlCode: $controlCode, date: $date, time: $time, serviceName: $serviceName, status: $status)';
}


}

/// @nodoc
abstract mixin class $MedsysAppointmentCopyWith<$Res>  {
  factory $MedsysAppointmentCopyWith(MedsysAppointment value, $Res Function(MedsysAppointment) _then) = _$MedsysAppointmentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'codcontrol') String controlCode,@JsonKey(name: 'fecha') String? date,@JsonKey(name: 'hora') String? time,@JsonKey(name: 'servicio') String? serviceName,@JsonKey(name: 'estado') String? status
});




}
/// @nodoc
class _$MedsysAppointmentCopyWithImpl<$Res>
    implements $MedsysAppointmentCopyWith<$Res> {
  _$MedsysAppointmentCopyWithImpl(this._self, this._then);

  final MedsysAppointment _self;
  final $Res Function(MedsysAppointment) _then;

/// Create a copy of MedsysAppointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? controlCode = null,Object? date = freezed,Object? time = freezed,Object? serviceName = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
controlCode: null == controlCode ? _self.controlCode : controlCode // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedsysAppointment].
extension MedsysAppointmentPatterns on MedsysAppointment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedsysAppointment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedsysAppointment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedsysAppointment value)  $default,){
final _that = this;
switch (_that) {
case _MedsysAppointment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedsysAppointment value)?  $default,){
final _that = this;
switch (_that) {
case _MedsysAppointment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'codcontrol')  String controlCode, @JsonKey(name: 'fecha')  String? date, @JsonKey(name: 'hora')  String? time, @JsonKey(name: 'servicio')  String? serviceName, @JsonKey(name: 'estado')  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedsysAppointment() when $default != null:
return $default(_that.controlCode,_that.date,_that.time,_that.serviceName,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'codcontrol')  String controlCode, @JsonKey(name: 'fecha')  String? date, @JsonKey(name: 'hora')  String? time, @JsonKey(name: 'servicio')  String? serviceName, @JsonKey(name: 'estado')  String? status)  $default,) {final _that = this;
switch (_that) {
case _MedsysAppointment():
return $default(_that.controlCode,_that.date,_that.time,_that.serviceName,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'codcontrol')  String controlCode, @JsonKey(name: 'fecha')  String? date, @JsonKey(name: 'hora')  String? time, @JsonKey(name: 'servicio')  String? serviceName, @JsonKey(name: 'estado')  String? status)?  $default,) {final _that = this;
switch (_that) {
case _MedsysAppointment() when $default != null:
return $default(_that.controlCode,_that.date,_that.time,_that.serviceName,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedsysAppointment implements MedsysAppointment {
  const _MedsysAppointment({@JsonKey(name: 'codcontrol') required this.controlCode, @JsonKey(name: 'fecha') this.date, @JsonKey(name: 'hora') this.time, @JsonKey(name: 'servicio') this.serviceName, @JsonKey(name: 'estado') this.status});
  factory _MedsysAppointment.fromJson(Map<String, dynamic> json) => _$MedsysAppointmentFromJson(json);

@override@JsonKey(name: 'codcontrol') final  String controlCode;
@override@JsonKey(name: 'fecha') final  String? date;
@override@JsonKey(name: 'hora') final  String? time;
@override@JsonKey(name: 'servicio') final  String? serviceName;
@override@JsonKey(name: 'estado') final  String? status;

/// Create a copy of MedsysAppointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedsysAppointmentCopyWith<_MedsysAppointment> get copyWith => __$MedsysAppointmentCopyWithImpl<_MedsysAppointment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedsysAppointmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedsysAppointment&&(identical(other.controlCode, controlCode) || other.controlCode == controlCode)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,controlCode,date,time,serviceName,status);

@override
String toString() {
  return 'MedsysAppointment(controlCode: $controlCode, date: $date, time: $time, serviceName: $serviceName, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MedsysAppointmentCopyWith<$Res> implements $MedsysAppointmentCopyWith<$Res> {
  factory _$MedsysAppointmentCopyWith(_MedsysAppointment value, $Res Function(_MedsysAppointment) _then) = __$MedsysAppointmentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'codcontrol') String controlCode,@JsonKey(name: 'fecha') String? date,@JsonKey(name: 'hora') String? time,@JsonKey(name: 'servicio') String? serviceName,@JsonKey(name: 'estado') String? status
});




}
/// @nodoc
class __$MedsysAppointmentCopyWithImpl<$Res>
    implements _$MedsysAppointmentCopyWith<$Res> {
  __$MedsysAppointmentCopyWithImpl(this._self, this._then);

  final _MedsysAppointment _self;
  final $Res Function(_MedsysAppointment) _then;

/// Create a copy of MedsysAppointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? controlCode = null,Object? date = freezed,Object? time = freezed,Object? serviceName = freezed,Object? status = freezed,}) {
  return _then(_MedsysAppointment(
controlCode: null == controlCode ? _self.controlCode : controlCode // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MedsysPatient {

@JsonKey(name: 'codigo') String get code;@JsonKey(name: 'documento') String get document;@JsonKey(name: 'nombre') String get name;@JsonKey(name: 'tipodoc') String? get documentType; List<MedsysAppointment> get recentAppointments;
/// Create a copy of MedsysPatient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedsysPatientCopyWith<MedsysPatient> get copyWith => _$MedsysPatientCopyWithImpl<MedsysPatient>(this as MedsysPatient, _$identity);

  /// Serializes this MedsysPatient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedsysPatient&&(identical(other.code, code) || other.code == code)&&(identical(other.document, document) || other.document == document)&&(identical(other.name, name) || other.name == name)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&const DeepCollectionEquality().equals(other.recentAppointments, recentAppointments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,document,name,documentType,const DeepCollectionEquality().hash(recentAppointments));

@override
String toString() {
  return 'MedsysPatient(code: $code, document: $document, name: $name, documentType: $documentType, recentAppointments: $recentAppointments)';
}


}

/// @nodoc
abstract mixin class $MedsysPatientCopyWith<$Res>  {
  factory $MedsysPatientCopyWith(MedsysPatient value, $Res Function(MedsysPatient) _then) = _$MedsysPatientCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'codigo') String code,@JsonKey(name: 'documento') String document,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'tipodoc') String? documentType, List<MedsysAppointment> recentAppointments
});




}
/// @nodoc
class _$MedsysPatientCopyWithImpl<$Res>
    implements $MedsysPatientCopyWith<$Res> {
  _$MedsysPatientCopyWithImpl(this._self, this._then);

  final MedsysPatient _self;
  final $Res Function(MedsysPatient) _then;

/// Create a copy of MedsysPatient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? document = null,Object? name = null,Object? documentType = freezed,Object? recentAppointments = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,recentAppointments: null == recentAppointments ? _self.recentAppointments : recentAppointments // ignore: cast_nullable_to_non_nullable
as List<MedsysAppointment>,
  ));
}

}


/// Adds pattern-matching-related methods to [MedsysPatient].
extension MedsysPatientPatterns on MedsysPatient {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedsysPatient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedsysPatient() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedsysPatient value)  $default,){
final _that = this;
switch (_that) {
case _MedsysPatient():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedsysPatient value)?  $default,){
final _that = this;
switch (_that) {
case _MedsysPatient() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'documento')  String document, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'tipodoc')  String? documentType,  List<MedsysAppointment> recentAppointments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedsysPatient() when $default != null:
return $default(_that.code,_that.document,_that.name,_that.documentType,_that.recentAppointments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'documento')  String document, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'tipodoc')  String? documentType,  List<MedsysAppointment> recentAppointments)  $default,) {final _that = this;
switch (_that) {
case _MedsysPatient():
return $default(_that.code,_that.document,_that.name,_that.documentType,_that.recentAppointments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'documento')  String document, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'tipodoc')  String? documentType,  List<MedsysAppointment> recentAppointments)?  $default,) {final _that = this;
switch (_that) {
case _MedsysPatient() when $default != null:
return $default(_that.code,_that.document,_that.name,_that.documentType,_that.recentAppointments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedsysPatient extends MedsysPatient {
  const _MedsysPatient({@JsonKey(name: 'codigo') required this.code, @JsonKey(name: 'documento') required this.document, @JsonKey(name: 'nombre') required this.name, @JsonKey(name: 'tipodoc') this.documentType, final  List<MedsysAppointment> recentAppointments = const []}): _recentAppointments = recentAppointments,super._();
  factory _MedsysPatient.fromJson(Map<String, dynamic> json) => _$MedsysPatientFromJson(json);

@override@JsonKey(name: 'codigo') final  String code;
@override@JsonKey(name: 'documento') final  String document;
@override@JsonKey(name: 'nombre') final  String name;
@override@JsonKey(name: 'tipodoc') final  String? documentType;
 final  List<MedsysAppointment> _recentAppointments;
@override@JsonKey() List<MedsysAppointment> get recentAppointments {
  if (_recentAppointments is EqualUnmodifiableListView) return _recentAppointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentAppointments);
}


/// Create a copy of MedsysPatient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedsysPatientCopyWith<_MedsysPatient> get copyWith => __$MedsysPatientCopyWithImpl<_MedsysPatient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedsysPatientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedsysPatient&&(identical(other.code, code) || other.code == code)&&(identical(other.document, document) || other.document == document)&&(identical(other.name, name) || other.name == name)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&const DeepCollectionEquality().equals(other._recentAppointments, _recentAppointments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,document,name,documentType,const DeepCollectionEquality().hash(_recentAppointments));

@override
String toString() {
  return 'MedsysPatient(code: $code, document: $document, name: $name, documentType: $documentType, recentAppointments: $recentAppointments)';
}


}

/// @nodoc
abstract mixin class _$MedsysPatientCopyWith<$Res> implements $MedsysPatientCopyWith<$Res> {
  factory _$MedsysPatientCopyWith(_MedsysPatient value, $Res Function(_MedsysPatient) _then) = __$MedsysPatientCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'codigo') String code,@JsonKey(name: 'documento') String document,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'tipodoc') String? documentType, List<MedsysAppointment> recentAppointments
});




}
/// @nodoc
class __$MedsysPatientCopyWithImpl<$Res>
    implements _$MedsysPatientCopyWith<$Res> {
  __$MedsysPatientCopyWithImpl(this._self, this._then);

  final _MedsysPatient _self;
  final $Res Function(_MedsysPatient) _then;

/// Create a copy of MedsysPatient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? document = null,Object? name = null,Object? documentType = freezed,Object? recentAppointments = null,}) {
  return _then(_MedsysPatient(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,recentAppointments: null == recentAppointments ? _self._recentAppointments : recentAppointments // ignore: cast_nullable_to_non_nullable
as List<MedsysAppointment>,
  ));
}


}

// dart format on
