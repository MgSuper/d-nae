import 'package:deenae/models/cart/get_products.dart';
import 'package:deenae/services/cart_helper.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Product>> _cartList;
  @override
  void initState() {
    // TODO: implement initState
    _cartList = CartHelper().getCart();
  }

  @override
  Widget build(BuildContext context) {
    // var cartProvider = Provider.of<CartProvider>(context, listen: true);
    // cartProvider.getCart();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(AntDesign.close, color: Colors.black),
                ),
                ReusableText(
                  text: 'My Cart',
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Shimmer here
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ReusableText(
                              text: 'Failed to get cart data',
                              style:
                                  appstyle(18, Colors.black, FontWeight.w600),
                            ),
                          );
                        } else {
                          final cartData = snapshot.data;
                          return ListView.builder(
                              itemCount: cartData!.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final data = cartData[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            spreadRadius: 5,
                                            blurRadius: 0.3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: data
                                                          .cartItem.imageUrl[0],
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: -2,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // cartProvider.deleteCart(
                                                        //     data['key']);
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MainScreen(),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 40.0,
                                                        height: 30.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                              12.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          AntDesign.delete,
                                                          size: 20.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0, left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                      text: data.cartItem.name,
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    ReusableText(
                                                      text: data
                                                          .cartItem.category,
                                                      style: appstyle(
                                                          14,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        ReusableText(
                                                          text: data
                                                              .cartItem.price,
                                                          style: appstyle(
                                                            18,
                                                            Colors.black,
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          AntDesign.minussquare,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      // ReusableText(
                                                      //   text: '${data['qty']}',
                                                      //   style: appstyle(
                                                      //     12,
                                                      //     Colors.black,
                                                      //     FontWeight.w600,
                                                      //   ),
                                                      // ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          AntDesign.plussquare,
                                                          color: Colors.black,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: 'Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
