import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(id),
    );
  }
}
