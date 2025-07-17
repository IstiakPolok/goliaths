import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef HeaderLayoutBuilder = Function(Widget title, Widget previous, Widget next);

class LunarFlow extends StatefulWidget {
  final CalendarHeader? header;
  final Color containerColor;
  final Color onContainerColor;
  final Color color;
  final ValueChanged<DateTime>? onDateSelected;

  const LunarFlow({
    super.key,
    this.header,
    this.containerColor = Colors.black,
    this.onContainerColor = Colors.white,
    this.color = Colors.black,
    this.onDateSelected,
  });

  @override
  State<LunarFlow> createState() => _LunarFlowState();
}

class _LunarFlowState extends State<LunarFlow> with SingleTickerProviderStateMixin {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  bool _isNext = true; // Tracks the direction for button animation
  double _dragOffset = 0.0; // Tracks the swipe offset
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  DateTime? _tempMonth; // Tracks the month during swipe

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _tempMonth = _currentMonth;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _dragOffset = _slideAnimation.value * MediaQuery.of(context).size.width;
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _previousMonth() {
    setState(() {
      _isNext = false;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      _tempMonth = _currentMonth;
      _dragOffset = 0.0; // Reset drag offset
    });
    _animateSlide(1.0, 0.0); // Slide from right to left
  }

  void _nextMonth() {
    setState(() {
      _isNext = true;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      _tempMonth = _currentMonth;
      _dragOffset = 0.0; // Reset drag offset
    });
    _animateSlide(-1.0, 0.0); // Slide from left to right
  }

  void _animateSlide(double begin, double end) {
    _slideAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward(from: 0.0);
  }

  void _handleDragStart() {
    setState(() {
      _tempMonth = _currentMonth; // Store the current month before swipe
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta.dx;
      // Update the temporary month based on drag direction
      if (_dragOffset > 0) { // Swiping left to right (should show previous month)
        _tempMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      } else if (_dragOffset < 0) { // Swiping right to left (should show next month)
        _tempMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      }
    });
  }

