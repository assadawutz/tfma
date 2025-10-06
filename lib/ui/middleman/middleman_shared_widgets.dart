import 'package:flutter/material.dart';

import '../../component/base_scaffold.dart';

class MiddlemanPalette {
  static const background = Color(0xFFEFF4FA);
  static const primary = Color(0xFFE25E30);
  static const success = Color(0xFF4DB749);
  static const info = Color(0xFF3C95B5);
  static const warning = Color(0xFFEF9C2C);
  static const textSecondary = Color(0xFF6E7C8A);
}

class MiddlemanScreenScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final List<Widget>? actionChips;

  const MiddlemanScreenScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.actionChips,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return BaseScaffold(
      backgroundColor: MiddlemanPalette.background,
      headerBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE6713D),
              Color(0xFFE25E30),
              Color(0xFFD94C28),
            ],
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (canPop) ...[
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (actionChips != null && actionChips!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: actionChips!,
            ),
          ],
          const SizedBox(height: 20),
          ...children,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class MiddlemanSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? caption;

  const MiddlemanSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: color,
                  ),
                ),
                if (caption != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    caption!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: MiddlemanPalette.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MiddlemanInsightCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String trend;
  final String description;
  final double? progress;
  final VoidCallback? onTap;

  const MiddlemanInsightCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.trend,
    required this.description,
    this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: color.withAlpha(20),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(icon, color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            trend,
                            style: TextStyle(
                              fontSize: 12,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (progress != null) ...[
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress!.clamp(0.0, 1.0).toDouble(),
                    backgroundColor: const Color(0xFFE0E6EE),
                    color: color,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: MiddlemanPalette.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MiddlemanSection extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;

  const MiddlemanSection({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          if (icon != null)
            Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: MiddlemanPalette.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, size: 18, color: MiddlemanPalette.primary),
            ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class MiddlemanListTile extends StatelessWidget {
  final IconData leadingIcon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const MiddlemanListTile({
    super.key,
    required this.leadingIcon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(leadingIcon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: MiddlemanPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class MiddlemanTag extends StatelessWidget {
  final String label;
  final Color color;

  const MiddlemanTag({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class MiddlemanActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? description;

  const MiddlemanActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MiddlemanPalette.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, color: MiddlemanPalette.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: MiddlemanPalette.textSecondary,
                      height: 1.3,
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

class MiddlemanSearchField extends StatefulWidget {
  const MiddlemanSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  State<MiddlemanSearchField> createState() => _MiddlemanSearchFieldState();
}

class _MiddlemanSearchFieldState extends State<MiddlemanSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleUpdate);
    super.dispose();
  }

  void _handleUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.search, color: MiddlemanPalette.textSecondary),
        suffixIcon: widget.controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                color: MiddlemanPalette.textSecondary,
                onPressed: () {
                  widget.controller.clear();
                  widget.onChanged?.call('');
                },
              ),
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE0E6EE)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE0E6EE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: MiddlemanPalette.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      ),
    );
  }
}
