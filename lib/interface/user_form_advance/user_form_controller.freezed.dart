// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_form_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserFormState {
  UserEntity get user => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  UserFormErrors get errors => throw _privateConstructorUsedError;
  String get serverError => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserFormStateCopyWith<UserFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFormStateCopyWith<$Res> {
  factory $UserFormStateCopyWith(
          UserFormState value, $Res Function(UserFormState) then) =
      _$UserFormStateCopyWithImpl<$Res, UserFormState>;
  @useResult
  $Res call(
      {UserEntity user,
      bool isSaving,
      UserFormErrors errors,
      String serverError,
      bool isNew});

  $UserEntityCopyWith<$Res> get user;
  $UserFormErrorsCopyWith<$Res> get errors;
}

/// @nodoc
class _$UserFormStateCopyWithImpl<$Res, $Val extends UserFormState>
    implements $UserFormStateCopyWith<$Res> {
  _$UserFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isSaving = null,
    Object? errors = null,
    Object? serverError = null,
    Object? isNew = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as UserFormErrors,
      serverError: null == serverError
          ? _value.serverError
          : serverError // ignore: cast_nullable_to_non_nullable
              as String,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserFormErrorsCopyWith<$Res> get errors {
    return $UserFormErrorsCopyWith<$Res>(_value.errors, (value) {
      return _then(_value.copyWith(errors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserFormStateCopyWith<$Res>
    implements $UserFormStateCopyWith<$Res> {
  factory _$$_UserFormStateCopyWith(
          _$_UserFormState value, $Res Function(_$_UserFormState) then) =
      __$$_UserFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserEntity user,
      bool isSaving,
      UserFormErrors errors,
      String serverError,
      bool isNew});

  @override
  $UserEntityCopyWith<$Res> get user;
  @override
  $UserFormErrorsCopyWith<$Res> get errors;
}

/// @nodoc
class __$$_UserFormStateCopyWithImpl<$Res>
    extends _$UserFormStateCopyWithImpl<$Res, _$_UserFormState>
    implements _$$_UserFormStateCopyWith<$Res> {
  __$$_UserFormStateCopyWithImpl(
      _$_UserFormState _value, $Res Function(_$_UserFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isSaving = null,
    Object? errors = null,
    Object? serverError = null,
    Object? isNew = null,
  }) {
    return _then(_$_UserFormState(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as UserFormErrors,
      serverError: null == serverError
          ? _value.serverError
          : serverError // ignore: cast_nullable_to_non_nullable
              as String,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_UserFormState extends _UserFormState {
  const _$_UserFormState(
      {required this.user,
      this.isSaving = false,
      this.errors = const UserFormErrors(),
      this.serverError = '',
      required this.isNew})
      : super._();

  @override
  final UserEntity user;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final UserFormErrors errors;
  @override
  @JsonKey()
  final String serverError;
  @override
  final bool isNew;

  @override
  String toString() {
    return 'UserFormState(user: $user, isSaving: $isSaving, errors: $errors, serverError: $serverError, isNew: $isNew)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserFormState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errors, errors) || other.errors == errors) &&
            (identical(other.serverError, serverError) ||
                other.serverError == serverError) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, user, isSaving, errors, serverError, isNew);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserFormStateCopyWith<_$_UserFormState> get copyWith =>
      __$$_UserFormStateCopyWithImpl<_$_UserFormState>(this, _$identity);
}

abstract class _UserFormState extends UserFormState {
  const factory _UserFormState(
      {required final UserEntity user,
      final bool isSaving,
      final UserFormErrors errors,
      final String serverError,
      required final bool isNew}) = _$_UserFormState;
  const _UserFormState._() : super._();

  @override
  UserEntity get user;
  @override
  bool get isSaving;
  @override
  UserFormErrors get errors;
  @override
  String get serverError;
  @override
  bool get isNew;
  @override
  @JsonKey(ignore: true)
  _$$_UserFormStateCopyWith<_$_UserFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserFormErrors {
  String? get name => throw _privateConstructorUsedError;
  String? get cpf => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get nick => throw _privateConstructorUsedError;
  String? get birth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserFormErrorsCopyWith<UserFormErrors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFormErrorsCopyWith<$Res> {
  factory $UserFormErrorsCopyWith(
          UserFormErrors value, $Res Function(UserFormErrors) then) =
      _$UserFormErrorsCopyWithImpl<$Res, UserFormErrors>;
  @useResult
  $Res call(
      {String? name,
      String? cpf,
      String? email,
      String? phone,
      String? nick,
      String? birth});
}

/// @nodoc
class _$UserFormErrorsCopyWithImpl<$Res, $Val extends UserFormErrors>
    implements $UserFormErrorsCopyWith<$Res> {
  _$UserFormErrorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? cpf = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? nick = freezed,
    Object? birth = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cpf: freezed == cpf
          ? _value.cpf
          : cpf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      nick: freezed == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String?,
      birth: freezed == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserFormErrorsCopyWith<$Res>
    implements $UserFormErrorsCopyWith<$Res> {
  factory _$$_UserFormErrorsCopyWith(
          _$_UserFormErrors value, $Res Function(_$_UserFormErrors) then) =
      __$$_UserFormErrorsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? cpf,
      String? email,
      String? phone,
      String? nick,
      String? birth});
}

/// @nodoc
class __$$_UserFormErrorsCopyWithImpl<$Res>
    extends _$UserFormErrorsCopyWithImpl<$Res, _$_UserFormErrors>
    implements _$$_UserFormErrorsCopyWith<$Res> {
  __$$_UserFormErrorsCopyWithImpl(
      _$_UserFormErrors _value, $Res Function(_$_UserFormErrors) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? cpf = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? nick = freezed,
    Object? birth = freezed,
  }) {
    return _then(_$_UserFormErrors(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      cpf: freezed == cpf
          ? _value.cpf
          : cpf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      nick: freezed == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String?,
      birth: freezed == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserFormErrors extends _UserFormErrors {
  const _$_UserFormErrors(
      {this.name, this.cpf, this.email, this.phone, this.nick, this.birth})
      : super._();

  @override
  final String? name;
  @override
  final String? cpf;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? nick;
  @override
  final String? birth;

  @override
  String toString() {
    return 'UserFormErrors(name: $name, cpf: $cpf, email: $email, phone: $phone, nick: $nick, birth: $birth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserFormErrors &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cpf, cpf) || other.cpf == cpf) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.nick, nick) || other.nick == nick) &&
            (identical(other.birth, birth) || other.birth == birth));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, cpf, email, phone, nick, birth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserFormErrorsCopyWith<_$_UserFormErrors> get copyWith =>
      __$$_UserFormErrorsCopyWithImpl<_$_UserFormErrors>(this, _$identity);
}

abstract class _UserFormErrors extends UserFormErrors {
  const factory _UserFormErrors(
      {final String? name,
      final String? cpf,
      final String? email,
      final String? phone,
      final String? nick,
      final String? birth}) = _$_UserFormErrors;
  const _UserFormErrors._() : super._();

  @override
  String? get name;
  @override
  String? get cpf;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get nick;
  @override
  String? get birth;
  @override
  @JsonKey(ignore: true)
  _$$_UserFormErrorsCopyWith<_$_UserFormErrors> get copyWith =>
      throw _privateConstructorUsedError;
}
