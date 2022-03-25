import 'package:flutter/material.dart';

import '../../../model/annotation_model.dart';

class AnnotationWidgetText extends StatelessWidget {
  const AnnotationWidgetText(
      {Key? key, required this.annotationModel, required this.bookName})
      : super(key: key);

  final AnnotationModel annotationModel;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(
          bookName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          annotationModel.textAnnotation,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
