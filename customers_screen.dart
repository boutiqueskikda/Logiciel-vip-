
import 'package:flutter/material.dart';
class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}
class _CustomersScreenState extends State<CustomersScreen> {
  // قائمة تجريبية للزبائن
  final List<Map<String, dynamic>> customersList = [];
  // دالة لإضافة زبون جديد
  void _showAddCustomerDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('إضافة زبون جديد', style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'اسم الزبون'),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2)),
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    setState(() {
                      customersList.add({
                        'name': nameController.text,
                        'phone': phoneController.text,
                        'debt': 0.0,
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
          title: const Text('الزبائن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث
            Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث بالاسم أو رقم الهاتف...',
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
            // بطاقات الإحصائيات (إجمالي ديون الزبائن وأموالهم)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('إجمالي ديون الزبائن', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          SizedBox(height: 8),
                          Text('0 DZD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.purple.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('أموال الزبائن عندي', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          SizedBox(height: 8),
                          Text('0 DZD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // قائمة الزبائن أو رسالة عدم وجود زبائن
            Expanded(
              child: customersList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.people_outline, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('لا يوجد زبائن بعد', style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('أضف زبوناً أو اربطه بعملية بيع لتظهر مشترياته هنا.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: customersList.length,
                      itemBuilder: (context, index) {
                        final customer = customersList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(customer['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('الهاتف: ${customer['phone']}'),
                            trailing: Text('${customer['debt']} DZD', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        // زر إضافة زبون جديد
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF1976D2),
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text('زبون جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () => _showAddCustomerDialog(context),
        ),
      ),
    );
  }
}