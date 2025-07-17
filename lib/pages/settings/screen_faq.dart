part of '../_pages.dart';

/// ****************************************************************************
/// FAQ's Screen
/// ****************************************************************************
class ScreenFaq extends StatefulWidget {
  const ScreenFaq({super.key});

  @override
  State<ScreenFaq> createState() => _ScreenFaqState();
}

class _ScreenFaqState extends State<ScreenFaq> {
  final List<String> _categories = ['All', 'Account', 'Billing', 'Prompting'];
  String _selectedCategory = 'All';

  final List<FAQItem> _allFaqs = [
    FAQItem(
      category: 'Account',
      question: 'Can I edit a generated response?',
      answer: 'You can edit responses manually in the app.',
    ),
    FAQItem(
      category: 'Account',
      question: 'How do I reset my password?',
      answer: 'Go to Forgot Password and follow instructions.',
    ),
    FAQItem(
      category: 'Billing',
      question: 'Can I export my data?',
      answer: 'Yes, you can export from Settings > Data Management.',
    ),
    FAQItem(
      category: 'Billing',
      question: 'How can I delete my history?',
      answer: 'History can be deleted from your account settings.',
    ),
    FAQItem(
      category: 'Prompting',
      question: 'Are my data secure?',
      answer:
          'We use industry standard security practices to keep your data safe.',
    ),
  ];

  int? _expandedIndex = 0; // Initially expand the first item

  @override
  Widget build(BuildContext context) {
    final List<FAQItem> filteredFaqs =
        _selectedCategory == 'All'
            ? _allFaqs
            : _allFaqs
                .where((faq) => faq.category == _selectedCategory)
                .toList();

    return Scaffold(
      appBar: ChildPageAppBar(title: "Help Center"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Chips
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                      _expandedIndex = 0; // Reset expanded when changing filter
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r)
                  ),
                  selectedColor: goliathsTheme.accent,
                  backgroundColor: goliathsTheme.onPrimary,
                  labelStyle: TextStyle(
                    color: isSelected ? goliathsTheme.text : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // FAQ List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredFaqs.length,
            itemBuilder: (context, index) {
              final faq = filteredFaqs[index];
              final isExpanded = _expandedIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Color(0xFFF2F2F2),
                ),
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    faq.question,
                    style: goliathsTypography.screenTitle,
                  ),
                  trailing: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_right,
                    color: goliathsTheme.onPrimary,
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expandedIndex = expanded ? index : null;
                    });
                  },
                  initiallyExpanded: isExpanded,
                  children: [
                    Text(
                      faq.answer,
                      textAlign: TextAlign.start,
                      style: goliathsTypography.screenText.copyWith(
                        fontSize: 13.sp,
                        color: goliathsTheme.text.withValues(alpha: 0.8),
                        fontFamily: "Roboto"
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
