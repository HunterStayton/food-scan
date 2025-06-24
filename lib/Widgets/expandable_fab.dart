import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final VoidCallback onManualAdd;
  final VoidCallback onBarcodeScann;
  final VoidCallback onTextScan;

  const ExpandableFab({Key? key, required this.onManualAdd, required this.onBarcodeScann, required this.onTextScan})
    : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _expandAnimation = CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.125, // 45 degrees (0.125 * 2π)
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onOptionTap(VoidCallback callback) {
    print('Option tapped!');
    setState(() {
      _isExpanded = false;
    });
    _animationController.reverse();
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          if (_isExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  print('Backdrop tapped - closing menu');
                  _toggle();
                },
                child: Container(color: Colors.transparent),
              ),
            ),

          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              final opacityValue = _expandAnimation.value.clamp(0.0, 1.0);
              return Transform.translate(
                offset: Offset(0, -80 * _expandAnimation.value),
                child: Transform.scale(
                  scale: _expandAnimation.value.clamp(0.0, 1.0),
                  child: Opacity(
                    opacity: opacityValue,
                    child: _buildOptionButton(
                      icon: Icons.add,
                      label: 'Manual',
                      backgroundColor: Colors.blue,
                      onTap: () => _onOptionTap(widget.onManualAdd),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              final opacityValue = _expandAnimation.value.clamp(0.0, 1.0);
              return Transform.translate(
                offset: Offset(-80 * _expandAnimation.value, -40 * _expandAnimation.value),
                child: Transform.scale(
                  scale: _expandAnimation.value.clamp(0.0, 1.0),
                  child: Opacity(
                    opacity: opacityValue,
                    child: _buildOptionButton(
                      icon: Icons.qr_code_scanner,
                      label: 'Barcode',
                      backgroundColor: Colors.orange,
                      onTap: () => _onOptionTap(widget.onBarcodeScann),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              final opacityValue = _expandAnimation.value.clamp(0.0, 1.0);
              return Transform.translate(
                offset: Offset(80 * _expandAnimation.value, -40 * _expandAnimation.value),
                child: Transform.scale(
                  scale: _expandAnimation.value.clamp(0.0, 1.0),
                  child: Opacity(
                    opacity: opacityValue,
                    child: _buildOptionButton(
                      icon: Icons.camera_alt,
                      label: 'Text Scan',
                      backgroundColor: Colors.purple,
                      onTap: () => _onOptionTap(widget.onTextScan),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value * 2 * 3.14159, //math and such
                child: FloatingActionButton(
                  onPressed: _toggle,
                  backgroundColor: Colors.green.shade600,
                  elevation: 8,
                  child: Icon(_isExpanded ? Icons.close : Icons.add, color: Colors.white, size: 28),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(bottom: 4),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(12)),
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
