import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Enum for post categories
enum Category {
  Emergency,
  Event,
  Business,
}

/// Extension to handle converting enum values to and from strings
extension CategoryExtension on Category {
  String get name => describeEnum(this);

  static Category fromString(String category) {
    return Category.values.firstWhere(
      (e) => describeEnum(e).toLowerCase() == category.toLowerCase(),
      orElse: () => Category.Event, // Default value if not found
    );
  }
}

class Post {
  final String id;
  final String title;
  final String? link;
  final String? description;
  final List<String> upvotes;
  final int commentCount;
  final String username;
  final String uid;
  final String type;
  final DateTime createdAt;
  final Category category;
  //final String location; // Category field

  Post({
    required this.id,
    required this.title,
    this.link,
    this.description,
    required this.upvotes,
    required this.commentCount,
    required this.username,
    required this.uid,
    required this.type,
    required this.createdAt,
    required this.category,
    //  required this.location,
  });

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? description,
    List<String>? upvotes,
    int? commentCount,
    String? username,
    String? uid,
    String? type,
    DateTime? createdAt,
    Category? category,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      upvotes: upvotes ?? this.upvotes,
      commentCount: commentCount ?? this.commentCount,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
    );
  }
/*
  factory Post.fromFirestore(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      createdAt: data['date'] ?? '',
      title: data['title'] ?? '',
      location: data['location'] ?? '',
      attendees: data['attendees'] ?? 0,
    );
  }
  */

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'description': description,
      'upvotes': upvotes,
      'commentCount': commentCount,
      'username': username,
      'uid': uid,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'category': category.name,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      link: map['link'],
      description: map['description'],
      upvotes: List<String>.from(map['upvotes']),
      commentCount: map['commentCount']?.toInt() ?? 0,
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      type: map['type'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      category: CategoryExtension.fromString(map['category']),
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, description: $description, upvotes: $upvotes, commentCount: $commentCount, username: $username, uid: $uid, type: $type, createdAt: $createdAt, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.title == title &&
        other.link == link &&
        other.description == description &&
        listEquals(other.upvotes, upvotes) &&
        other.commentCount == commentCount &&
        other.username == username &&
        other.uid == uid &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        link.hashCode ^
        description.hashCode ^
        upvotes.hashCode ^
        commentCount.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        category.hashCode;
  }
}
