class JobModel {
  final String id;
  final String title;
  final String quote; // e.g., "4-6 hours"
  final String price; // e.g., "$600"
  final String bid; // e.g., "1+"
  final List<String> services; // e.g., ["Office Furniture Assembly", "Custom Desk Assembly"]
  final JobStatus status;

  JobModel({
    required this.id,
    required this.title,
    required this.quote,
    required this.price,
    required this.bid,
    required this.services,
    required this.status,
  });
}

enum JobStatus {
  active,
  pending,
  completed,
  cancelled,
}

