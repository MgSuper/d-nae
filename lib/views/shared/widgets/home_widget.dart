import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class HomeWidget extends StatelessWidget {
  final Future<List<Coffee>> _mCoffees;
  final int tabIndex;

  const HomeWidget({
    super.key,
    required Future<List<Coffee>> mCoffees,
    required this.tabIndex,
  }) : _mCoffees = mCoffees;

  @override
  Widget build(BuildContext context) {
    // to set the dynamic list in our provider
    var productNotifier = Provider.of<ProductNotifier>(context);

    return Column(
      children: [
        SizedBox(
          height: 325.h,
          child: FutureBuilder<List<Coffee>>(
            future: _mCoffees,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return ReusableText(
                    text: 'Error ${snapshot.error}', style: null);
              } else {
                final mCoffee = snapshot.data;
                return ListView.builder(
                  itemCount: mCoffee!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final coffee = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        productNotifier.packSizes = coffee.sizes;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              coffee: coffee,
                            ),
                          ),
                        );
                      },
                      child: ProductCart(
                        id: coffee.id,
                        name: coffee.name,
                        price: "\$${coffee.price}",
                        category: coffee.category,
                        image: coffee.imageUrl[0],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                12.w,
                20.h,
                12.w,
                20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: 'Latest Coffee',
                    style: appstyle(
                      24,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCartScreen(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ReusableText(
                          text: 'Show All',
                          style: appstyle(
                            22,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        Icon(AntDesign.caretright, size: 20.h)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 99.h,
          child: FutureBuilder<List<Coffee>>(
            future: _mCoffees,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return ReusableText(
                    text: 'Error ${snapshot.error}', style: null);
              } else {
                final mCoffee = snapshot.data;
                return ListView.builder(
                  itemCount: mCoffee!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final coffee = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: NewCoffees(
                        onTap: () {
                          productNotifier.packSizes = coffee.sizes;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                coffee: coffee,
                              ),
                            ),
                          );
                        },
                        imageUrl: coffee.imageUrl[1],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
