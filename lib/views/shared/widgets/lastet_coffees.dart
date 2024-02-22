import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class lastestCoffees extends StatelessWidget {
  const lastestCoffees({
    super.key,
    required Future<List<Coffee>> mCoffees,
  }) : _mCoffees = mCoffees;

  final Future<List<Coffee>> _mCoffees;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _mCoffees,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return ReusableText(text: 'Error ${snapshot.error}', style: null);
        } else {
          final mCoffee = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 16.h,
            itemCount: mCoffee!.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3) ? 285.h : 252.h),
            itemBuilder: (context, index) {
              final coffee = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(coffee: coffee),
                    ),
                  );
                },
                child: StaggerTile(
                  imageUrl: coffee.imageUrl[1],
                  name: coffee.name,
                  price: '\$${coffee.price}',
                ),
              );
            },
          );
        }
      },
    );
  }
}
