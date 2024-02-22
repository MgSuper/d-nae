import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context, listen: true);
    var authNotifier = Provider.of<LoginProvider>(context);
    authNotifier.getPrefs();
    productProvider.getMogokCoffes();
    productProvider.getShanCoffes();
    productProvider.getKalawCoffes();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
              height: 325.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee_bean_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'POL Coffee',
                      style: appstyleWithHt(
                        32,
                        Colors.white,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                    ReusableText(
                      text: 'Mogok Coffee',
                      style: appstyleWithHt(
                        32,
                        Colors.white,
                        FontWeight.bold,
                        1.2,
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
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 203.h,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 12.w),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(tabIndex: 0, mCoffees: productProvider.mCoffees),
                    HomeWidget(tabIndex: 1, mCoffees: productProvider.sCoffees),
                    HomeWidget(tabIndex: 2, mCoffees: productProvider.kCoffees),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
