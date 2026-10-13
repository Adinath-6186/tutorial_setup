import 'package:flutter/material.dart';

class TutorialTargetHelper {
  /// Checks whether the target widget is mounted and has a valid size.
  static bool isTutorialTargetReady(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return false;

    final renderObject = context.findRenderObject();

    return renderObject is RenderBox &&
        renderObject.attached &&
        renderObject.hasSize &&
        renderObject.size.width > 0 &&
        renderObject.size.height > 0;
  }

  /// Waits until the target widget is ready, or times out.
  static Future<bool> waitForTarget(GlobalKey key, {Duration timeout = const Duration(seconds: 10)}) async {
    final stopwatch = Stopwatch()..start();

    while (stopwatch.elapsed < timeout) {
      await WidgetsBinding.instance.endOfFrame;

      if (isTutorialTargetReady(key)) {
        return true;
      }

      await Future.delayed(const Duration(milliseconds: 100));
    }

    return false;
  }

  /// Waits for a target and scrolls it into view.
  static Future<bool> ensureVisible(GlobalKey key, {
        Duration timeout = const Duration(seconds: 10),
      }) async {
    final ready = await waitForTarget(key, timeout: timeout);
    if (!ready) return false;

    final context = key.currentContext;
    if (context == null) return false;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      alignment: 0.3,
      curve: Curves.easeInOut,
    );

    await WidgetsBinding.instance.endOfFrame;

    return isTutorialTargetReady(key);
  }
}