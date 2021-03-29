import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider_product.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget{
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
final productData =  Provider.of<ProviderProduct>(context);
    final products = showFav ? productData.favouriteItems : productData.items;
    return GridView.builder(
padding: const EdgeInsets.all(10.0),
itemCount: products.length,
        itemBuilder: (ctx,i)=> ChangeNotifierProvider.value(
            value: products[i],
          child: ProductItem(),
        ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 /2 ,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ) ,
    );
  }

}