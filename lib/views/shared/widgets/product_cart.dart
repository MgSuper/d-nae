import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/views/screens/auth/login_screen.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class ProductCart extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String category;
  final String image;
  const ProductCart({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  }) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    var favProvider = Provider.of<FavouritesProvider>(context, listen: true);
    favProvider.getFav();
    bool selected = true;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 20.w),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Container(
          height: 325.h,
          width: 225.w,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1.0,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 186.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: Consumer<LoginProvider>(
                      builder: (context, authNotifier, child) {
                        return GestureDetector(
                          onTap: () {
                            if (authNotifier.loggedIn) {
                              if (favProvider.ids.contains(widget.id)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FavouritesScreen(),
                                  ),
                                );
                              } else {
                                favProvider.createFav({
                                  'id': widget.id,
                                  'name': widget.name,
                                  'price': widget.price,
                                  'category': widget.category,
                                  'imageUrl': widget.image
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
                          child: favProvider.ids.contains(widget.id)
                              ? const Icon(
                                  AntDesign.heart,
                                  size: 30,
                                )
                              : const Icon(
                                  AntDesign.hearto,
                                  size: 30,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.name,
                      style: appstyleWithHt(
                        30.0,
                        Colors.black,
                        FontWeight.bold,
                        1.1,
                      ),
                    ),
                    ReusableText(
                      text: widget.category,
                      style: appstyleWithHt(
                        18.0,
                        Colors.grey,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: widget.price,
                      style: appstyle(24.0, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Colors',
                          style: appstyle(18.0, Colors.grey, FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        ChoiceChip(
                          label: const ReusableText(
                            text: ' ',
                            style: null,
                          ),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
