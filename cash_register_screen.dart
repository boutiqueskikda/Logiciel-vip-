
import 'package:flutter/material.dart';
class CashRegisterScreen extends StatefulWidget {
  const CashRegisterScreen({Key? key}) : super(key: key);
  @override
  _CashRegisterScreenState createState() => _CashRegisterScreenState();
}
class _CashRegisterScreenState extends State<CashRegisterScreen> {
  bool isDrawerOpen = false;
  double openingBalance = 0;
  final openingController = TextEditingController();
  void _openDrawer() {
    setState(() {
      openingBalance = double.tryParse(openingController.text) ?? 0;
      isDrawerOpen = true;
    });
  }
  void _closeDrawer() {
    setState(() {
      isDrawerOpen = false;
      openingController.clear();
    });
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
          title: const Text('الصندوق', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.history, color: Colors.blue),
              label: const Text('سجل الصندوق', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: !isDrawerOpen
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.point_of_sale, size: 64, color: Color(0xFF1976D2)),
                        const SizedBox(height: 12),
                        const Text('لا يوجد صندوق مفتوح', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextField(
                          controller: openingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'الرصيد الافتتاحي',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: const Color(0xFFF0F2F5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1976D2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: _openDrawer,
                            child: const Text('فتح الصندوق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الصندوق مفتوح', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('الرصيد الافتتاحي:'),
                              Text('$openingBalance DZD', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('مبيعات نقدية:'),
                              const Text('0 DZD', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('المتوقع في الصندوق:'),
                              Text('$openingBalance DZD', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1976D2))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _closeDrawer,
                        child: const Text('إغلاق الصندوق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}