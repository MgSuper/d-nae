import 'package:deenae/views/shared/widgets/custom_field.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(
          hintText: 'Search for product',
          controller: searchController,
          onEditingComplete: () {
            setState(() {});
          },
          prefixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(
              AntDesign.camera,
              color: Colors.black,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              AntDesign.search1,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: searchController.text.isEmpty
          ? Container(
              height: 600.h,
              padding: EdgeInsets.all(20.h),
              margin: EdgeInsets.only(right: 50.w),
              child: Image.asset('assets/images/Pose23.png'),
            )
          : FutureBuilder<List<Coffee>>(
              future: Helper().search(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return ReusableText(
                    text: 'Error retrieving data',
                    style: appstyle(20.0, Colors.black, FontWeight.bold),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return ReusableText(
                    text: 'Product not found',
                    style: appstyle(20.0, Colors.black, FontWeight.bold),
                  );
                } else {
                  final cofs = snapshot.data;
                  return ListView.builder(
                    itemCount: cofs!.length,
                    itemBuilder: (context, index) {
                      final cof = cofs[index];
                      return GestureDetector(
                        onTap: () {
                          productProvider.packSizes = cof.sizes;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(coffee: cof),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: Container(
                              height: 90.h,
                              width: 325,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5.0,
                                    blurRadius: 0.3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12.h),
                                        child: CachedNetworkImage(
                                          imageUrl: cof.imageUrl[0],
                                          height: 70.h,
                                          width: 70.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 12.h, left: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: cof.name,
                                              style: appstyle(
                                                16,
                                                Colors.black,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            ReusableText(
                                              text: cof.category,
                                              style: appstyle(
                                                13,
                                                Colors.grey.shade600,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            ReusableText(
                                              text: 'Ks ${cof.price}',
                                              style: appstyle(
                                                13,
                                                Colors.grey.shade600,
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
