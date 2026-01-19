class ProposalModel {
  final String id;
  final String providerName;
  final String? providerImageUrl;
  final double rating;
  final int reviewCount;
  final String timeAgo;
  final String description;
  final String offeringCost;
  final int workPerformance; // percentage (0-100)
  final int totalCompletedJobs;
  final String projectEstimateTimeline;
  final List<ProposalAttachment> attachments;

  ProposalModel({
    required this.id,
    required this.providerName,
    this.providerImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.timeAgo,
    required this.description,
    required this.offeringCost,
    required this.workPerformance,
    required this.totalCompletedJobs,
    required this.projectEstimateTimeline,
    required this.attachments,
  });
}

class ProposalAttachment {
  final String name;
  final String size;
  final String? thumbnailUrl;
  final String? fileType; // 'image' or 'pdf' or 'document'

  ProposalAttachment({
    required this.name,
    required this.size,
    this.thumbnailUrl,
    this.fileType,
  });
}
