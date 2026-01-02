import 'package:flutter/material.dart';

class MoodSelector extends StatefulWidget {
  final List<Map<String, String>> moodlist;
  final String selectedMood;
  final Function(String) onMoodChanged;

  const MoodSelector({
    super.key,
    required this.moodlist,
    required this.selectedMood,
    required this.onMoodChanged,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose your Mood Today:",
          style: Theme.of(context).textTheme.titleMedium
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              prefixIcon: Icon(Icons.mood, color: Colors.grey.shade600),
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            value: widget.selectedMood,
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
            style: Theme.of(context).textTheme.bodySmall,
            items: widget.moodlist.map((mood) {
              return DropdownMenuItem<String>(
                value: mood["key"],
                child: Row(
                  children: [
                    Text(
                      mood["label"]!.split(' ')[0],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    Text(
                      mood["label"]!.split(' ')[1],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newvalue) {
              if (newvalue != null) {
                widget.onMoodChanged(newvalue);
              }
            },
          ),
        ),
      ],
    );
  }
}
