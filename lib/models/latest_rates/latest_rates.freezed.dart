// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LatestRates _$LatestRatesFromJson(Map<String, dynamic> json) {
  return _LatestRates.fromJson(json);
}

/// @nodoc
mixin _$LatestRates {
  String? get disclaimer => throw _privateConstructorUsedError;
  String? get license => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String? get base => throw _privateConstructorUsedError;
  Map<String, double>? get rates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatestRatesCopyWith<LatestRates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestRatesCopyWith<$Res> {
  factory $LatestRatesCopyWith(
          LatestRates value, $Res Function(LatestRates) then) =
      _$LatestRatesCopyWithImpl<$Res, LatestRates>;
  @useResult
  $Res call(
      {String? disclaimer,
      String? license,
      int timestamp,
      String? base,
      Map<String, double>? rates});
}

/// @nodoc
class _$LatestRatesCopyWithImpl<$Res, $Val extends LatestRates>
    implements $LatestRatesCopyWith<$Res> {
  _$LatestRatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disclaimer = freezed,
    Object? license = freezed,
    Object? timestamp = null,
    Object? base = freezed,
    Object? rates = freezed,
  }) {
    return _then(_value.copyWith(
      disclaimer: freezed == disclaimer
          ? _value.disclaimer
          : disclaimer // ignore: cast_nullable_to_non_nullable
              as String?,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      base: freezed == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String?,
      rates: freezed == rates
          ? _value.rates
          : rates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LatestRatesCopyWith<$Res>
    implements $LatestRatesCopyWith<$Res> {
  factory _$$_LatestRatesCopyWith(
          _$_LatestRates value, $Res Function(_$_LatestRates) then) =
      __$$_LatestRatesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? disclaimer,
      String? license,
      int timestamp,
      String? base,
      Map<String, double>? rates});
}

/// @nodoc
class __$$_LatestRatesCopyWithImpl<$Res>
    extends _$LatestRatesCopyWithImpl<$Res, _$_LatestRates>
    implements _$$_LatestRatesCopyWith<$Res> {
  __$$_LatestRatesCopyWithImpl(
      _$_LatestRates _value, $Res Function(_$_LatestRates) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disclaimer = freezed,
    Object? license = freezed,
    Object? timestamp = null,
    Object? base = freezed,
    Object? rates = freezed,
  }) {
    return _then(_$_LatestRates(
      disclaimer: freezed == disclaimer
          ? _value.disclaimer
          : disclaimer // ignore: cast_nullable_to_non_nullable
              as String?,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      base: freezed == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String?,
      rates: freezed == rates
          ? _value._rates
          : rates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LatestRates extends _LatestRates {
  _$_LatestRates(
      {this.disclaimer,
      this.license,
      required this.timestamp,
      this.base,
      final Map<String, double>? rates})
      : _rates = rates,
        super._();

  factory _$_LatestRates.fromJson(Map<String, dynamic> json) =>
      _$$_LatestRatesFromJson(json);

  @override
  final String? disclaimer;
  @override
  final String? license;
  @override
  final int timestamp;
  @override
  final String? base;
  final Map<String, double>? _rates;
  @override
  Map<String, double>? get rates {
    final value = _rates;
    if (value == null) return null;
    if (_rates is EqualUnmodifiableMapView) return _rates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LatestRates(disclaimer: $disclaimer, license: $license, timestamp: $timestamp, base: $base, rates: $rates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LatestRates &&
            (identical(other.disclaimer, disclaimer) ||
                other.disclaimer == disclaimer) &&
            (identical(other.license, license) || other.license == license) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other._rates, _rates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, disclaimer, license, timestamp,
      base, const DeepCollectionEquality().hash(_rates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LatestRatesCopyWith<_$_LatestRates> get copyWith =>
      __$$_LatestRatesCopyWithImpl<_$_LatestRates>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LatestRatesToJson(
      this,
    );
  }
}

abstract class _LatestRates extends LatestRates {
  factory _LatestRates(
      {final String? disclaimer,
      final String? license,
      required final int timestamp,
      final String? base,
      final Map<String, double>? rates}) = _$_LatestRates;
  _LatestRates._() : super._();

  factory _LatestRates.fromJson(Map<String, dynamic> json) =
      _$_LatestRates.fromJson;

  @override
  String? get disclaimer;
  @override
  String? get license;
  @override
  int get timestamp;
  @override
  String? get base;
  @override
  Map<String, double>? get rates;
  @override
  @JsonKey(ignore: true)
  _$$_LatestRatesCopyWith<_$_LatestRates> get copyWith =>
      throw _privateConstructorUsedError;
}
