import 'package:flutter/material.dart';

class ToggleSwitcher extends StatefulWidget {
  final Function(bool isPlantSelected)? onToggle;

  const ToggleSwitcher({super.key, this.onToggle});

  @override
  State<ToggleSwitcher> createState() => _ToggleSwitcherState();
}

class _ToggleSwitcherState extends State<ToggleSwitcher> {
  bool isPlantSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        children: [
          // ✅ แถบพื้นหลังแบบเลื่อน
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            alignment:
                isPlantSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: (MediaQuery.of(context).size.width - 48) / 2,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF2662B),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),

          // ✅ ข้อความเลือก
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isPlantSelected = true);
                    widget.onToggle?.call(true);
                  },
                  child: Center(
                    child: Text(
                      'การเพาะปลูก',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isPlantSelected
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isPlantSelected = false);
                    widget.onToggle?.call(false);
                  },
                  child: Center(
                    child: Text(
                      'การเผา',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: !isPlantSelected
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
