import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_bloc/app/bloc/product/product_bloc.dart';
import 'package:prueba_bloc/app/models/product_model.dart';

class CartsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductBloc, ProductState>( 
    builder: ( _ , state) => Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: state.cart != null ?
        CartBody( state.cart)
      :
        Center(
          child: Text('No hay productos en el carrito'),
        ),
      bottomNavigationBar: BottomBar(state.cart),
    )
  );
}

class CartBody extends StatelessWidget {
  final List<Product> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: <Widget>[
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No More Items Left In The Cart",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return CartListItem(foodItem: foodItems[index]);
      },
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final Product foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return foodItem.quantity != 0 ? Row(
      children: [
        DraggableChildFeedback(foodItem: foodItem),
      ]
    ): Container();
  }
}


class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final Product foodItem;

  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: 0.9,
      child: Material(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              child: ItemContent(foodItem: foodItem),
            );
          },
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final Product foodItem;

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/'+foodItem.picture+'.jpg',
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: foodItem.quantity.toString()
                    ),
                  TextSpan(text: " x "),
                  TextSpan(
                    text: foodItem.name,
                  ),
                ]),
          ),
          Column(
            children: [
              Text(
                "\$${foodItem.quantity * foodItem.price}",
                style:
                  TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ), 
                onPressed: (){
                  final Product cartFinal = foodItem.copyWith(
                  quantity: 0
                );

                productBloc.add(RemoveProduct(cartFinal));
                }
              )
            ] 
          ),
        ],
      ),
    );
  }
}
class BottomBar extends StatelessWidget {
  final List<Product> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Divider(
              height: 1,
              color: Colors.grey[700],
            ),
          ),
          nextButtonBar(),
        ],
      ),
    );
  }

  Container totalAmount(List<Product> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "\$${returnTotalAmount(foodItems)}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<Product> foodItems) {
    double totalAmount = 0.0;

    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Text(
            "Send order",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}