  void _handleDragEnd(DragEndDetails details, double screenWidth) {
    final threshold = screenWidth * 0.4;
    final currentOffsetFraction = _dragOffset / screenWidth;

    if (_dragOffset.abs() > threshold) {
      // Continue sliding to the target month
      if (_dragOffset < 0) { // Swiped right to left (next month)
        _animateSlide(currentOffsetFraction, -1.0); // Finish sliding to the left
        setState(() {
          _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
          _tempMonth = _currentMonth;
        });
      } else { // Swiped left to right (previous month)
        _animateSlide(currentOffsetFraction, 1.0); // Finish sliding to the right
        setState(() {
          _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
          _tempMonth = _currentMonth;
        });
      }
    } else {
      // Snap back to the current month
      _animateSlide(currentOffsetFraction, 0.0); // Smoothly return to initial position
      setState(() {
        _tempMonth = _currentMonth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: (_) => _handleDragStart(),
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: (details) => _handleDragEnd(details, screenWidth),
      child: Column(
        children: [
          widget.header?.buildHeader(_currentMonth, _previousMonth, _nextMonth) ??
              _DefaultHeader(
                currentMonth: _currentMonth,
                onPrevious: _previousMonth,
                onNext: _nextMonth,
              ),
          Stack(
            children: [
              // Previous month (visible when swiping left to right or during button animation)
              if (_dragOffset > 0 || (!_isNext && _animationController.isAnimating))
                Transform.translate(
                  offset: Offset(
                    _dragOffset > 0
                        ? _dragOffset - screenWidth
                        : _slideAnimation.value * screenWidth,
                    0,
                  ),
                  child: _CalendarGrid(
                    key: ValueKey(DateTime(_currentMonth.year, _currentMonth.month - 1)),
                    currentMonth: DateTime(_currentMonth.year, _currentMonth.month - 1),
                    selectedDate: _selectedDate,
                    containerColor: widget.containerColor,
                    onContainerColor: widget.onContainerColor,
                    color: widget.color,
                    onDateSelected: (date) {},
                  ),
                ),
              // Current month (or the month being swiped to)
              Transform.translate(
                offset: Offset(_dragOffset, 0),
                child: _CalendarGrid(
                  key: ValueKey(_tempMonth),
                  currentMonth: _tempMonth!,
                  selectedDate: _selectedDate,
                  containerColor: widget.containerColor,
                  onContainerColor: widget.onContainerColor,
                  color: widget.color,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                    widget.onDateSelected?.call(date);
                  },
                ),
              ),
              // Next month (visible when swiping right to left or during button animation)
              if (_dragOffset < 0 || (_isNext && _animationController.isAnimating))
                Transform.translate(
                  offset: Offset(
                    _dragOffset < 0
                        ? _dragOffset + screenWidth
                        : _slideAnimation.value * screenWidth,
                    0,
                  ),
                  child: _CalendarGrid(
                    key: ValueKey(DateTime(_currentMonth.year, _currentMonth.month + 1)),
                    currentMonth: DateTime(_currentMonth.year, _currentMonth.month + 1),
                    selectedDate: _selectedDate,
                    containerColor: widget.containerColor,
                    onContainerColor: widget.onContainerColor,
                    color: widget.color,
                    onDateSelected: (date) {},
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarHeader {
  final Widget Function(MonthYear monthYear)? titleBuilder;
  final Widget Function(VoidCallback)? previousButtonBuilder;
  final Widget Function(VoidCallback)? nextButtonBuilder;
  final Widget Function(Widget title, Widget previous, Widget next)? widgetBuilder;

  const CalendarHeader({
    this.titleBuilder,
    this.previousButtonBuilder,
    this.nextButtonBuilder,
    this.widgetBuilder,
  });

  Widget buildHeader(DateTime currentMonth, VoidCallback onPrevious, VoidCallback onNext) {
    Widget previousButton = previousButtonBuilder?.call(onPrevious) ??
        IconButton(icon: const Icon(Icons.arrow_left), onPressed: onPrevious);
    final month = DateFormat('MMMM').format(currentMonth);
    final year = DateFormat('yyyy').format(currentMonth);
    Widget title = titleBuilder?.call(MonthYear(month: month, year: year)) ??
        Text(
          DateFormat('MMMM yyyy').format(currentMonth),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
    Widget nextButton = nextButtonBuilder?.call(onNext) ??
        IconButton(icon: const Icon(Icons.arrow_right), onPressed: onNext);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: widgetBuilder?.call(title, previousButton, nextButton) ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [previousButton, nextButton],
              ),
            ],
          ),
    );
  }
}

class _DefaultHeader extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _DefaultHeader({
    required this.currentMonth,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarHeader().buildHeader(currentMonth, onPrevious, onNext);
  }
}

class MonthYear {
  final String month;
  final String year;

  const MonthYear({required this.month, required this.year});
}

class _CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime? selectedDate;
  final Color containerColor;
  final Color onContainerColor;
  final Color color;
  final ValueChanged<DateTime> onDateSelected;

  const _CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.containerColor,
    required this.onContainerColor,
    required this.color,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final startingDayOfWeek = firstDayOfMonth.weekday % 7; // 0 (Sunday) to 6 (Saturday)
    final daysInMonth = lastDayOfMonth.day;

    // Calculate the total number of slots needed (including empty slots before the first day)
    final totalDaysWithOffset = daysInMonth + startingDayOfWeek;
    // Ensure at least 4 rows for months like February, but allow up to 6 rows if needed
    final rows = (totalDaysWithOffset / 7).ceil().clamp(4, 6);

    return Column(
      children: [
        const _WeekDays(),
        ...List.generate(rows, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (colIndex) {
              final dayIndex = rowIndex * 7 + colIndex - startingDayOfWeek + 1;
              if (dayIndex < 1 || dayIndex > daysInMonth) {
                return const SizedBox(width: 40, height: 40);
              }
              final date = DateTime(currentMonth.year, currentMonth.month, dayIndex);
              final isSelected = selectedDate != null &&
                  selectedDate!.year == date.year &&
                  selectedDate!.month == date.month &&
                  selectedDate!.day == date.day;

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? containerColor : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$dayIndex',
                      style: TextStyle(
                        color: isSelected ? onContainerColor : color,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}

class _WeekDays extends StatelessWidget {
  const _WeekDays();

  @override
  Widget build(BuildContext context) {
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((day) {
        return SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}