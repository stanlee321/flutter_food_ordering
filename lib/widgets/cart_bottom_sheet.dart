import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/constants/colors.dart';
import 'package:flutter_food_ordering/model/cart_model.dart';
import 'package:flutter_food_ordering/model/food_model.dart';
import 'package:flutter_food_ordering/pages/checkout_page.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  final titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  final titleStyle1 = TextStyle(fontSize: 16);
  final titleStyle2 = TextStyle(fontSize: 18, color: Colors.black45);
  final titleStyle4 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    // return DraggableScrollableSheet(
    //   initialChildSize: 1,
    //   maxChildSize: 1,
    //   minChildSize: 0.5,
    //   builder: (context, scrollController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              width: 90,
              height: 8,
              decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.black26),
            ),
          ),
          buildTitle(cart),
          Divider(),
          if (cart.cartItems.length <= 0) noItemWidget() else buildItemsList(cart),
          Divider(),
          buildPriceInfo(cart),
          SizedBox(height: 8),
          addToCardButton(cart, context),
        ],
      ),
    );
    //});
  }

  Widget buildTitle(cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Your Order',
          style: titleStyle,
        ),
        IconButton(icon: Icon(Icons.delete), onPressed: cart.clearCart)
      ],
    );
  }

  Widget buildItemsList(Cart cart) {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.cartItems.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(cart.cartItems[index].food.image)),
              title: Text('${cart.cartItems[index].food.name}', style: titleStyle4),
              subtitle: Text('\$ ${cart.cartItems[index].food.price}'),
              trailing: Text('x ${cart.cartItems[index].quantity}'),
            ),
          );
        },
      ),
    );
  }

  Widget noItemWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('No items in cart!!', style: titleStyle2),
            SizedBox(height: 16),
            Icon(Icons.remove_shopping_cart, size: 64),
          ],
        ),
      ),
    );
  }

  Widget buildPriceInfo(Cart cart) {
    double total = 0;
    for (CartModel cartModel in cart.cartItems) {
      total += cartModel.food.price * cartModel.quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: titleStyle2),
        Text('\$ ${total.toStringAsFixed(2)}', style: titleStyle),
      ],
    );
  }

  Widget addToCardButton(cart, context) {
    return Center(
      child: RaisedButton(
        child: Text('Add to Cart', style: titleStyle1),
        onPressed: cart.cartItems.length == 0
            ? null
            : () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage()));
              },
        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
        color: mainColor,
        shape: StadiumBorder(),
      ),
    );
  }
}
