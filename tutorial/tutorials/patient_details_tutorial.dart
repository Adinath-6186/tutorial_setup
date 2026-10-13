import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../../core/tutorial/tutorial_step.dart';

class PatientDetailsTutorial {
  static const id = 'patient_details_v1';
  static const menuTutorialId = 'patient_menu_v1';

  // AppBar
  static final menuKey = GlobalKey();
  // Menu dialog
  static final editPatientKey = GlobalKey();
  static final deactivatePatientKey = GlobalKey();
  static final manageVisitsKey = GlobalKey();
  static final timelineKey = GlobalKey();
  static final manageInvoicesKey = GlobalKey();
  static final manageReceiptsKey = GlobalKey();

  // Main screen cards
  static final outstandingKey = GlobalKey();
  static final recordVisitKey = GlobalKey();
  static final scheduleAppointmentKey = GlobalKey();
  static final openingBalanceKey = GlobalKey();
  static final notesKey = GlobalKey();
  static final tagsKey = GlobalKey();
  // Fixed bottom actions
  static final callKey = GlobalKey();
  static final editKey = GlobalKey();


  static List<TutorialStep> get tutorial => [
    TutorialStep(
      id: 'patient_menu',
      targetKey: menuKey,
      title: 'Patient Menu',
      description: 'Tap here to access patient management options.',
      shape: ShapeLightFocus.Circle,
    ),
    TutorialStep(
      id: 'current_outstanding',
      targetKey: outstandingKey,
      title: 'Current Outstanding',
      description: 'View patient due and family balance.',
    ),
    TutorialStep(
      id: 'record_visit',
      targetKey: recordVisitKey,
      title: "Record Today's Visit",
      description: 'Record a new visit for this patient.',
    ),
    TutorialStep(
      id: 'schedule_appointment',
      targetKey: scheduleAppointmentKey,
      title: 'Schedule Appointment',
      description: 'Book an appointment for this patient.',
    ),
    TutorialStep(
      id: 'opening_balance',
      targetKey: openingBalanceKey,
      title: 'Opening Balance',
      description: 'View or update the opening balance.',
    ),
    TutorialStep(
      id: 'patient_notes',
      targetKey: notesKey,
      title: 'Notes',
      description: 'Add and review patient notes.',
    ),
    TutorialStep(
      id: 'patient_tags',
      targetKey: tagsKey,
      title: 'Tags',
      description: 'Manage tags associated with this patient.',
    ),
    TutorialStep(
      id: 'call_patient',
      targetKey: callKey,
      title: 'Call Patient',
      description: 'Call the patient using their registered number.',
    ),
    TutorialStep(
      id: 'edit_patient_details',
      targetKey: editKey,
      title: 'Edit Details',
      description: 'Edit the patient information from here.',
    ),
  ];

  static List<TutorialStep> get menuOptionSteps => [
    TutorialStep(
      id: 'edit_patient',
      targetKey: editPatientKey,
      title: 'Edit Patient',
      description: 'Update patient details.',
    ),
    TutorialStep(
      id: 'deactivate_patient',
      targetKey: deactivatePatientKey,
      title: 'Deactivate Patient',
      description: 'Deactivate this patient when required.',
    ),
    TutorialStep(
      id: 'manage_visits',
      targetKey: manageVisitsKey,
      title: 'Manage Visits',
      description: 'View visits, treatments and prescriptions.',
    ),
    TutorialStep(
      id: 'patient_timeline',
      targetKey: timelineKey,
      title: 'Timeline',
      description: 'Review patient history and clinical notes.',
    ),
    TutorialStep(
      id: 'manage_invoices',
      targetKey: manageInvoicesKey,
      title: 'Manage Invoices',
      description: 'View treatment and product invoices.',
    ),
    TutorialStep(
      id: 'manage_receipts',
      targetKey: manageReceiptsKey,
      title: 'Manage Receipts',
      description: 'Review payments and settlements.',
    ),
  ];

}