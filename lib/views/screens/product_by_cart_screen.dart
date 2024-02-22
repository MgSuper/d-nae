import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class ProductByCartScreen extends StatefulWidget {
  final int tabIndex;
  const ProductByCartScreen({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  @override
  State<ProductByCartScreen> createState() => _ProductByCartScreenState();
}

class _ProductByCartScreenState extends State<ProductByCartScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  List<String> brand = [
    'assets/images/coffee_bean_bg.png',
    'assets/images/coffee_bean_bg.png',
    'assets/images/coffee_bean_bg.png',
    'assets/images/coffee_bean_bg.png',
    'assets/images/coffee_bean_bg.png',
  ];

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    productProvider.getMogokCoffes();
    productProvider.getShanCoffes();
    productProvider.getKalawCoffes();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.w, top: 45.h),
              height: 325.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee_bean_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.w, 12.h, 16.w, 18.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            FontAwesomeIcons.cross,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesomeIcons.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(text: 'Coffee Beans'),
                      Tab(text: 'Coffee Powders'),
                      Tab(text: 'Other Stuffs'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16.0,
                right: 12.0,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    lastestCoffees(mCoffees: productProvider.mCoffees),
                    lastestCoffees(mCoffees: productProvider.kCoffees),
                    lastestCoffees(mCoffees: productProvider.sCoffees),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.84,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 5.0,
              width: 40.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black38),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const CustomSpacer(),
                  ReusableText(
                    text: 'Filter',
                    style: appstyle(40, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  ReusableText(
                    text: 'Filter',
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(buttonColor: Colors.black, label: 'Mogok'),
                      CategoryBtn(buttonColor: Colors.grey, label: 'Kalaw'),
                      CategoryBtn(buttonColor: Colors.grey, label: 'Shan'),
                    ],
                  ),
                  const CustomSpacer(),
                  ReusableText(
                    text: 'Category',
                    style: appstyle(20.0, Colors.black, FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(buttonColor: Colors.black, label: 'Bean'),
                      CategoryBtn(buttonColor: Colors.grey, label: 'Powder'),
                      CategoryBtn(buttonColor: Colors.grey, label: 'Instant'),
                    ],
                  ),
                  const CustomSpacer(),
                  ReusableText(
                    text: 'Price',
                    style: appstyle(20.0, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: _value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: _value.toString(),
                    secondaryTrackValue: 200.0,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  ReusableText(
                    text: 'Brand',
                    style: appstyle(20.0, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    height: 80,
                    child: ListView.builder(
                      itemCount: brand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Image.asset(
                              brand[index],
                              height: 60.0,
                              width: 80.0,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
