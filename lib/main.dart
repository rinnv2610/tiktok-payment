import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktok_payment/send_coins.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RechargeScreen(),
    );
  }
}

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final List<Map<String, String>> coinPacks = [
    {"coins": "70", "price": "\$0.91"},
    {"coins": "350", "price": "\$4.55"},
    {"coins": "700", "price": "\$9.10"},
    {"coins": "1,400", "price": "\$18.20"},
    {"coins": "3,500", "price": "\$45.50"},
    {"coins": "7,000", "price": "\$91"},
    {"coins": "17,500", "price": "\$227.50"},
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min, // giữ nội dung gọn ở giữa
          children: [
            SvgPicture.asset(
              "assets/icons/tiktok.svg",
              height: 30, // chỉnh kích thước logo cho cân
              width: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              "TikTok",
              style: TextStyle(
                fontSize: 28, // chữ to hơn mặc định
                fontWeight: FontWeight.bold, // in đậm
                color: Colors.black, // đổi màu chữ nếu muốn
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Get Coins",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View transaction history",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Ô nhập username
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Thông báo giảm giá
              Row(
                children: const [
                  Text(
                    "Recharge: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Save up to 15% compared to in-app purchase",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Grid các gói coin
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: coinPacks.length + 1, // thêm Custom
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;

                  if (index < coinPacks.length) {
                    final pack = coinPacks[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.yellow
                                : Colors.grey.shade400,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? Colors.yellow.shade50
                              : Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/Coin.png",
                                    height: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${pack['coins']} Coins",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pack['price']!,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Custom option
                    {
                      // Custom option
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex =
                                index; // ✅ Gán selectedIndex cho Custom
                          });

                          showDialog(
                            context: context,
                            barrierDismissible: true, // click ra ngoài để tắt
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const CustomRechargeModal(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedIndex == index
                                  ? Colors.yellow
                                  : Colors.grey.shade400,
                              width: selectedIndex == index ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: selectedIndex == index
                                ? Colors.yellow.shade50
                                : Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/Coin.png",
                                      height: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "Custom",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Large amount supported",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),

              const SizedBox(height: 20),

              // Payment method
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Payment method",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  ...[
                    "visa.svg",
                    "mastercard.svg",
                    "paypal.svg",
                    "diners.svg",
                    "discover.svg",
                  ].map(
                    (file) => Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: SizedBox(
                        height: 40,
                        width: 60,
                        child: SvgPicture.asset(
                          "assets/icons/$file",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Recharge button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (selectedIndex != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            selectedIndex! < coinPacks.length
                                ? "Selected: ${coinPacks[selectedIndex!]['coins']} Coins"
                                : "Custom Recharge",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Recharge",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
