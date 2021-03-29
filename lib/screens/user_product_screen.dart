import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../provider/provider_product.dart';

class UserProductScreen extends StatelessWidget{
  static const routeName ='/user_product';
Future<void> _onRefreshData (BuildContext context)async{
  await Provider.of<ProviderProduct>(context , listen: false).fetchAndSetProducts();
}
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProviderProduct>(context);
return Scaffold(
  appBar: AppBar(
    title: const Text ('your product'),
    actions:<Widget> [
      IconButton(icon: Icon (Icons.add), onPressed: (){
        Navigator.of(context).pushNamed(EditProductScreen.routeName);
      }),
    ],
  ),
  drawer: AppDrawer(),
  body: RefreshIndicator(
    onRefresh:()=>_onRefreshData(context) ,
    child: Padding(
      padding: EdgeInsets.all(8),
      child:
      ListView.builder(itemCount: productData.items.length,
      itemBuilder: (ctx , i) =>  Column(children: <Widget>[ UserProductItem(productData.items[i].id,productData.items[i].title, productData.items[i].imageUrl
      ),
        Divider(),
      ],
      ),
      ),
    ),
  ),
);
  }
}