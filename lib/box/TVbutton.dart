import 'package:flutter/material.dart';

class CustomCardTV extends StatefulWidget {
  CustomCardTV(
      {Key? key,
      required this.size,
      required this.icon,
      required this.title,
      required this.statusOn,
      required this.statusOff,
      required this.isChecked,
      required this.toggle,
      required this.onLongPress})
      : super(key: key);

  final Size size;
  final Icon icon;
  final String title;
  final String statusOn;
  final String statusOff;
  final VoidCallback onLongPress;
  bool isChecked;
  Function toggle;

  @override
  _CustomCardTVState createState() => _CustomCardTVState();
}

class _CustomCardTVState extends State<CustomCardTV>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _animation = Tween<Alignment>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.easeInBack,
      ),
    );

    if (widget.isChecked) {
      _animationController.value = 1.0;
    } else {
      _animationController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(covariant CustomCardTV oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked) {
      _animationController.animateTo(1.0);
    } else {
      _animationController.animateTo(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: () {
        widget.onLongPress();
      },
      onTap: () {
        setState(() {
          widget.toggle();
          widget.isChecked = !widget.isChecked;
          if (_animationController.isCompleted) {
            _animationController.animateTo(20);
          } else {
            _animationController.animateTo(0);
          }
        });
      },
      child: Container(
        height: 150,
        width: widget.size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.icon,
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF07062e),
                ),
              ),
              Text(
                widget.isChecked ? widget.statusOn : widget.statusOff,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isChecked
                      ? Color(0xFF47f03e)
                      : Colors.grey.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
