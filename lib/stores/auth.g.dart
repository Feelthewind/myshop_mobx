// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Auth on _Auth, Store {
  Computed<bool> _$isAuthComputed;

  @override
  bool get isAuth =>
      (_$isAuthComputed ??= Computed<bool>(() => super.isAuth)).value;

  final _$tokenAtom = Atom(name: '_Auth.token');

  @override
  String get token {
    _$tokenAtom.context.enforceReadPolicy(_$tokenAtom);
    _$tokenAtom.reportObserved();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.context.conditionallyRunInAction(() {
      super.token = value;
      _$tokenAtom.reportChanged();
    }, _$tokenAtom, name: '${_$tokenAtom.name}_set');
  }

  final _$expiryDateAtom = Atom(name: '_Auth.expiryDate');

  @override
  DateTime get expiryDate {
    _$expiryDateAtom.context.enforceReadPolicy(_$expiryDateAtom);
    _$expiryDateAtom.reportObserved();
    return super.expiryDate;
  }

  @override
  set expiryDate(DateTime value) {
    _$expiryDateAtom.context.conditionallyRunInAction(() {
      super.expiryDate = value;
      _$expiryDateAtom.reportChanged();
    }, _$expiryDateAtom, name: '${_$expiryDateAtom.name}_set');
  }

  final _$userIdAtom = Atom(name: '_Auth.userId');

  @override
  String get userId {
    _$userIdAtom.context.enforceReadPolicy(_$userIdAtom);
    _$userIdAtom.reportObserved();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.context.conditionallyRunInAction(() {
      super.userId = value;
      _$userIdAtom.reportChanged();
    }, _$userIdAtom, name: '${_$userIdAtom.name}_set');
  }

  final _$signupAsyncAction = AsyncAction('signup');

  @override
  Future<void> signup(String email, String password) {
    return _$signupAsyncAction.run(() => super.signup(email, password));
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$tryAutoLoginAsyncAction = AsyncAction('tryAutoLogin');

  @override
  Future<bool> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  final _$_AuthActionController = ActionController(name: '_Auth');

  @override
  void _setStore(Map<String, dynamic> result) {
    final _$actionInfo = _$_AuthActionController.startAction();
    try {
      return super._setStore(result);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }
}
