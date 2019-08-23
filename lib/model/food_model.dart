class Food {
  String name;
  double price;
  double rate;
  int rateCount;
  String image;
  String foodType;
  Food({this.name, this.price, this.image, this.rate, this.rateCount, this.foodType});
}

List<String> foodTypes = [
  'Salad',
  'All',
  'Pizza',
  'Asian',
  'Burger',
  'Dessert',
];

List<Food> foods = [
  Food(
    name: 'Vegetable and Poached Egg',
    price: 13.5,
    rate: 3.0,
    rateCount: 15,
    image: 'https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/53/2014/05/Poached-egg-and-bacon-salad-recipe-920x605.jpg',
    foodType: foodTypes[0],
  ),
  Food(
    name: 'Avocado Salad With Mayonoise Soy Sauce',
    price: 12.99,
    rate: 2,
    rateCount: 25,
    image: 'https://ifoodreal.com/wp-content/uploads/2018/04/FG-avocado-salad.jpg',
    foodType: foodTypes[0],
  ),
  Food(
    name: 'Pancake With Orange Sauce',
    price: 23.67,
    rate: 3,
    rateCount: 67,
    image: 'https://iowagirleats.com/wp-content/uploads/2013/01/OrangePancakes_02_mini.jpg',
    foodType: foodTypes[0],
  ),
  Food(
    name: 'Vegetables Salad',
    price: 7.5,
    rate: 4,
    rateCount: 29,
    image: 'https://iowagirleats.com/wp-content/uploads/2016/06/Marinated-Vegetable-Salad-iowagirleats-03.jpg',
    foodType: foodTypes[0],
  ),
  Food(
    name: 'Vegetable and Poached Egg',
    price: 13.5,
    rate: 1,
    rateCount: 15,
    image: 'https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/53/2014/05/Poached-egg-and-bacon-salad-recipe-920x605.jpg',
    foodType: foodTypes[0],
  ),
];
