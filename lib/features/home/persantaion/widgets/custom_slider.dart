// Fixed custom_slider.dart - No changes needed.
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final double initialValue;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    super.key,
    this.min = 0,
    this.max = 1,
    this.divisions = 10,
    this.initialValue = 0.5,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
    this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: widget.activeColor,
        inactiveTrackColor: widget.inactiveColor,
        trackHeight: 6,
        thumbColor: Colors.white,
        overlayColor: widget.activeColor.withOpacity(0.2),
        valueIndicatorColor: widget.activeColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: widget.activeColor,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        value: _currentValue,
        onChanged: (value) {
          setState(() {
            _currentValue = value;
          });
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}
