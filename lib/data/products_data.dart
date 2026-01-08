import '../models/product.dart';

final List<Product> productsData = [
  // 과일
  Product(
    id: '1',
    name: '사과',
    price: 3000,
    category: '과일',
    emoji: '🍎',
  ),
  Product(
    id: '2',
    name: '바나나',
    price: 2500,
    category: '과일',
    emoji: '🍌',
  ),
  Product(
    id: '3',
    name: '딸기',
    price: 5000,
    category: '과일',
    emoji: '🍓',
  ),
  Product(
    id: '4',
    name: '수박',
    price: 15000,
    category: '과일',
    emoji: '🍉',
  ),
  Product(
    id: '5',
    name: '오렌지',
    price: 4000,
    category: '과일',
    emoji: '🍊',
  ),
  
  // 채소
  Product(
    id: '6',
    name: '당근',
    price: 2000,
    category: '채소',
    emoji: '🥕',
  ),
  Product(
    id: '7',
    name: '브로콜리',
    price: 3500,
    category: '채소',
    emoji: '🥦',
  ),
  Product(
    id: '8',
    name: '토마토',
    price: 3000,
    category: '채소',
    emoji: '🍅',
  ),
  Product(
    id: '9',
    name: '양파',
    price: 1500,
    category: '채소',
    emoji: '🧅',
  ),
  Product(
    id: '10',
    name: '감자',
    price: 2500,
    category: '채소',
    emoji: '🥔',
  ),
  
  // 유제품
  Product(
    id: '11',
    name: '우유',
    price: 3500,
    category: '유제품',
    emoji: '🥛',
  ),
  Product(
    id: '12',
    name: '치즈',
    price: 4500,
    category: '유제품',
    emoji: '🧀',
  ),
  Product(
    id: '13',
    name: '요구르트',
    price: 2000,
    category: '유제품',
    emoji: '🥤',
  ),
  
  // 빵/간식
  Product(
    id: '14',
    name: '식빵',
    price: 3000,
    category: '빵',
    emoji: '🍞',
  ),
  Product(
    id: '15',
    name: '쿠키',
    price: 2500,
    category: '간식',
    emoji: '🍪',
  ),
  Product(
    id: '16',
    name: '케이크',
    price: 12000,
    category: '빵',
    emoji: '🍰',
  ),
  Product(
    id: '17',
    name: '도넛',
    price: 2000,
    category: '간식',
    emoji: '🍩',
  ),
  Product(
    id: '18',
    name: '아이스크림',
    price: 3500,
    category: '간식',
    emoji: '🍦',
  ),
  
  // 음료
  Product(
    id: '19',
    name: '주스',
    price: 2500,
    category: '음료',
    emoji: '🧃',
  ),
  Product(
    id: '20',
    name: '물',
    price: 1000,
    category: '음료',
    emoji: '💧',
  ),
  
  // 전자제품
  Product(
    id: '21',
    name: 'RTX 5090 Ti',
    price: 10000000,
    category: '전자제품',
    emoji: '🎮',
  ),
];

// 특별 상품 (쿠폰 보유 시에만 구매 가능)
final Product bombProduct = Product(
  id: '999',
  name: '폭탄',
  price: 99999,
  category: '특별',
  emoji: '💣',
);
