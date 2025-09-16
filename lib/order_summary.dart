import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktok_payment/confirm_payment.dart';

class OrderSummaryDialog extends StatefulWidget {
  final int coins;
  final double price;

  const OrderSummaryDialog({
    super.key,
    required this.coins,
    required this.price,
  });

  @override
  State<OrderSummaryDialog> createState() => _OrderSummaryDialogState();
}

class _OrderSummaryDialogState extends State<OrderSummaryDialog> {
  bool autoChecked = false;
  bool autoCheckedRadio = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    "Order summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // đóng dialog
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Nội dung
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Coins + Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/coin.png", height: 24),
                        const SizedBox(width: 6),
                        Text(
                          "${widget.coins} Coins",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${widget.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 8,
                      ), // tạo khoảng cách nhỏ
                      child: Text(
                        "Select payment method",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/visa.svg", height: 40),
                        const SizedBox(width: 8),
                        const Text("**********9951"),
                        const Spacer(),
                        Radio<bool>(
                          value: true,
                          groupValue: autoCheckedRadio,
                          onChanged: (val) {
                            setState(() {
                              autoCheckedRadio = val ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Total
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "\$${widget.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Nút Recharge
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                   Navigator.pop(context); 
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // không cho tắt bằng cách bấm ra ngoài
                    builder: (context) => PaymentProcessingDialog(
                      coins: widget.coins,
                      price: widget.price,
                    ),
                  );
                },
                child: const Text(
                  "Recharge",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
