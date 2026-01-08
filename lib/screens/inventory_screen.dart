import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with TickerProviderStateMixin {
  AnimationController? _explosionController;
  bool _showExplosion = false;

  @override
  void dispose() {
    _explosionController?.dispose();
    super.dispose();
  }

  void _showExplosionEffect() {
    setState(() {
      _showExplosion = true;
    });

    _explosionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _explosionController!.forward().then((_) {
      if (mounted) {
        setState(() {
          _showExplosion = false;
        });
      }
    });
  }

  void _useItem(BuildContext context, String productId, String category) {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    if (category == '특별') {
      // 폭탄 사용
      gameProvider.useBomb(productId);
      _showExplosionEffect();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('💥 폭탄이 터졌습니다! 💥'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFF6B9D),
        ),
      );
    } else if (category == '전자제품') {
      // 전자제품은 사용 불가
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('전자제품은 사용할 수 없습니다!'),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF636E72),
        ),
      );
    } else {
      // 음식 사용 (HP 회복)
      final oldHp = gameProvider.hp;
      gameProvider.useFood(productId);
      final newHp = gameProvider.hp;
      final healAmount = newHp - oldHp;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('HP가 ${healAmount.toStringAsFixed(0)} 회복되었습니다! ❤️'),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFFB8E6D5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final inventoryItems = gameProvider.inventory.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3436)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '배낭',
          style: TextStyle(
            color: Color(0xFF2D3436),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // HP 바
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'HP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                        Text(
                          '${gameProvider.hp.toStringAsFixed(0)} / ${gameProvider.maxHp.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: gameProvider.hp / gameProvider.maxHp,
                        minHeight: 20,
                        backgroundColor: const Color(0xFFDFE6E9),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          gameProvider.hp > 50
                              ? const Color(0xFFB8E6D5)
                              : gameProvider.hp > 20
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              // 배낭 아이템 목록
              Expanded(
                child: inventoryItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '🎒',
                              style: TextStyle(fontSize: 80),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              '배낭이 비어있어요',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF636E72),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '구매한 상품이 여기에 담겨요!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFB2BEC3),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: inventoryItems.length,
                        itemBuilder: (context, index) {
                          final item = inventoryItems[index];
                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFFDFE6E9)),
                            ),
                            child: InkWell(
                              onTap: () => _useItem(context, item.product.id, item.product.category),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Text(
                                          item.product.emoji,
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                        if (item.quantity > 1)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF6B9D),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 24,
                                                minHeight: 24,
                                              ),
                                              child: Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D3436),
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: item.product.category == '특별'
                                            ? const Color(0xFFFF6B9D)
                                            : item.product.category == '전자제품'
                                                ? const Color(0xFF6C5CE7)
                                                : const Color(0xFFB8E6D5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.product.category == '특별'
                                            ? '사용'
                                            : item.product.category == '전자제품'
                                                ? '보관'
                                                : '먹기',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          
          // 폭발 효과
          if (_showExplosion)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _explosionController!,
                builder: (context, child) {
                  return Container(
                    color: Colors.black.withValues(alpha: 0.8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: Tween<double>(begin: 0.0, end: 3.0).animate(
                              CurvedAnimation(
                                parent: _explosionController!,
                                curve: Curves.elasticOut,
                              ),
                            ),
                            child: const Text(
                              '💥',
                              style: TextStyle(fontSize: 100),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeTransition(
                            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _explosionController!,
                                curve: const Interval(0.3, 0.7),
                              ),
                            ),
                            child: const Text(
                              '마트가 폭발했습니다!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
