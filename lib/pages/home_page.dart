import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_bloc/app/bloc/product/product_bloc.dart';
import 'package:prueba_bloc/app/models/product_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() { 
    BlocProvider.of<ProductBloc>(context).add(GetProducts());

    super.initState();
  }
  

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductBloc, ProductState>( 
      builder: ( _ , state) => Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: ( _ , state) {
          
          if ( state.products != null ) {
            return _CardsWidget( state.products);
          } else {
            return Center(
              child: Text('No hay productos'),
            );
          }

        },
      ),

     floatingActionButton: state.cart != null ?  FadeInDown(
        child: FloatingActionButton(
          child: Icon( Icons.shopping_cart ),
          onPressed: () => Navigator.pushNamed(context, 'carts')
        ),
     ) : Container(),
   )
  );
}
class _CardsWidget extends StatelessWidget {

  final List<Product> products;
  const _CardsWidget(this.products,);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: this.products.length,
      itemBuilder: (_, i) => Items(product: this.products[i], leftAligned: (i % 2) == 0 ? true : false),
  );
}

class Items extends StatelessWidget {

  final Product product;
  final bool leftAligned;
  const Items({this.product, this.leftAligned});

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    double containerPadding = 20;
    double containerBorderRadius = 15;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 350,
                decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(2, 5), // changes position of shadow
                      ),
                    ],
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/'+this.product.picture+'.jpg', fit: BoxFit.fill),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
                        child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )
                            ),
                          ),
                          Text('${this.product.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              )),
                        ],
                    ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 15),
                                  children: [
                                    TextSpan(text: "Productos disponibles: "),
                                    TextSpan(
                                      text: '${this.product.sku}',
                                      style: TextStyle(fontWeight: FontWeight.w700)
                                    )
                                  ]),
                              ),
                          ),
                          InkWell(
                            onTap: (){
                              if(this.product.quantity == this.product.sku) return;
                              final Product product = this.product.copyWith(
                                quantity: this.product.quantity + 1
                              );
                              productBloc.add(AddToCar(product));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text(
                                  'Agregar al carro'
                                )
                              ],
                            ),
                          )
                        ]
                      ),
                    ),
                    SizedBox(height: containerPadding),
                    ] 
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
