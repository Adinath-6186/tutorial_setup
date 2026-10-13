import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/tutorial/tutorial_step.dart';


class AppointmentActionTutorialKeys {
  final GlobalKey checkInKey = GlobalKey();
  final GlobalKey rescheduleKey = GlobalKey();
  final GlobalKey cancelKey = GlobalKey();
}

class AppointmentTutorial {
  static const id = 'appointment_actions_v1';

  static final addAppointmentKey = GlobalKey();
  static AppointmentActionTutorialKeys appointmentTutorialKeys  = AppointmentActionTutorialKeys();

  static List<TutorialStep> get steps => [
    TutorialStep(
      id: 'add_appointment',
      targetKey: addAppointmentKey,
      title: 'Book Appointment',
      description: 'Tap + to create a new patient appointment.',
      shape: ShapeLightFocus.Circle,
    ),
    TutorialStep(
      id: 'check_in',
      targetKey: appointmentTutorialKeys.checkInKey,
      title: 'Check-in',
      description: 'Mark the patient as checked in when they arrive.',
    ),
    TutorialStep(
      id: 'reschedule',
      targetKey: appointmentTutorialKeys.rescheduleKey,
      title: 'Reschedule',
      description: 'Change the appointment date or time.',
    ),
    TutorialStep(
      id: 'cancel',
      targetKey: appointmentTutorialKeys.cancelKey,
      title: 'Cancel Appointment',
      description: 'Cancel an appointment when it is no longer needed.',
    ),
  ].where((step) => isTutorialTargetReady(step.targetKey)).toList();
}