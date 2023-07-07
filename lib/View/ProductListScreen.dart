import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:kvn11mart/Db/DbHelper.dart';
import 'package:kvn11mart/Models/Cart_model.dart';
import 'package:kvn11mart/Provider/Cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:kvn11mart/utils/Routes_name.dart';
import 'package:kvn11mart/utils/TostMessage.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DB_helper? dbHelper = DB_helper();

  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach'
  ];
  List<String> productUnit = [' KG', ' KG', ' KG', ' Dozen', ' KG', ' KG'];
  List<int> productPrice = [100, 20, 30, 130, 110, 150];

  List<String> productImages = [
    'https://static.vecteezy.com/system/resources/thumbnails/003/750/142/small/isolated-mango-fruit-free-vector.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-orange-illustration_53876-2977.jpg',
    'https://img.freepik.com/free-vector/grape-fruit-cartoon-illustration-flat-cartoon-style_138676-2877.jpg',
    'https://t4.ftcdn.net/jpg/03/96/00/39/360_F_396003925_lnlLykRuub52zknNr18PrpmgHLYxtE3U.jpg',
    'https://t3.ftcdn.net/jpg/05/13/46/02/360_F_513460268_DwmRBWiZAWEz7ocdsA7vDNjqwDVBKxgZ.jpg',
    'https://img.freepik.com/premium-vector/whole-peach-vector-illustration_9845-309.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cartProvicer>(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: badges.Badge(
                  badgeContent: Consumer<cartProvicer>(
                    builder: (context, value, child) {
                      return Text(
                        value!.getCartCount().toString(),
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  badgeAnimation: badges.BadgeAnimation.slide(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.CartScreen);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
            ],
            title: const Text('Product List'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: productName.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CircleAvatar(
                                        radius: 50.0,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: productImages[index],
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                            width: 100.0,
                                            height: 100.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 10.0),
                                              Text(
                                                productName[index],
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(
                                                productUnit[index] +
                                                    '  ' +
                                                    r'$' +
                                                    productPrice[index]
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      dbHelper
                                                          ?.insert(Cart(
                                                              id: index,
                                                              productId: index
                                                                  .toString(),
                                                              productName:
                                                                  productName[
                                                                      index],
                                                              initialPrice:
                                                                  productPrice[
                                                                      index],
                                                              productPrice:
                                                                  productPrice[
                                                                      index],
                                                              quantity: 1,
                                                              unitTag:
                                                                  productUnit[
                                                                      index],
                                                              image:
                                                                  productImages[
                                                                      index]))
                                                          .then((value) {
                                                        cart.addTotalPrice(
                                                            double.parse(
                                                                productPrice[
                                                                        index]
                                                                    .toString()));
                                                        cart.addCartCount();

                                                        utils().tostMEssage(
                                                            productName[index].toString()+" Added to Cart");

                                                      }).onError((error,
                                                              stackTrace) {
                                                        utils().tostMEssage(productName[index].toString()+ " Already Added to Cart");

                                                      });
                                                    },
                                                    child:
                                                        const Text('Add to Cart'),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ])
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
