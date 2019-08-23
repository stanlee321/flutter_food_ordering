import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/constants/colors.dart';
import 'package:flutter_food_ordering/main.dart';
import 'package:flutter_food_ordering/model/cart_model.dart';
import 'package:flutter_food_ordering/model/food_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  FoodCard(this.food);

  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Food get food => widget.food;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildImage(),
          buildTitle(),
          buildRating(),
          buildPriceInfo(),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Card(
      shape: roundedRectangle,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Image.network(
          food.image,
          fit: BoxFit.fill,
          height: 100,
          loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
            if (progress == null) return child;
            return Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null,
                ));
          },
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(top: 12.0, left: 8, right: 16),
      child: Text(
        food.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 4, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar(
            initialRating: food.rate,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 14,
            unratedColor: Colors.black,
            itemPadding: EdgeInsets.only(right: 4.0),
            ignoreGestures: true,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: mainColor,
            ),
            onRatingUpdate: (rating) {},
          ),
          Text('(${food.rateCount})'),
        ],
      ),
    );
  }

  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '\$ ${food.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Card(
            margin: EdgeInsets.only(right: 8),
            shape: roundedRectangle,
            color: mainColor,
            child: InkWell(
              onTap: addItemToCard,
              customBorder: roundedRectangle,
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  addItemToCard() {
    final snackBar = SnackBar(
      content: Text('${food.name} added to cart'),
      duration: Duration(milliseconds: 100),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    Provider.of<CartModel>(context).addItem(food);
  }
}
