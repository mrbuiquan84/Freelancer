import 'package:equatable/equatable.dart';
import 'package:freelancer/common/models/job_cate.dart';

abstract class JobcateState extends Equatable {}

class JobcateLoadState extends JobcateState {
  @override
  List<Object?> get props => [];
}

class JobcateListState extends JobcateState {
  final List<JobCate> jobcates;
  final List<JobCate> selectedJobcates;

  JobcateListState(
    this.jobcates, {
    this.selectedJobcates = const [],
  });

  @override
  List<Object?> get props => [jobcates, selectedJobcates];
}

class SkillListState extends JobcateState {
  final List<Skill> skills;
  final List<Skill> selectedSkills;
  SkillListState(
    this.skills, {
    this.selectedSkills = const [],
  });
  @override
  List<Object?> get props => [skills, selectedSkills];
}

class JobcateErrorState extends JobcateState {
  final String error;
  JobcateErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
