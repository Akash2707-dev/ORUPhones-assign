import 'package:flutter/material.dart';
import 'package:oruphones_assign/widgets/custom_fab.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:oruphones_assign/widgets/carousel_banner.dart';
import 'package:oruphones_assign/widgets/download_app_widget.dart';
import 'package:oruphones_assign/widgets/drawer.dart';
import 'package:oruphones_assign/widgets/invite_friend_widget.dart';
import 'package:oruphones_assign/widgets/notification_subscription.dart';
import 'package:oruphones_assign/widgets/custom_button.dart';
import 'package:oruphones_assign/widgets/faq_expansion_tile.dart';
import 'package:oruphones_assign/widgets/horizontal_list_widget.dart';
import 'package:oruphones_assign/widgets/product_card.dart';
import 'package:oruphones_assign/widgets/search_bar.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) async {
        await viewModel
            .checkLoginStatus(); // Check login status when the view model is ready
        viewModel.initScrollListener();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leadingWidth: 114,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SizedBox(
                  child: Image.asset(
                    'lib/assets/images/Drawer_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                const Spacer(),
                const Text(
                  "India",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.74, bottom: 3.89, top: 3.89, right: 8.74),
                  child: Image.asset(
                    'lib/assets/images/location.png',
                    height: 20,
                    width: 14.52,
                  ),
                )
              ],
            ),
            actions: [
              // Print the value of isUserLoggedIn to check the login status

              viewModel.isUserLoggedIn
                  ? IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {
                        print("🔔 Notifications Clicked");
                      },
                    )
                  : GestureDetector(
                      onTap: () {
                        // If user is not logged in, navigate to the login screen
                        print("🔴 User is not logged in, navigating to login");
                        viewModel
                            .navigateToLogin(); // Ensure this is the correct navigation method
                      },
                      child: Container(
                        height: 29,
                        width: 66,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6C018),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
            ],
          ),
          drawer: const SizedBox(width: 311, child: AppDrawer()),
          body: Column(
            children: [
              const SearchBarWidget(),
              Container(
                height: 50,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CustomButton(
                          title: "Sell Used Phones",
                          onPressed: () {},
                        ),
                      ),
                      CustomButton(
                        title: "Buy Used Phones",
                        onPressed: () {},
                      ),
                      CustomButton(
                        title: "Compare Prices",
                        onPressed: () {},
                      ),
                      CustomButton(
                        title: "My Profile",
                        onPressed: () {},
                      ),
                      CustomButton(
                        title: "My Listings",
                        onPressed: () {},
                      ),
                      CustomButton(
                        title: "Services",
                        onPressed: () {},
                      ),
                      CustomButtonWithSVG(
                        title: "Register your Store",
                        svgPath: "lib/assets/images/new.png",
                        onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CustomButton(
                          title: "Get the App",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: viewModel.scrollController,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          const CarouselWidget(),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "What's on your mind?",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          HorizontalListWidget(),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10), // ✅ Add horizontal padding
                            child: GestureDetector(
                              onTap: () {
                                print(
                                    "🔹 Top Brands Clicked!"); // ✅ Add your navigation or action here
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // ✅ Ensures spacing between text & icon
                                children: [
                                  /// **"Top Brands" Text**
                                  const Text(
                                    "Top Brands",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  /// **Arrow Icon**
                                  const Icon(
                                    Icons
                                        .arrow_forward_ios, // ✅ Forward arrow icon
                                    size: 18,
                                    color:
                                        Colors.grey, // ✅ Adjust color as needed
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          /// **🔹 Horizontal Scrollable Brand List**
                          SizedBox(
                            height: 80,
                            child: ViewModelBuilder<HomeViewModel>.reactive(
                              viewModelBuilder: () => HomeViewModel(),
                              onViewModelReady: (viewModel) =>
                                  viewModel.fetchBrands(),
                              builder: (context, viewModel, child) {
                                return viewModel.brands.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: viewModel.brands.length,
                                        itemBuilder: (context, index) {
                                          final brand = viewModel.brands[index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                print(
                                                    "Brand selected: ${brand['make']}");
                                              },
                                              child: Container(
                                                height: 64,
                                                width: 64,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color(
                                                      0xFFF2F2F2), // ✅ Background Color #F2F2F2
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    brand[
                                                        'imagePath'], // ✅ Use correct key for image
                                                    height: 40.48,
                                                    width: 40.48,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Icon(Icons.error,
                                                            color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text.rich(
                                TextSpan(
                                  text: "Best Deals ", // ✅ Default black text
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black, // ✅ Default text color
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "in India", // ✅ Dark Blue colored text
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                            0xFF00008B), // ✅ Dark Blue color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /// **Sort Button**
                                CustomActionButton(
                                  icon: Icons.swap_vert,
                                  text: "Sort",
                                  onPressed: () {
                                    print("Sort button clicked");
                                  },
                                ),

                                const SizedBox(width: 10),

                                /// **Filter Button**
                                CustomActionButton(
                                  icon: Icons.tune,
                                  text: "Filter",
                                  onPressed: () {
                                    print("Filter button clicked");
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ViewModelBuilder<HomeViewModel>.reactive(
                              viewModelBuilder: () => HomeViewModel(),
                              onViewModelReady: (viewModel) =>
                                  viewModel.fetchProducts(),
                              builder: (context, viewModel, child) {
                                if (viewModel.isBusy) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (viewModel.products.isEmpty) {
                                  return const Center(
                                      child: Text("No products available."));
                                }

                                List<Widget> productWidgets = [];
                                int adIndex = 0; // Toggle between Ad1 & Ad2
                                int productCounter =
                                    0; // Count products before showing an ad

                                for (int i = 0;
                                    i < viewModel.products.length;
                                    i++) {
                                  bool showAdInstead =
                                      ((productCounter + 1) % 7 == 0);
                                  final product1 = viewModel.products[i];
                                  final product2 =
                                      (i + 1 < viewModel.products.length)
                                          ? viewModel.products[i + 1]
                                          : null;

                                  productWidgets.add(
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// **First Product**
                                          Expanded(
                                            child: ProductCard(
                                              imageUrl:
                                                  product1["imagePath"] ?? "",
                                              productName:
                                                  product1["marketingName"] ??
                                                      "No Name",
                                              deviceStorage:
                                                  product1["deviceStorage"] ??
                                                      "--",
                                              deviceCondition:
                                                  product1["deviceCondition"] ??
                                                      "Unknown",
                                              originalPrice:
                                                  product1["originalPrice"]
                                                          ?.toString() ??
                                                      "0",
                                              discountedPrice:
                                                  product1["discountedPrice"]
                                                          ?.toString() ??
                                                      "0",
                                              discountPercentage:
                                                  product1["discountPercentage"]
                                                          ?.round() ??
                                                      0,
                                              location:
                                                  product1["listingLocation"] ??
                                                      "Unknown",
                                              date: product1["listingDate"] ??
                                                  "N/A",
                                              openForNegotiation: product1[
                                                      "openForNegotiation"] ??
                                                  false,
                                              isLiked:
                                                  product1["isLiked"] ?? false,
                                              verified:
                                                  product1["verified"] ?? false,
                                              onLikePressed: () {
                                                viewModel.toggleLike(
                                                    product1["listingId"],
                                                    product1["isLiked"] ??
                                                        false);
                                              },
                                            ),
                                          ),

                                          const SizedBox(
                                              width:
                                                  10), // ✅ Space between products

                                          /// **Second Product OR Ad**
                                          Expanded(
                                            child: showAdInstead
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // ✅ Border Radius for Ads
                                                    ),
                                                    child: Image.asset(
                                                      (adIndex % 2 == 0)
                                                          ? "lib/assets/images/Ad1.png"
                                                          : "lib/assets/images/Ad2.png",
                                                      height:
                                                          292, // Same as product card
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : (product2 != null
                                                    ? ProductCard(
                                                        imageUrl: product2[
                                                                "imagePath"] ??
                                                            "",
                                                        productName: product2[
                                                                "marketingName"] ??
                                                            "No Name",
                                                        deviceStorage: product2[
                                                                "deviceStorage"] ??
                                                            "--",
                                                        deviceCondition: product2[
                                                                "deviceCondition"] ??
                                                            "Unknown",
                                                        originalPrice: product2[
                                                                    "originalPrice"]
                                                                ?.toString() ??
                                                            "0",
                                                        discountedPrice: product2[
                                                                    "discountedPrice"]
                                                                ?.toString() ??
                                                            "0",
                                                        discountPercentage:
                                                            product2["discountPercentage"]
                                                                    ?.round() ??
                                                                0,
                                                        location: product2[
                                                                "listingLocation"] ??
                                                            "Unknown",
                                                        date: product2[
                                                                "listingDate"] ??
                                                            "N/A",
                                                        openForNegotiation:
                                                            product2[
                                                                    "openForNegotiation"] ??
                                                                false,
                                                        isLiked: product2[
                                                                "isLiked"] ??
                                                            false,
                                                        verified: product2[
                                                                "verified"] ??
                                                            false,
                                                        onLikePressed: () {
                                                          viewModel.toggleLike(
                                                              product2[
                                                                  "listingId"],
                                                              product2[
                                                                      "isLiked"] ??
                                                                  false);
                                                        },
                                                      )
                                                    : const SizedBox()), // ✅ Empty to maintain alignment
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  if (showAdInstead)
                                    adIndex++; // ✅ Alternate Ad1 & Ad2

                                  productCounter++; // ✅ Increment product count

                                  i++; // ✅ Skip next product (already used in the row)
                                }

                                /// **Pagination Trigger When Reaching "Frequently Asked Questions"**
                                productWidgets.add(
                                  Visibility(
                                    visible: !viewModel.isLoadingMore,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            print("🔄 Fetching Next Page...");
                                            viewModel.fetchProducts(
                                                loadMore: true);
                                          },
                                          child: const Text(
                                            "Load More...",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                                return Column(children: productWidgets);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10), // ✅ Add horizontal padding
                      child: GestureDetector(
                        onTap: () {
                          print(
                              "🔹 Frequently Asked Questions Clicked!"); // ✅ Replace with navigation
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // ✅ Ensures spacing between text & icon
                          children: [
                            /// **"Frequently Asked Questions" Text**
                            const Text(
                              "Frequently Asked Questions",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            /// **Arrow Icon**
                            const Icon(
                              Icons.arrow_forward_ios, // ✅ Forward arrow icon
                              size: 18,
                              color: Colors.grey, // ✅ Adjust color as needed
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// **🔹 Add FAQ Expansion Widget**
                    const SizedBox(height: 10), // ✅ Add spacing
                    const FaqExpansionTile(), // ✅ Call the new FAQ widget
                    SizedBox(
                      height: 15,
                    ),
                    const NotificationSubscription(),
                    const DownloadAppWidget(),
                    const InviteFriendWidget(),
                  ],
                ),
              ),
            ],
          ),

          /// **Floating Action Button (FAB)**
          floatingActionButton: CustomFloatingActionButton(
            isVisible: viewModel.isFabVisible,
            onPressed: () {
              print("Sell + button clicked");
            },
          ),
        );
      },
    );
  }
}
