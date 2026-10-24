
import 'package:flutter/material.dart';
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}
class _ProductsScreenState extends State<ProductsScreen> {
  // قائمة المنتجات المخزنة
  final List<Map<String, dynamic>> productsList = [
    {
      'name': 'test',
      'price': 2500.0,
      'stock': 45,
      'barcode': '6132522880045',
      'category': 'بدون فئة',
    },
  ];
  // دالة لإضافة منتج جديد (نافذة منبثقة Dialog)
  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final barcodeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('إضافة منتج جديد', style: TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'اسم المنتج'),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'سعر البيع (DZD)'),
                  ),
                  TextField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'الكمية في المخزون'),
                  ),
                  TextField(
                    controller: barcodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'الباركود'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2)),
                onPressed: () {
                  if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    setState(() {
                      productsList.add({
                        'name': nameController.text,
                        'price': double.tryParse(priceController.text) ?? 0.0,
                        'stock': int.tryParse(stockController.text) ?? 0,
                        'barcode': barcodeController.text,
                        'category': 'بدون فئة',
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('حفظ', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
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
            'المنتجات',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث وفلترة الفئات
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            // زر التصنيف والفئات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: [
                  Chip(
                    label: const Text('الكل', style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color(0xFF1976D2),
                  ),
                  const SizedBox(width: 8),
                  const Chip(
                    label: Text('بدون فئة'),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            // قائمة المنتجات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  final product = productsList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          product['name'][0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ),
                      title: Text(
                        product['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'الباركود: ${product['barcode']} | الكمية: ${product['stock']}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: Text(
                        '${product['price']} DZD',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        // زر الإضافة العائم (إضافة منتج جديد)
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF1976D2),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('إضافة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () => _showAddProductDialog(context),
        ),
      ),
    );
  }
}