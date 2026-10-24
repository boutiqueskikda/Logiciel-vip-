
import 'package:flutter/material.dart';
import 'pos_screen_1.dart';
import 'products_screen.dart';
import 'customers_screen.dart';
import 'cash_register_screen.dart';
import 'cart_checkout_screen.dart';
void main() {
  runApp(const LogicielVipApp());
}
class LogicielVipApp extends StatelessWidget {
  const LogicielVipApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logiciel VIP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'AppFont',
      ),
      home: const MainContainerScreen(),
    );
  }
}
class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({Key? key}) : super(key: key);
  @override
  _MainContainerScreenState createState() => _MainContainerScreenState();
}
class _MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;
  // قائمة الشاشات الرئيسية للتنقل السفلي
  final List<Widget> _screens = [
    const PosScreen(),
    const ProductsScreen(),
    const CustomersScreen(),
    const CashRegisterScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_currentIndex],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('المالك', style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: const Text('حساب محلي • Logiciel VIP'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('V', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                ),
                decoration: BoxDecoration(color: Colors.blue[800]),
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('البيع'),
                onTap: () {
                  setState(() => _currentIndex = 0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2),
                title: const Text('المنتجات'),
                onTap: () {
                  setState(() => _currentIndex = 1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('الزبائن'),
                onTap: () {
                  setState(() => _currentIndex = 2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.point_of_sale),
                title: const Text('الصندوق'),
                onTap: () {
                  setState(() => _currentIndex = 3);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('السلة والدفع'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartCheckoutScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF1976D2),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'البيع'),
            BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'المنتجات'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'الزبائن'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'الصندوق'),
          ],
        ),
      ),
    );
  }
}