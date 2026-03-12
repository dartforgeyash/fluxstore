import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String title;
  final bool isLoading; // Ab ye parameter se handle hoga
  final VoidCallback onTap;
  final Color? color;

  const LoadingButton({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onTap,
    this.color,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _squeezeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _squeezeAnimation = Tween<double>(
      begin: 320.0,
      end: 50.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(LoadingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Agar isLoading change hua hai, to animation chalao
    if (widget.isLoading) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: GestureDetector(
            onTap: widget.isLoading
                ? null
                : widget.onTap, // Loading ke waqt tap band
            child: Container(
              width: _squeezeAnimation.value,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.color ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: _squeezeAnimation.value > 75
                  ? Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
