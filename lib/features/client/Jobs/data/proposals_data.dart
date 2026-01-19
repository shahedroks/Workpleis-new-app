import '../model/proposal_model.dart';

final List<ProposalModel> sampleProposals = [
  ProposalModel(
    id: '1',
    providerName: 'Utman Ali',
    providerImageUrl: 'assets/images/ali.png', // Using existing profile image
    rating: 4.6,
    reviewCount: 12,
    timeAgo: '5 min ago',
    description:
        'I believe I am well-suited for this project. So far, I have gained a solid understanding of the requirements and objectives. I am eager to dive in and start collaborating with the team to bring this project to life.'
         '\n \n Lets get started and make it a success!'
    ,
    offeringCost: 'SAR 250',
    workPerformance: 99,
    totalCompletedJobs: 25,
    projectEstimateTimeline: '2-4 days',
    attachments: [
      ProposalAttachment(
        name: 'Attachment file 2024.jpeg',
        size: '1.2 MB',
        thumbnailUrl: 'assets/images/attachment.png', // Using existing image as placeholder
        fileType: 'image',
      ),
      ProposalAttachment(
        name: 'Requirement of project.pdf',
        size: '3.1 MB',
        thumbnailUrl: 'assets/images/requiement.png',
        fileType: 'pdf',
      ),
    ],
  ),
  ProposalModel(
    id: '2',
    providerName: 'Utman Ali',
    providerImageUrl: 'assets/images/ali.png', // Using existing profile image
    rating: 4.6,
    reviewCount: 12,
    timeAgo: '5 min ago',
    description:
        'I believe I am well-suited for this project. So far, I have gained a solid understanding of the requirements and have experience working on similar projects. I am confident that I can deliver high-quality results within the specified timeframe.',
    offeringCost: 'SAR 250',
    workPerformance: 99,
    totalCompletedJobs: 25,
    projectEstimateTimeline: '2-4 days',
    attachments: [
      ProposalAttachment(
        name: 'Attachment file 2024.jpeg',
        size: '1.2 MB',
        thumbnailUrl: 'assets/images/attachment.png', // Using existing image as placeholder
        fileType: 'image',
      ),
      ProposalAttachment(
        name: 'Requirement of project.pdf',
        size: '3.1 MB',
        thumbnailUrl: 'assets/images/requiement.png',
        fileType: 'pdf',
      ),
    ],
  ),
];
