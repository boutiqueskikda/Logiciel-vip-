
import 'package:flutter/material.dart';
class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);
  @override
  _PosScreenState createState() => _PosScreenState();
}
class _PosScreenState extends State<PosScreen> {
  // قائمة المنتجات التجريبية (كمثال مطابق للصور)
  final List<Map<String, dynamic>> products = [
    {'name': 'test', 'price': 2500.0, 'stock': 45, 'category': 'الكل'},
    {'name': 'Coca-Cola 1L', 'price': 120.0, 'stock': 48, 'category': 'مشروبات'},
    {'name': 'Lait Camel 1L', 'price': 90.0, 'stock': 50, 'category': 'ألبان'},
  ];
  String selectedCategory = 'الكل';
  final List<Map<String, dynamic>> cart = [];
  // إضافة منتج إلى السلة
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      int index = cart.indexWhere((item) => item['name'] == product['name']);
      if (index >= 0) {
        cart[index]['qty']++;
      } else {
        cart.add({
          'name': product['name'],
          'price': product['price'],
          'qty': 1,
        });
      }
    });
  }
  // حساب المجموع الكلي للسلة
  double get cartTotal {
    double total = 0;
    for (var item in cart) {
      total += (item['price'] * item['qty']);
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'البيع',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث والباركود
            Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ابحث عن منتج بالاسم أو الباركود...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFF0F2F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                      onPressed: () {
                        // فتح ماسح الباركود
                      },
                    ),
                  ),
                ],
              ),
            ),
            // فئات المنتجات (الكل، المنتجات، الخدمات)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  buildCategoryChip('الكل'),
                  buildCategoryChip('المنتجات'),
                  buildCategoryChip('الخدمات'),
                ],
              ),
            ),
            // شبكة المنتجات المعروضة للبيع
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () => addToCart(product),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  product['name'][0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${product['stock']} قطعه',
                                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${product['price']} DZD',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // شريط السلة السفلي
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF212529),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        cart.isEmpty ? 'السلة فارغة' : '${cart.length} منتجات',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: cart.isEmpty
                        ? null
                        : () {
                            // الانتقال لشاشة الدفع وتأكيد الفاتورة
                          },
                    child: Text(
                      '${cartTotal.toStringAsFixed(0)} DZD - السلة',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // عنصر الفئة (Chip)
  Widget buildCategoryChip(String title) {
    bool isSelected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        selectedColor: const Color(0xFF1976D2),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = title;
          });
        },
      ),
    );
  }
}