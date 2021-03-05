library md2_tab_indicator;

import 'package:flutter/widgets.dart';

enum MD2IndicatorSize { tiny, normal, full }

class MD2Indicator extends Decoration {
  final double? indicatorHeight;
  final Color? indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator({
    required this.indicatorHeight,
    required this.indicatorColor,
    required this.indicatorSize,
  });

  @override
  _MD2Painter createBoxPainter([VoidCallback? onChanged]) {
    return _MD2Painter(this, onChanged);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final height = configuration.size?.height ?? 0;
    final width = configuration.size?.width ?? 0;
    final indicatorHeight = decoration.indicatorHeight ?? 3;

    Rect rect;
    switch (decoration.indicatorSize) {
      case MD2IndicatorSize.tiny:
        rect = Offset(offset.dx + width / 2 - 8, height - indicatorHeight) &
            Size(16, indicatorHeight);
        break;
      case MD2IndicatorSize.normal:
        rect = Offset(offset.dx + 6, height - indicatorHeight) &
            Size(width - 12, indicatorHeight);
        break;
      case MD2IndicatorSize.full:
        rect = Offset(offset.dx, height - indicatorHeight) &
            Size(width, indicatorHeight);
        break;
    }

    final paint = Paint();
    paint.color = decoration.indicatorColor ?? const Color(0xff1967d2);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: const Radius.circular(8),
            topLeft: const Radius.circular(8)),
        paint);
  }
}
