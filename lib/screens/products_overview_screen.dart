import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shope_app/provider/provider_product.dart';
import 'package:shope_app/screens/cart_screen.dart';
import 'package:shope_app/widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';
import '../widgets/product_gridview.dart';

enum FilterOptions{
  Favorites ,
    All
}
class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _showOnlyFavorites = false;
  @override
  void didChangeDependencies() {
if (_isInit)
  {
    setState(() {
      _isLoading=true;
    });
    Provider.of<ProviderProduct>(context).fetchAndSetProducts().then((_){
      setState(() {
        _isLoading=false;
      });
    });
  }
_isInit= false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions:<Widget> [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
             } ,
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
               ],
           ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);

              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}