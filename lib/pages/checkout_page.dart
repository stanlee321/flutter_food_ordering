import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_food_ordering/constants/colors.dart';
import 'package:flutter_food_ordering/model/cart_model.dart';
import 'package:flutter_food_ordering/model/food_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  var now = DateTime.now();
  get weekDay => DateFormat('EEEE').format(now);
  get day => DateFormat('dd').format(now);
  get month => DateFormat('MMMM').format(now);

  List<Food> displayList = [];

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    displayList.clear();
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              SafeArea(
                child: InkWell(onTap: () => Navigator.of(context).pop(), child: Icon(Icons.arrow_back_ios)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Cart', style: titleStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
                child: Text('$weekDay, ${day}th of $month ', style: titleStyle),
              ),
              FlatButton(
                child: Text('+ Add to order'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ListView.builder(
                itemCount: cart.cartItems.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return buildCartItemList(cart, cart.cartItems[index]);
                },
              ),
              buildPriceInfo(cart),
              checkoutButton(cart, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriceInfo(Cart cart) {
    final titleStyle2 = TextStyle(fontSize: 18, color: Colors.black45);
    double total = 0;
    for (CartModel cart in cart.cartItems) {
      total += cart.food.price * cart.quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: titleStyle2),
        Text('\$ ${total.toStringAsFixed(2)}', style: titleStyle),
      ],
    );
  }

  Widget checkoutButton(cart, context) {
    final titleStyle1 = TextStyle(fontSize: 16);
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 64),
      child: Center(
        child: RaisedButton(
          child: Text('Checkout', style: titleStyle1),
          onPressed: () {},
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
          color: mainColor,
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  Widget buildCartItemList(Cart cart, CartModel cartModel) {
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image.network(cartModel.food.image),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Text(
                    cartModel.food.name,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => cart.removeItem(cartModel),
                      child: Icon(Icons.remove_circle),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('${cartModel.quantity}', style: titleStyle),
                    ),
                    InkWell(
                      onTap: () => cart.increaseItem(cartModel),
                      child: Icon(Icons.add_circle),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 70,
                  child: Text(
                    '\$ ${cartModel.food.price}',
                    style: titleStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                Card(
                  shape: roundedRectangle,
                  color: mainColor,
                  child: InkWell(
                    onTap: () => cart.removeAllInList(cartModel.food),
                    customBorder: roundedRectangle,
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
