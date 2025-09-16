import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tiktok_payment/notification_payment.dart';

class PaymentProcessingDialog extends StatefulWidget {
  final int coins;
  final double price;

  const PaymentProcessingDialog({
    super.key,
    required this.coins,
    required this.price,
  });

  @override
  State<PaymentProcessingDialog> createState() =>
      _PaymentProcessingDialogState();
}

class _PaymentProcessingDialogState extends State<PaymentProcessingDialog> {
  late int _remainingSeconds;
  late int _stopAt; // thời điểm sẽ dừng
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 5 * 60; // 5 phút

    // 🎲 Random số giây sẽ dừng (3–5 giây trước khi bắt đầu đếm ngược)
    final randomDelay = Random().nextInt(3) + 3; // 3,4,5 giây
    _stopAt = _remainingSeconds - randomDelay;

    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });

        // Nếu tới thời điểm dừng thì đóng dialog
        if (_remainingSeconds == _stopAt) {
          timer.cancel();
          
          // Đóng dialog hiện tại
          Navigator.pop(context);

          // Mở dialog PaymentCompletedDialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => PaymentCompletedDialog(
              coins: widget.coins,
              price: widget.price,
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Processing your payment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "This could take a few seconds",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: Text(
                _formatTime(_remainingSeconds),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
