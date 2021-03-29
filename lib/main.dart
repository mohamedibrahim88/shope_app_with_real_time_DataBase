import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shope_app/provider/auth.dart';
import './provider/orders.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_details_screen.dart';
import './provider/provider_product.dart';
import './screens/products_overview_screen.dart';
import './provider/cart.dart';
import './screens/user_product_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Auth()
        ),

        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, ProviderProduct>(
          update: (_, auth, previousProducts) => ProviderProduct(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),

        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),

      ],
      child: Consumer<Auth>(
       builder: (ctx,auth,_)=> MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
         ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            OrderScreen.routeName:(ctx) => OrderScreen(),
            CartScreen.routeName:(ctx)=> CartScreen(),
            UserProductScreen.routeName:(ctx)=>UserProductScreen(),
            EditProductScreen.routeName:(ctx)=>EditProductScreen(),

          },),
      ),
    );
  }
}


