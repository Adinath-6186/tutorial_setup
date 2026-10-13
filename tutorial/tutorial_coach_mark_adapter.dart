import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practiva/core/tutorial/tutorial_target_helper.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'tutorial_step.dart';


class TutorialCoachMarkAdapter {
  Future<void> show({
    required BuildContext context,
    required List<TutorialStep> steps,
    required VoidCallback onFinish,
    required VoidCallback onSkip,
  }) async {
    if (steps.isEmpty) return;

    final completer = Completer<void>();

    void completeOnce(VoidCallback callback) {
      if (completer.isCompleted) return;

      callback();
      completer.complete();
    }

    final targets = steps.map((step) {
      return TargetFocus(
        identify: step.id,
        keyTarget: step.targetKey,
        enableTargetTab: true,
        enableOverlayTab: false,
        shape: step.shape,
        radius: step.radius,

        contents: [
          TargetContent(
            align: step.contentAlign,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  step.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();

    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      paddingFocus: 8,

      useSafeArea: true,
      beforeFocus: (target) async {
        debugPrint('About to focus: ${target.identify}');
        await TutorialTargetHelper.ensureVisible(target.keyTarget!);
        await Future.delayed(Duration(milliseconds: 300));
      },


      onFinish: () {
        completeOnce(onFinish);
      },

      onSkip: () {
        completeOnce(onSkip);
        return true;
      },
    ).show(context: context);

    await completer.future;
  }
}
