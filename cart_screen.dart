import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/model/food_item.dart';
import 'package:foodtek/view/screens/cart_screens/check_out_screen.dart';
import 'package:foodtek/view/widgets/cart_widgets/check_out_widget.dart';
import 'package:provider/provider.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/cart_widgets/cart_item_widget.dart';
import '../../widgets/cart_widgets/empty_widget.dart';
import '../set_location_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CartController>(
                builder: (context, cartController, child) {
                  final cartItems = cartController.cartItems;

                  if (cartItems.isEmpty) {
                    return EmptyWidget(
                      title: AppLocalizations.of(context)!.cart_empty,
                      subTitle: AppLocalizations.of(context)!.cart_empty_prompt,
                    );
                  } else {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final foodItem = cartItems[index];
                              return CartItemWidget(foodItem: foodItem);
                            },
                          ),
                        ),
                        CheckOutWidget(
                          onPressed: () {
                            final locationController =
                                Provider.of<LocationController>(context,
                                    listen: false);

                            if (locationController.hasSavedAddresses()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckOutScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SetLocationScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
