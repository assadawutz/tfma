import 'package:flutter/material.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Widget? headerBackground;

  const BaseScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.headerBackground,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  // 🧠 คุณสามารถเพิ่ม controller, state, หรือ function ที่นี่ได้
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // ✅ อย่าลืม dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Stack(
        children: [
          // พื้นหลังรูปด้านบน
          SizedBox(
            height: 150,
            width: double.infinity,
            child: widget.headerBackground ??
                Image.asset(
                  'assets/images/halfcircle.png',
                  fit: BoxFit.cover,
                ),
          ),

          // เนื้อหาในแต่ละหน้า
          Padding(
            padding: const EdgeInsets.only(top: 44, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widget.child,
                ],
              ),
              controller: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
