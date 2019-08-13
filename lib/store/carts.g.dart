// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carts.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Carts on _Carts, Store {
  Computed<int> _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount)).value;
  Computed<double> _$totalAmountComputed;

  @override
  double get totalAmount =>
      (_$totalAmountComputed ??= Computed<double>(() => super.totalAmount))
          .value;

  final _$itemsAtom = Atom(name: '_Carts.items');

  @override
  ObservableMap<String, CartModel> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(ObservableMap<String, CartModel> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }
}
