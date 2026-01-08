import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'receipt_screen.dart';

class PaymentApprovalScreen extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final double totalAmount;

  const PaymentApprovalScreen({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.totalAmount,
  });

  @override
  State<PaymentApprovalScreen> createState() => _PaymentApprovalScreenState();
}

class _PaymentApprovalScreenState extends State<PaymentApprovalScreen> {
  bool _isApproving = true;
  bool _isApproved = false;

  @override
  void initState() {
    super.initState();
    _processApproval();
  }

  void _processApproval() async {
    // 승인 처리 시뮬레이션 (2초)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isApproving = false;
      _isApproved = true;
    });

    // 1초 후 영수증 화면으로 이동
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final cart = Provider.of<CartProvider>(context, listen: false);
    final cartItems = cart.items.values.toList();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(
          cardName: widget.cardName,
          cardNumber: widget.cardNumber,
          totalAmount: widget.totalAmount,
          cartItems: cartItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isApproving) ...[
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB8E6D5)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    '결제 승인 중...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.cardName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF636E72),
                    ),
                  ),
                ] else if (_isApproved) ...[
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8E6D5),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 72,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    '승인 완료!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '영수증을 발급하는 중입니다...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF636E72),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
