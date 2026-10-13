import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/tutorial/tutorial_step.dart';

class DashboardTutorial {
  static const id = 'dashboard_v1';

  static final patientsKey = GlobalKey();
  static final appointmentsKey = GlobalKey();
  static final visitsKey = GlobalKey();
  static final reportsKey = GlobalKey();
  static final accountsKey = GlobalKey();
  static final opdRegisterKey = GlobalKey();
  static final clinicMastersKey = GlobalKey();

  static List<TutorialStep> get steps => [
    TutorialStep(
      id: 'patients',
      targetKey: patientsKey,
      title: 'Patients',
      description: 'Register patients and manage their details.',
    ),
    TutorialStep(
      id: 'appointments',
      targetKey: appointmentsKey,
      title: 'Appointments',
      description: 'View, book, and manage clinic appointments.',
    ),
    TutorialStep(
      id: 'patient_visits',
      targetKey: visitsKey,
      title: 'Patient Visits',
      description: 'View patient visits and their details.',
    ),
    TutorialStep(
      id: 'reports',
      targetKey: reportsKey,
      title: 'Reports',
      description: 'Access clinic reports and summaries.',
    ),
    TutorialStep(
      id: 'accounts',
      targetKey: accountsKey,
      title: 'Accounts',
      description: 'Manage clinic financial records.',
    ),
    TutorialStep(
      id: 'opd_register',
      targetKey: opdRegisterKey,
      title: 'OPD Register',
      description: 'Access the outpatient department register.',
    ),
    TutorialStep(
      id: 'clinic_masters',
      targetKey: clinicMastersKey,
      title: 'Clinic Masters',
      description: 'Manage your clinic configuration and master data.',
    ),
  ];
}