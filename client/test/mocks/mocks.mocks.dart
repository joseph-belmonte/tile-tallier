// Mocks generated by Mockito 5.4.4 from annotations
// in tile_tally/test/mocks/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tile_tally/features/auth/data/sources/local_storage/local_storage_service.dart'
    as _i6;
import 'package:tile_tally/features/auth/data/sources/network/api_service.dart'
    as _i3;
import 'package:tile_tally/features/auth/data/sources/network/auth_service.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFlutterSecureStorage_0 extends _i1.SmartFake
    implements _i2.FlutterSecureStorage {
  _FakeFlutterSecureStorage_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthApiService extends _i1.Mock implements _i3.AuthApiService {
  MockAuthApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<Map<String, dynamic>> register(
    String? email,
    String? password,
    String? password2,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            email,
            password,
            password2,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> getUserInfo() => (super.noSuchMethod(
        Invocation.method(
          #getUserInfo,
          [],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<bool> deleteAccount() => (super.noSuchMethod(
        Invocation.method(
          #deleteAccount,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> canPlayGame() => (super.noSuchMethod(
        Invocation.method(
          #canPlayGame,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> logGamePlay() => (super.noSuchMethod(
        Invocation.method(
          #logGamePlay,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i5.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<Map<String, dynamic>?> checkStoredTokens() => (super.noSuchMethod(
        Invocation.method(
          #checkStoredTokens,
          [],
        ),
        returnValue: _i4.Future<Map<String, dynamic>?>.value(),
      ) as _i4.Future<Map<String, dynamic>?>);

  @override
  _i4.Future<Map<String, dynamic>> register(
    String? email,
    String? password,
    String? password2,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            email,
            password,
            password2,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String?> getAccessToken() => (super.noSuchMethod(
        Invocation.method(
          #getAccessToken,
          [],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);

  @override
  bool isTokenExpired(String? token) => (super.noSuchMethod(
        Invocation.method(
          #isTokenExpired,
          [token],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> deleteAccount() => (super.noSuchMethod(
        Invocation.method(
          #deleteAccount,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [LocalStorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalStorageService extends _i1.Mock
    implements _i6.LocalStorageService {
  MockLocalStorageService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FlutterSecureStorage get secureStorage => (super.noSuchMethod(
        Invocation.getter(#secureStorage),
        returnValue: _FakeFlutterSecureStorage_0(
          this,
          Invocation.getter(#secureStorage),
        ),
      ) as _i2.FlutterSecureStorage);

  @override
  _i4.Future<void> deleteAuthTokens() => (super.noSuchMethod(
        Invocation.method(
          #deleteAuthTokens,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String?> getAccessToken() => (super.noSuchMethod(
        Invocation.method(
          #getAccessToken,
          [],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);

  @override
  _i4.Future<String?> getRefreshToken() => (super.noSuchMethod(
        Invocation.method(
          #getRefreshToken,
          [],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);

  @override
  _i4.Future<void> saveAuthTokens({
    String? accessToken,
    String? refreshToken,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveAuthTokens,
          [],
          {
            #accessToken: accessToken,
            #refreshToken: refreshToken,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [FlutterSecureStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterSecureStorage extends _i1.Mock
    implements _i2.FlutterSecureStorage {
  MockFlutterSecureStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> write({
    required String? key,
    required String? value,
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #key: key,
            #value: value,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String?> read({
    required String? key,
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);

  @override
  _i4.Future<bool> containsKey({
    required String? key,
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<void> delete({
    required String? key,
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<Map<String, String>> readAll({
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<Map<String, String>>.value(<String, String>{}),
      ) as _i4.Future<Map<String, String>>);

  @override
  _i4.Future<void> deleteAll({
    _i2.IOSOptions? iOptions = _i2.IOSOptions.defaultOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
