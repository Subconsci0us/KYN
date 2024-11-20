import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyn/models/post_model.dart';
import 'package:uuid/uuid.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();
  String selectedTimeFrame = 'Tomorrow';

  Future<void> addPost(Post post) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts') // Ensure you specify the collection name
          .doc(post.id)
          .set(post.toMap());
    } on FirebaseException catch (e) {
      throw Exception('Failed to add post: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _handleCreatePost() {
    if (_eventNameController.text.isEmpty || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    final post = Post(
      id: Uuid().v4(), // Generate unique ID for the post
      title: _eventNameController.text,
      description: _eventDescriptionController.text,
      upvotes: [],
      commentCount: 0,
      username: 'User123', // Replace with actual username
      uid: 'UserId', // Replace with actual user ID
      type: 'Event',
      createdAt: DateTime.now(),
      category: Category.values.firstWhere(
        (e) => e.toString().split('.').last == selectedCategory,
      ),
    );

    addPost(post).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully!')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Post'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Choose Post Category',
              ),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: ['Emergency', 'Event', 'Business']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),

            // Event Name TextField
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(
                hintText: 'Event Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // Event Description TextField
            TextField(
              controller: _eventDescriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Event Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // Time & Date Section
            Text(
              'Time & Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),

            // Time Frame Selection
            Row(
              children: [
                _timeFrameButton('Today'),
                SizedBox(width: 8),
                _timeFrameButton('Tomorrow'),
                SizedBox(width: 8),
                _timeFrameButton('This week'),
              ],
            ),
            SizedBox(height: 8),

            // Calendar Selection
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                    'Choose from calendar (${selectedDate.toLocal().toString().split(' ')[0]})'),
                trailing: Icon(Icons.chevron_right),
                onTap: _pickDate,
              ),
            ),

            Spacer(),

            // Create Post Button
            ElevatedButton(
              onPressed: _handleCreatePost,
              child: Text(
                'CREATE POST',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeFrameButton(String text) {
    bool isSelected = selectedTimeFrame == text;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedTimeFrame = text;
          });
        },
        child: Text(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
