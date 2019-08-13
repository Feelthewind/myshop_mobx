// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Products on _Products, Store {
  Computed<ObservableList<Product>> _$favoriteProductsComputed;

  @override
  ObservableList<Product> get favoriteProducts =>
      (_$favoriteProductsComputed ??=
              Computed<ObservableList<Product>>(() => super.favoriteProducts))
          .value;
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;

  final _$productsAtom = Atom(name: '_Products.products');

  @override
  ObservableList<Product> get products {
    _$productsAtom.context.enforceReadPolicy(_$productsAtom);
    _$productsAtom.reportObserved();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.context.conditionallyRunInAction(() {
      super.products = value;
      _$productsAtom.reportChanged();
    }, _$productsAtom, name: '${_$productsAtom.name}_set');
  }

  final _$fetchProductsFutureAtom = Atom(name: '_Products.fetchProductsFuture');

  @override
  ObservableFuture<List<Product>> get fetchProductsFuture {
    _$fetchProductsFutureAtom.context
        .enforceReadPolicy(_$fetchProductsFutureAtom);
    _$fetchProductsFutureAtom.reportObserved();
    return super.fetchProductsFuture;
  }

  @override
  set fetchProductsFuture(ObservableFuture<List<Product>> value) {
    _$fetchProductsFutureAtom.context.conditionallyRunInAction(() {
      super.fetchProductsFuture = value;
      _$fetchProductsFutureAtom.reportChanged();
    }, _$fetchProductsFutureAtom,
        name: '${_$fetchProductsFutureAtom.name}_set');
  }

  final _$fetchProductsAsyncAction = AsyncAction('fetchProducts');

  @override
  Future<void> fetchProducts([bool filterByUser = false]) {
    return _$fetchProductsAsyncAction
        .run(() => super.fetchProducts(filterByUser));
  }

  final _$addProductAsyncAction = AsyncAction('addProduct');

  @override
  Future<void> addProduct(Product product) {
    return _$addProductAsyncAction.run(() => super.addProduct(product));
  }

  final _$updateProductAsyncAction = AsyncAction('updateProduct');

  @override
  Future<void> updateProduct(String id, Product newProduct) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(id, newProduct));
  }
}
