import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Providers/ReviewsProvider/reviews_provider.dart';
import 'Ui/Design/Screen/design_screen.dart';
import 'Ui/OrderDesign/Screen/order_design_screen.dart';
import 'Ui/PaymentMethods/Screen/payment_methods_screen.dart';
import 'Ui/Order/Screen/order_screen.dart';
import 'Providers/ManageProductsProvider/manage_products_provider.dart';
import 'Providers/OrdersProvider/order_provider.dart';
import 'Ui/AddOrder/Screen/add_order_screen.dart';
import 'Ui/AddProduct/Screen/add_product_screen.dart';
import 'Ui/MyOrders/Screen/my_orders_screen.dart';
import 'Ui/MyProducts/Screen/my_products_screen.dart';
import 'Providers/FavouritesProvider/favourites_provider.dart';
import 'Ui/Favourites/Screen/favourites_screen.dart';
import 'Ui/Seller/Screen/seller_products_screen.dart';
import 'Ui/Store/Screen/store_screen.dart';
import 'Ui/Product/Screen/product_screen.dart';
import 'Providers/AppConfigurationsProvider/app_configurations_provider.dart';
import 'Providers/AuthDataProvider/auth_data_provider.dart';
import 'Ui/Authentication/Login/Screen/login_screen.dart';
import 'Ui/Authentication/Login_Or_Signup/Screen/login_or_signup_screen.dart';
import 'Providers/ProductsProvider/products_provider.dart';
import 'Ui/Authentication/Signup/Screen/signup_screen.dart';
import 'Providers/CartProvider/cart_provider.dart';
import 'Ui/Home/Screen/home_screen.dart';
import 'Ui/Authentication/Phone/Screen/add_phone_number_screen.dart';
import 'Ui/Authentication/Phone/Screen/submit_code_screen.dart';
import 'Ui/Profile/Screen/profile_screen.dart';
import 'Ui/Cart/Screen/cart_screen.dart';
import 'Ui/StartApp/Screen/start_app_screen.dart';
import 'package:provider/provider.dart';
import 'Ui/UpdateProduct/Screen/update_product_screen.dart';
import 'Ui/Search/Screen/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // App database
        ChangeNotifierProvider(
          create: (_) => AppConfigurationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthDataProvider(),
        ),
        //

        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManageProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'الواعد',
        color: Colors.black,
        theme: ThemeData(
          // backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          // We apply this to our appBarTheme because most of our appBar have this style
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          cursorColor: Colors.black,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          // Authentication
          LoginOrSignupScreen.routeName: (ctx) => LoginOrSignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          AddPhoneNumberScreen.routeName: (ctx) => AddPhoneNumberScreen(),
          VerifyCodeScreen.routeName: (ctx) => VerifyCodeScreen(),
          // App
          HomeScreen.routeName: (ctx) => HomeScreen(),
          StartAppScreen.routeName: (ctx) => StartAppScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          ProductScreen.routeName: (ctx) => ProductScreen(),
          StoreScreen.routeName: (ctx) => StoreScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          MyProductsScreen.routeName: (ctx) => MyProductsScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          UpdateProductScreen.routeName: (ctx) => UpdateProductScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          AddOrderScreen.routeName: (ctx) => AddOrderScreen(),
          MyOrdersScreen.routeName: (ctx) => MyOrdersScreen(),
          PaymentMethodsScreen.routeName: (ctx) => PaymentMethodsScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          DesignScreen.routeName: (ctx) => DesignScreen(),
          OrderDesignScreen.routeName: (ctx) => OrderDesignScreen(),
          SellerProductsScreen.routeName: (ctx) => SellerProductsScreen(),
        },
        home: StartAppScreen(
          state: null,
        ),
      ),
    );
  }
}
