class JobModel {
  final String id;
  final String title;
  // For Active jobs
  final String? quote; // e.g., "4-6 hours"
  final String? price; // e.g., "$600"
  final String? bid; // e.g., "1+"
  // For Pending/Completed/Cancelled jobs
  final String? estimate; // e.g., "4-6 hours"
  final String? cost; // e.g., "$600"
  final String? provider; // e.g., "Ali Hasan"
  final String? description; // Job description text
  // For Completed jobs
  final String? reviewStatus; // e.g., "Due Review" or null if reviewed
  final double? rating; // e.g., 3.5 (out of 5)
  final List<String> services; // e.g., ["Office Furniture Assembly", "Custom Desk Assembly"]
  final JobStatus status;

  JobModel({
    required this.id,
    required this.title,
    this.quote,
    this.price,
    this.bid,
    this.estimate,
    this.cost,
    this.provider,
    this.description,
    this.reviewStatus,
    this.rating,
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

