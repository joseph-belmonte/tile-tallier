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

/// @nodoc
mixin _$Letter {
  String get letter => throw _privateConstructorUsedError;
  ScoreMultiplier get scoreMultiplier => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LetterCopyWith<Letter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterCopyWith<$Res> {
  factory $LetterCopyWith(Letter value, $Res Function(Letter) then) =
      _$LetterCopyWithImpl<$Res, Letter>;
  @useResult
  $Res call({String letter, ScoreMultiplier scoreMultiplier});
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
    Object? letter = null,
    Object? scoreMultiplier = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({String letter, ScoreMultiplier scoreMultiplier});
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
    Object? letter = null,
    Object? scoreMultiplier = null,
  }) {
    return _then(_$LetterImpl(
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

class _$LetterImpl extends _Letter {
  const _$LetterImpl(
      {required this.letter, this.scoreMultiplier = ScoreMultiplier.none})
      : super._();

  @override
  final String letter;
  @override
  @JsonKey()
  final ScoreMultiplier scoreMultiplier;

  @override
  String toString() {
    return 'Letter(letter: $letter, scoreMultiplier: $scoreMultiplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterImpl &&
            (identical(other.letter, letter) || other.letter == letter) &&
            (identical(other.scoreMultiplier, scoreMultiplier) ||
                other.scoreMultiplier == scoreMultiplier));
  }

  @override
  int get hashCode => Object.hash(runtimeType, letter, scoreMultiplier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      __$$LetterImplCopyWithImpl<_$LetterImpl>(this, _$identity);
}

abstract class _Letter extends Letter {
  const factory _Letter(
      {required final String letter,
      final ScoreMultiplier scoreMultiplier}) = _$LetterImpl;
  const _Letter._() : super._();

  @override
  String get letter;
  @override
  ScoreMultiplier get scoreMultiplier;
  @override
  @JsonKey(ignore: true)
  _$$LetterImplCopyWith<_$LetterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
