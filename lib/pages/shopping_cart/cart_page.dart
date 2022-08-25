import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/shopping_cart/bil_page.dart';
import 'package:flutter_testing/pages/shopping_cart/controller/cart_controller.dart';
import 'package:flutter_testing/pages/shopping_cart/model/cart_item.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  final CartController cartController = CartController([]);
  final List<CartItem> cartItems = [
    CartItem(id: 0, name: 'food', price: 20.0),
    CartItem(id: 1, name: 'drink', price: 5.0),
    CartItem(id: 2, name: 'snack', price: 2.3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart Page'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(
                      '${cartItems[index].id}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cartItems[index].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '\$${cartItems[index].price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: InkWell(
                                    onTap: () {
                                      cartController
                                          .removeCart(cartItems[index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cartController.bilList.isEmpty
                                              ? Colors.grey.shade100
                                              : Colors.blue.shade100,
                                          border: Border.all(
                                            color:
                                                cartController.bilList.isEmpty
                                                    ? Colors.grey.shade500
                                                    : Colors.blue.shade500,
                                          )),
                                      child: Center(
                                          child: Icon(
                                        Icons.remove,
                                        color: cartController.bilList.isEmpty
                                            ? Colors.grey.shade500
                                            : Colors.blue.shade500,
                                        size: 16,
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child:
                                        ValueListenableBuilder<List<BilItem>>(
                                            valueListenable: cartController,
                                            builder: (BuildContext context,
                                                List<BilItem> items,
                                                Widget? child) {
                                              return Text(
                                                '${cartController.bilListQuantity(cartItems[index])}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              );
                                            }),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: InkWell(
                                    onTap: () {
                                      print(cartItems[index].name);
                                      cartController.addCart(cartItems[index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          border: Border.all(
                                            color: Colors.blue.shade500,
                                          )),
                                      child: Center(
                                          child: Icon(
                                        Icons.add,
                                        color: Colors.blue.shade500,
                                        size: 16,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<List<BilItem>>(
                      valueListenable: cartController,
                      builder: (BuildContext context, List<BilItem> items, Widget? child) {
                        return Text(
                          'Total ${cartController.totalQuantity} Items',
                          style: const TextStyle(fontSize: 16),
                        );
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BilPage(controller: cartController)));
                    },
                    child: const Text('Go to Bil Pages'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
