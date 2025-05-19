import 'package:flutter/material.dart';

class AnimatedSlogan extends StatefulWidget {
  final List<String> words;
  final Duration animationDuration;
  final TextStyle textStyle;
  final TextStyle specialWordStyle;

  const AnimatedSlogan({
    Key? key,
    required this.words,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.textStyle = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    this.specialWordStyle = const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Colors.lightBlue,
      fontFamily: 'OriginTech',
    ),
  }) : super(key: key);

  @override
  _AnimatedSloganState createState() => _AnimatedSloganState();
}

class _AnimatedSloganState extends State<AnimatedSlogan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();

    _animations = widget.words.map((word) {
      final int index = widget.words.indexOf(word);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / widget.words.length),
            ((index + 1) / widget.words.length),
            curve: Curves.easeInOut,
          ),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.words.map((word) {
        final int index = widget.words.indexOf(word);
        final bool isLastWord = index == widget.words.length - 1;

        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: Transform.translate(
                offset: Offset(0, (1 - _animations[index].value) * 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    word,
                    style:
                        isLastWord ? widget.specialWordStyle : widget.textStyle,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
