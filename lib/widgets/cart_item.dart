import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;

class CartItems extends StatelessWidget {
  String id ;
  String productId;
  String title;
  double price;
  int quantity;
  CartItems (this.id,this.productId,this.price,this.quantity ,this.title);
  @override
  Widget build(BuildContext context) {
return Dismissible(key: ValueKey(id),
    background: Container(
      color: Theme.of(context).errorColor,
      child: Icon (Icons.delete,
        color: Colors.white,
        size: 40,
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.symmetric(horizontal: 20,
      vertical: 5
      ),
    ),
  direction:DismissDirection.endToStart ,
  onDismissed: (direction){ Provider.of<Cart>(context).removeItems(productId);},
  child: Card(
    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 4),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(child: Text('\$${price}')),
          ),
        ) ,
        title: Text (title) ,
        subtitle: Text ('Total: \$${(price*quantity)}'),
        trailing:Text ('$quantity x') ,
      ),
    ),
  ),
);
  }
}