import 'package:flutter/material.dart';
import 'sample_project.dart';

class Specialization {
  final String title;
  final String subtitle;
  final IconData icon;
  final String whatIsIt;
  final List<String> whatWillILearn;
  final List<String> skillsRequired;
  final List<String> targetTechnologies;
  final List<Map<String, String>> careerPaths;
  final String isItForMe;
  final String expectText;
  final List<String> sampleSubjects;
  final List<SampleProject> sampleProjects;

  Specialization({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.whatIsIt,
    required this.whatWillILearn,
    required this.skillsRequired,
    required this.targetTechnologies,
    required this.careerPaths,
    required this.isItForMe,
    required this.expectText,
    required this.sampleSubjects,
    this.sampleProjects = const [],
  });
}