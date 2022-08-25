import 'package:flutter/material.dart';
import 'package:flutter_testing/pages/shopping_cart/controller/cart_controller.dart';

class BilPage extends StatelessWidget {
  const BilPage({Key? key, required this.controller}) : super(key: key);
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bil Page'),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = 0;
                            index < controller.bilList.length;
                            index++)
                          ListTile(
                            title: Text(controller.bilList[index].name),
                            leading: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                border: Border.all(color: Colors.blue.shade300),
                              ),
                              child: Center(
                                child: Text('${controller.bilList[index].id + 1}'),
                              ),
                            ),
                            trailing: Container(
                              width: 35,
                              height: 35,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                border: Border.all(color: Colors.blue.shade300),
                              ),
                              child: Center(
                                child: Text(
                                    'x ${controller.bilList[index].quantity}'),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: Text(
                      '\$ ${controller.bilTotalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 36,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
