// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/models/cart/add_to_cart.dart';
import 'package:deenae/services/cart_helper.dart';
import 'package:deenae/views/screens/auth/login_screen.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class ProductScreen extends StatefulWidget {
  final Coffee coffee;
  const ProductScreen({
    Key? key,
    required this.coffee,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var favProvider = Provider.of<FavouritesProvider>(context, listen: true);
    // var productProvider = Provider.of<ProductNotifier>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    // productProvider.getCof(widget.coffee.category, widget.coffee.id);
    var authNotifier = Provider.of<LoginProvider>(context);
    favProvider.getFav();
    return Scaffold(
      body: Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                pinned: true,
                snap: false,
                floating: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height,
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // clear the list in our provider, otherwise it will keep adding more data to list
                          productNotifier.packSizes.clear();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (authNotifier.loggedIn) {
                            if (favProvider.ids.contains(widget.coffee.id)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FavouritesScreen(),
                                ),
                              );
                            } else {
                              favProvider.createFav({
                                'id': widget.coffee.id,
                                'name': widget.coffee.name,
                                'price': widget.coffee.price,
                                'category': widget.coffee.category,
                                'imageUrl': widget.coffee.imageUrl[0]
                              });
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
                        },
                        child: favProvider.ids.contains(widget.coffee.id)
                            ? Icon(
                                AntDesign.heart,
                                color: Colors.black,
                              )
                            : Icon(
                                AntDesign.hearto,
                                color: Colors.black,
                              ),
                      ),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: 401.h,
                        width: 375.w,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.coffee.imageUrl.length,
                            controller: pageController,
                            onPageChanged: (page) {
                              productNotifier.activePage = page;
                            },
                            itemBuilder: (context, int index) {
                              return Stack(
                                children: [
                                  Container(
                                    height: 316.h,
                                    width: 375.w,
                                    color: Colors.grey.shade300,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.coffee.imageUrl[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    top: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List<Widget>.generate(
                                        widget.coffee.imageUrl.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: CircleAvatar(
                                            radius: 5.0,
                                            backgroundColor:
                                                productNotifier.activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Positioned(
                        bottom: 30,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.665,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: widget.coffee.name,
                                    style: appstyle(
                                        40, Colors.black, FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                        text: widget.coffee.category,
                                        style: appstyle(
                                          20.0,
                                          Colors.grey,
                                          FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      RatingBar.builder(
                                          initialRating: 4,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 22,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: ((context, _) =>
                                              const Icon(Icons.star,
                                                  size: 18,
                                                  color: Colors.black)),
                                          onRatingUpdate: (rating) {}),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                        text: '\$${widget.coffee.price}',
                                        style: appstyle(
                                            26, Colors.black, FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          ReusableText(
                                            text: 'Colors',
                                            style: appstyle(
                                              18,
                                              Colors.black,
                                              FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          const CircleAvatar(
                                            radius: 7.0,
                                            backgroundColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 2.0,
                                          ),
                                          const CircleAvatar(
                                            radius: 7.0,
                                            backgroundColor: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          ReusableText(
                                            text: 'Select sizes',
                                            style: appstyle(
                                              20,
                                              Colors.black,
                                              FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          ReusableText(
                                            text: 'View size guide',
                                            style: appstyle(
                                              20,
                                              Colors.grey,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                        child: ListView.builder(
                                            itemCount: productNotifier
                                                .packSizes.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              final sizes = productNotifier
                                                  .packSizes[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: ChoiceChip(
                                                  disabledColor: Colors.white,
                                                  label: ReusableText(
                                                    text: sizes['size'],
                                                    style: appstyle(
                                                        16,
                                                        sizes['isSelected']
                                                            ? Colors.white
                                                            : Colors.black38,
                                                        FontWeight.w500),
                                                  ),
                                                  selected: productNotifier
                                                          .packSizes[index]
                                                      ['isSelected'],
                                                  selectedColor: Colors.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  onSelected: (newState) {
                                                    if (productNotifier.sizes
                                                        .contains(
                                                      sizes['size'],
                                                    )) {
                                                      productNotifier.sizes
                                                          .remove(
                                                              sizes['size']);
                                                    } else {
                                                      productNotifier.sizes
                                                          .add(sizes['size']);
                                                    }
                                                    print(
                                                        productNotifier.sizes);
                                                    productNotifier
                                                        .toggleCheck(index);
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        child: ReusableText(
                                          text: widget.coffee.title,
                                          style: appstyle(26, Colors.black,
                                              FontWeight.w700),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      ReusableText(
                                        text: widget.coffee.description,
                                        style: appstyle(
                                            14, Colors.grey, FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 12.0.h,
                                          ),
                                          child: CheckoutButton(
                                            label: 'Add to cart',
                                            onTap: () async {
                                              if (authNotifier.loggedIn) {
                                                AddToCart model = AddToCart(
                                                    cartItem: widget.coffee.id,
                                                    quantity: 1);
                                                CartHelper().addToCart(model);
                                                // cartProvider.createCart({
                                                //   'id': widget.coffee.id,
                                                //   'name': widget.coffee.name,
                                                //   'category':
                                                //       widget.coffee.category,
                                                //   'sizes':
                                                //       productNotifier.sizes[0],
                                                //   'imageUrl':
                                                //       widget.coffee.imageUrl[0],
                                                //   'price': widget.coffee.price,
                                                //   'qty': 1
                                                // });
                                                // productNotifier.sizes.clear();
                                                // Navigator.pop(context);
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen(),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
