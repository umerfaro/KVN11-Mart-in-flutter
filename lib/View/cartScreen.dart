import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kvn11mart/Db/DbHelper.dart';
import 'package:kvn11mart/Models/Cart_model.dart';
import 'package:kvn11mart/Provider/Cart_provider.dart';
import 'package:kvn11mart/utils/TostMessage.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DB_helper? dbHelper = DB_helper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cartProvicer>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Center(
              child: badges.Badge(
                badgeContent: Consumer<cartProvicer>(
                  builder: (context, value, child) {
                    return Text(
                      value!.getCartCount().toString(),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                badgeAnimation: const badges.BadgeAnimation.slide(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
          ],
          title: const Text('My Products'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: cart.getData(),
                  builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 100.0,
                                    backgroundImage:
                                        AssetImage('asserts/empty.png'),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Your Cart is Empty',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Looks like you haven\'t added anything to your cart yet',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                  ),
                                ]),
                          ),
                        );
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                CircleAvatar(
                                                  radius: 50.0,
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data![index].image
                                                          .toString(),
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .productName
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  dbHelper!.delete(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!);

                                                                  utils().tostMEssage( snapshot.data![index].productName.toString() + ' Removed from Cart');

                                                                  cart.removeCartCount();
                                                                  cart.removeTotalPrice(double.parse(snapshot

                                                                      .data![
                                                                          index]
                                                                      .productPrice
                                                                      .toString()));
                                                                },
                                                                child: const Icon(Icons
                                                                    .delete)),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5.0),
                                                        Text(
                                                          snapshot.data![index]
                                                                  .unitTag
                                                                  .toString() +
                                                              '  ' +
                                                              r'$' +
                                                              snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Center(
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {},
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          int quantity = snapshot
                                                                              .data![index]
                                                                              .quantity!;
                                                                          int price = int.parse(snapshot
                                                                              .data![index]
                                                                              .initialPrice
                                                                              .toString());
                                                                          quantity--;
                                                                          int?
                                                                              newPrice =
                                                                              price * quantity;

                                                                          if (quantity >
                                                                              0) {
                                                                            dbHelper!.updateQuantity(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].productId.toString(), productName: snapshot.data![index].productName!, productPrice: newPrice, quantity: quantity, image: snapshot.data![index].image.toString(), unitTag: snapshot.data![index].unitTag.toString(), initialPrice: snapshot.data![index].initialPrice!)).then(
                                                                                (value) {
                                                                              newPrice = 0;
                                                                              quantity = 0;
                                                                              cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                                            }).onError((error,
                                                                                stackTrace) {
                                                                              print(error.toString());
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Icon(
                                                                            Icons.remove)),
                                                                    Text(snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString()),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          int quantity = snapshot
                                                                              .data![index]
                                                                              .quantity!;
                                                                          int price = int.parse(snapshot
                                                                              .data![index]
                                                                              .initialPrice
                                                                              .toString());
                                                                          quantity++;
                                                                          int?
                                                                              newPrice =
                                                                              price * quantity;
                                                                          dbHelper!.updateQuantity(Cart(id: snapshot.data![index].id!, productId: snapshot.data![index].productId.toString(), productName: snapshot.data![index].productName!, productPrice: newPrice, quantity: quantity, image: snapshot.data![index].image.toString(), unitTag: snapshot.data![index].unitTag.toString(), initialPrice: snapshot.data![index].initialPrice!)).then(
                                                                              (value) {
                                                                            newPrice =
                                                                                0;
                                                                            quantity =
                                                                                0;
                                                                            cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                                          }).onError((error,
                                                                              stackTrace) {
                                                                            print(error.toString());
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            Icons.add)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ])
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              Consumer<cartProvicer>(builder: (context, value, child) {
                return Visibility(
                  visible: value.getCartCount() > 0,
                  child: Column(
                    children: [
                      ReuseableWidget(
                          title: 'Sub Total',
                          value:
                              r'$' + value.getTotalPrice().toStringAsFixed(2)),
                      ReuseableWidget(title: 'Tax', value: r'$0.00'),
                      ReuseableWidget(
                          title: 'Total',
                          value: r'$' + value.getTotalPrice().toStringAsFixed(2)),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  final String title, value;
  const ReuseableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10.0),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
