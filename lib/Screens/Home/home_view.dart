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
      onViewModelReady: (viewModel) => viewModel.initScrollListener(),
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
                        viewModel.logout();
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

                          /// **🔹 Show Only 2 Product Cards in a Row**
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// **Product 1**
                                Expanded(
                                  child: ProductCard(
                                    imageUrl:
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQowPW-EI1inBmLR7tKDqFUAPU08StwKkW3Ig&s",
                                    productName: "iPhone 13 Pro",
                                    deviceStorage: "128GB",
                                    deviceCondition: "Like New",
                                    originalPrice: '81,500',
                                    discountedPrice: '41,500',
                                    discountPercentage: 45,
                                    location: "Mumbai",
                                    openForNegotiation: false,
                                    date: "2 days ago",
                                    isLiked: false,
                                    onLikePressed: () {
                                      print("iPhone 13 Pro Liked/Unliked");
                                    },
                                  ),
                                ),

                                const SizedBox(
                                    width: 10), // ✅ Space between products

                                /// **Product 2**
                                Expanded(
                                  child: ProductCard(
                                    imageUrl:
                                        "https://plus.unsplash.com/premium_photo-1683865776032-07bf70b0add1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXJsfGVufDB8fDB8fHww",
                                    productName: "Samsung Galaxy S22",
                                    deviceStorage: "128GB",
                                    deviceCondition: "Like New",
                                    originalPrice: '81,500',
                                    discountedPrice: '41,500',
                                    discountPercentage: 45,
                                    location: "Delhi",
                                    date: "1 week ago",
                                    openForNegotiation: true,
                                    isLiked: true,
                                    onLikePressed: () {
                                      print("Samsung Galaxy S22 Liked/Unliked");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 1500), // Dummy space for scrolling
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
