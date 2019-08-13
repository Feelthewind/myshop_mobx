// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Product on _Product, Store {
  final _$idAtom = Atom(name: '_Product.id');

  @override
  String get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$titleAtom = Atom(name: '_Product.title');

  @override
  String get title {
    _$titleAtom.context.enforceReadPolicy(_$titleAtom);
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.conditionallyRunInAction(() {
      super.title = value;
      _$titleAtom.reportChanged();
    }, _$titleAtom, name: '${_$titleAtom.name}_set');
  }

  final _$descriptionAtom = Atom(name: '_Product.description');

  @override
  String get description {
    _$descriptionAtom.context.enforceReadPolicy(_$descriptionAtom);
    _$descriptionAtom.reportObserved();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.context.conditionallyRunInAction(() {
      super.description = value;
      _$descriptionAtom.reportChanged();
    }, _$descriptionAtom, name: '${_$descriptionAtom.name}_set');
  }

  final _$priceAtom = Atom(name: '_Product.price');

  @override
  double get price {
    _$priceAtom.context.enforceReadPolicy(_$priceAtom);
    _$priceAtom.reportObserved();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.context.conditionallyRunInAction(() {
      super.price = value;
      _$priceAtom.reportChanged();
    }, _$priceAtom, name: '${_$priceAtom.name}_set');
  }

  final _$imageUrlAtom = Atom(name: '_Product.imageUrl');

  @override
  String get imageUrl {
    _$imageUrlAtom.context.enforceReadPolicy(_$imageUrlAtom);
    _$imageUrlAtom.reportObserved();
    return super.imageUrl;
  }

  @override
  set imageUrl(String value) {
    _$imageUrlAtom.context.conditionallyRunInAction(() {
      super.imageUrl = value;
      _$imageUrlAtom.reportChanged();
    }, _$imageUrlAtom, name: '${_$imageUrlAtom.name}_set');
  }

  final _$isFavoriteAtom = Atom(name: '_Product.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.context.enforceReadPolicy(_$isFavoriteAtom);
    _$isFavoriteAtom.reportObserved();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.context.conditionallyRunInAction(() {
      super.isFavorite = value;
      _$isFavoriteAtom.reportChanged();
    }, _$isFavoriteAtom, name: '${_$isFavoriteAtom.name}_set');
  }

  final _$toggleFavoriteStatusAsyncAction = AsyncAction('toggleFavoriteStatus');

  @override
  Future<void> toggleFavoriteStatus() {
    return _$toggleFavoriteStatusAsyncAction
        .run(() => super.toggleFavoriteStatus());
  }
}
