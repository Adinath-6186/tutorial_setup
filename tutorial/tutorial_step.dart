import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialStep {
  final String id;
  final GlobalKey targetKey;
  final String title;
  final String description;
  final ContentAlign contentAlign;
  final ShapeLightFocus shape;
  final double radius;

  const TutorialStep({
    required this.id,
    required this.targetKey,
    required this.title,
    required this.description,
    this.contentAlign = ContentAlign.bottom,
    this.shape = ShapeLightFocus.RRect,
    this.radius = 12,
  });
}

bool isTutorialTargetReady(GlobalKey key) {
  final context = key.currentContext;
  if (context == null) return false;

  final renderObject = context.findRenderObject();

  return renderObject is RenderBox &&
      renderObject.attached &&
      renderObject.hasSize &&
      renderObject.size.isFinite &&
      renderObject.size.width > 0 &&
      renderObject.size.height > 0;
}