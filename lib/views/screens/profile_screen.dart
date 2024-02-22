import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/services/auth_helper.dart';
import 'package:deenae/views/screens/auth/login_screen.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';
import 'package:deenae/views/shared/widgets/tiles_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginProvider>(context);
    return authNotifier.loggedIn == false
        ? const NonUserScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: const Icon(
                MaterialCommunityIcons.qrcode_scan,
                size: 18.0,
                color: Colors.black,
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/usa.svg',
                          width: 15.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          height: 15.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        ReusableText(
                          text: ' USA',
                          style: appstyle(
                            16,
                            Colors.black,
                            FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Icon(
                            SimpleLineIcons.settings,
                            color: Colors.black,
                            size: 15.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 70.h,
                    decoration: const BoxDecoration(color: Color(0xFFE2E2E2)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                    width: 40.w,
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/user.jpeg'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  FutureBuilder(
                                      future: AuthHelper().getProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: SizedBox(
                                              height: 35.h,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 50.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: ReusableText(
                                              text: 'Error',
                                              style: appstyle(
                                                18,
                                                Colors.black,
                                                FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        } else {
                                          final userData = snapshot.data;
                                          return SizedBox(
                                            height: 35.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  text:
                                                      userData?.username ?? '',
                                                  style: appstyle(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                                ReusableText(
                                                  text: userData?.email ?? '',
                                                  style: appstyle(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Feather.edit,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 150.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              title: 'My Orders',
                              leading:
                                  MaterialCommunityIcons.truck_fast_outline,
                            ),
                            TilesWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FavouritesScreen(),
                                  ),
                                );
                              },
                              title: 'My Favourites',
                              leading: MaterialCommunityIcons.heart_outline,
                            ),
                            TilesWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(),
                                  ),
                                );
                              },
                              title: 'Cart',
                              leading: Fontisto.shopping_bag_1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 100.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {},
                              title: 'Coupons',
                              leading: MaterialCommunityIcons.tag_outline,
                            ),
                            TilesWidget(
                              onTap: () {},
                              title: 'My Store',
                              leading: MaterialCommunityIcons.shopping_outline,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 150.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {},
                              title: 'Shipping Addresses',
                              leading: SimpleLineIcons.location_pin,
                            ),
                            TilesWidget(
                              onTap: () {},
                              title: 'Settings',
                              leading: AntDesign.setting,
                            ),
                            TilesWidget(
                              onTap: () {
                                authNotifier.logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              title: 'Logout',
                              leading: AntDesign.logout,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
