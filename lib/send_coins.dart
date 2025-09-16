import 'package:flutter/material.dart';
import 'package:tiktok_payment/order_summary.dart';

class CustomRechargeModal extends StatefulWidget {
  const CustomRechargeModal({super.key});

  @override
  State<CustomRechargeModal> createState() => _CustomRechargeModalState();
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Result")),
      body: const Center(child: Text("✅ Payment Successful!")),
    );
  }
}

class _CustomRechargeModalState extends State<CustomRechargeModal> {
  String input = "";
  final double coinRate = 0.013;

  void _onNumberTap(String value) {
    setState(() {
      if (value == "←") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int coins = int.tryParse(input) ?? 0;
    double totalPrice = coins * coinRate;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Custom",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Hiển thị số coin đã nhập
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/Coin.png", height: 24),
              const SizedBox(width: 6),
              Text(
                input.isEmpty ? "0" : input,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Keypad
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 2,
            padding: const EdgeInsets.all(8),
            children: [
              ...[
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "000",
                "0",
                "←",
              ].map(
                (key) => GestureDetector(
                  onTap: () => _onNumberTap(key),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Tổng tiền
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Total: \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Nút Recharge
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
              onPressed: coins > 0
                  ? () {
                      // đóng CustomRechargeModal trước
                      Navigator.pop(context);
                      // sau đó show OrderSummaryDialog
                      showDialog(
                        context: context,
                        builder: (context) =>
                            OrderSummaryDialog(coins: coins, price: totalPrice),
                      );
                    }
                  : null,
              child: const Text(
                "Recharge",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
