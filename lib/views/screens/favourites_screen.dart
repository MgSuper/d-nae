import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginProvider>(context);
    var favProvider = Provider.of<FavouritesProvider>(context, listen: true);
    favProvider.getAllFavs();
    return !authNotifier.loggedIn
        ? const NonUserScreen()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/coffee_bean_bg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: ReusableText(
                      text: 'Favourites',
                      style: appstyle(
                        42,
                        Colors.white,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: favProvider.allFavs.length,
                      padding: EdgeInsets.only(top: 100.0),
                      itemBuilder: (BuildContext context, int index) {
                        final cof = favProvider.allFavs[index];
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: CachedNetworkImage(
                                          imageUrl: cof['imageUrl'],
                                          width: 70.0,
                                          height: 70.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 12.0, left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: cof['name'],
                                              style: appstyle(
                                                16,
                                                Colors.black,
                                                FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            ReusableText(
                                              text: cof['category'],
                                              style: appstyle(
                                                14,
                                                Colors.grey,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ReusableText(
                                                  text: '${cof['price']}',
                                                  style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        favProvider.deleteFav(cof['key']);
                                        favProvider.ids.removeWhere(
                                            (element) => element == cof['key']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ),
                                        );
                                      },
                                      child:
                                          const Icon(Ionicons.md_heart_dislike),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
