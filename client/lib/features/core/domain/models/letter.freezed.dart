// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Letter _$LetterFromJson(Map<String, dynamic> json) {
  return _Letter.fromJson(json);
}

/// @nodoc
mixin _$Letter {
  String get id => throw _privateConstructorUsedError;
  String get letter => throw _privateConstructorUsedError;
  @ScoreMultiplierConverter()
  ScoreMultiplier get scoreMultiplier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LetterCopyWith<Letter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterCopyWith<$Res> {
  factory $LetterCopyWith(Letter value, $Res Function(Letter) then) =
      _$LetterCopyWithImpl<$Res, Letter>;
  @useResult
  $Res call(
      {String id,
      String letter,
      @ScoreMultiplierConverter() ScoreMultiplier scoreMultiplier});
}

/// @nodoc
class _$LetterCopyWithImpl<$Res, $Val extends Letter>
    implements $LetterCopyWith<$Res> {
  _$LetterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? letter = null,
    Object? scoreMultiplier = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      letter: null == letter
          ? _value.letter
          : letter // ignore: cast_nullable_to_non_nullable
              as String,
      scoreMultiplier: null == scoreMultiplier
          ? _value.scoreMultiplier
          : scoreMultiplier // ignore: cast_nullable_to_non_nullable
              as ScoreMultiplier,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LetterImplCopyWith<$Res> implements $LetterCopyWith<$Res> {
  factory _$$LetterImplCopyWith(
          _$LetterImpl value, $Res Function(_$LetterImpl) then) =
      __$$LetterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String letter,
      @ScoreMultiplierConverter() ScoreMultiplier scoreMultiplier});
}

/// @nodoc
class __$$LetterImplCopyWithImpl<$Res>
    extends _$LetterCopyWithImpl<$Res, _$LetterImpl>
    implements _$$LetterImplCopyWith<$Res> {
  __$$LetterImplCopyWithImpl(
      _$LetterImpl _value, $Res Function(_$LetterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? letter = null,
    Object? scoreMultiplier = null,
  }) {
    return _then(_$LetterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      letter: null == letter
          ? _value.letter
          : letter // ignore: cast_nullable_to_non_nullable
              as String,
      scoreMultiplier: null == scoreMultiplier
          ? _value.scoreMultiplier
          : scoreMultiplier // ignore: cast_nullable_to_non_nullable
              as ScoreMultiplier,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LetterImpl extends _Letter {
  _$LetterImpl(
      {required this.id,
      required this.letter,
      @ScoreMultiplierConverter() this.scoreMultiplier = ScoreMultiplier.none})
      : super._();

  factory _$LetterImpl.fromJson(Map<String, dynamic> json) =>
      _$$LetterImplFromJson(json);

  @override
  final String id;
  @override
  final String letter;
  @override
  @JsonKey()
  @ScoreMultiplierConverter()
  final ScoreMultiplier scoreMultiplier;

  @override
  String toString() {
    return 'Letter(id: $id, letter: $letter, scoreMultiplier: $scoreMultiplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.letter, letter) || other.letter == letter) &&
            (identical(other.scoreMultiplier, scoreMultiplier) ||
                other.scoreMultiplier == scoreMultiplier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, letter, scoreMultiplier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      __$$LetterImplCopyWithImpl<_$LetterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LetterImplToJson(
      this,
    );
  }
}

abstract class _Letter extends Letter {
  factory _Letter(
          {required final String id,
          required final String letter,
          @ScoreMultiplierConverter() final ScoreMultiplier scoreMultiplier}) =
      _$LetterImpl;
  _Letter._() : super._();

  factory _Letter.fromJson(Map<String, dynamic> json) = _$LetterImpl.fromJson;

  @override
  String get id;
  @override
  String get letter;
  @override
  @ScoreMultiplierConverter()
  ScoreMultiplier get scoreMultiplier;
  @override
  @JsonKey(ignore: true)
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
