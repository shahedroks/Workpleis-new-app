/// Enum to distinguish between Job and Project flows
/// Both use the same logic, only the terminology differs
enum FlowType {
  job,
  project,
}

extension FlowTypeExtension on FlowType {
  /// Returns the singular form (Job or Project)
  String get singular {
    switch (this) {
      case FlowType.job:
        return 'Job';
      case FlowType.project:
        return 'Project';
    }
  }

  /// Returns the plural form (Jobs or Projects)
  String get plural {
    switch (this) {
      case FlowType.job:
        return 'Jobs';
      case FlowType.project:
        return 'Projects';
    }
  }
}
