import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/product.dart';
import '../screens/product_details_screen.dart';
import '../provider/auth.dart';

class ProductItem extends StatelessWidget {
// //final String title;
 //final String imageUrl;
  //ProductItem(this.id);
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context , listen:  false);
    final authData=Provider.of<Auth>(context,listen: false);
    return ClipRRect(
  borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap:() {
            Navigator.of(context)
                .pushNamed(
              ProductDetailScreen.routeName,
              arguments: productItem.id,);
          },
          child: Image.network(productItem.imageUrl
            ,fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
      icon: Icon(
      product.isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        product.toggleFavoriteStatus(authData.token);
      },
    ),
    ),
          title:FittedBox ( child: Text (
            productItem.title,
            textAlign: TextAlign.center,
          )) ,
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart
            ),
            onPressed: (){
              cart.addToCart(productItem.id, productItem.price, productItem.title);
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
    SnackBar(
    content: Text(
    'Added item to cart!',
    ),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
    label: 'UNDO',
    onPressed: () {
    cart.removeSingleItem(productItem.id);
    },
    ),
    ),
    );
    },
            color: Theme.of(context).accentColor,
          ),
        ),
    ),
    );
  }
}