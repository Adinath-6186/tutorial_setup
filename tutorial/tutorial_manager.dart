import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practiva/core/tutorial/tutorial_target_helper.dart';

import 'tutorial_step.dart';
import 'tutorial_storage.dart';
import 'tutorial_coach_mark_adapter.dart';

class TutorialManager {
  TutorialManager._();

  static final TutorialManager instance = TutorialManager._();

  final TutorialStorage _storage = TutorialStorage();
  final TutorialCoachMarkAdapter _adapter = TutorialCoachMarkAdapter();

  Future<void> show({
    required BuildContext context,
    required String tutorialId,
    required List<TutorialStep> steps,
    final VoidCallback? onfinish,
    bool force = false,
  }) async {
    if (!context.mounted || steps.isEmpty) return;

    final isCompleted = await _storage.isCompleted(tutorialId);
    if (!force && isCompleted) {
      return;
    }

    log("Tutorial ID $tutorialId ${isCompleted}");

    if (!context.mounted) return;

    await _adapter.show(
      context: context,
      steps: steps,
      onFinish: () {
        _storage.markCompleted(tutorialId);
        if(onfinish != null){
          onfinish();
        }
      },
      onSkip: () {
        _storage.markCompleted(tutorialId);
        if(onfinish != null){
          onfinish();
        }
      },
    );
  }



  Future<void> showSequentially({
    required BuildContext context,
    required List<TutorialStep> steps,
    required String tutorialId,
    bool force = false,
  }) async {
    for (final step in steps) {
      if (!context.mounted) return;

      // 1. Target visible/rendered करा.
      final ready =  await TutorialTargetHelper.ensureVisible(
        step.targetKey,
      );

      if (!ready || !context.mounted) {
        continue;
      }

      // 2. प्रत्येक tutorial संपेपर्यंत wait करा.
      await show(
        context: context,
        tutorialId: '${tutorialId}_${step.id}',
        steps: [step],
        force: force,
      );
    }
  }


  Future<void> reset(String tutorialId) {
    return _storage.reset(tutorialId);
  }
}