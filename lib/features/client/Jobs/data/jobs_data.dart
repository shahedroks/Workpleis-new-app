import '../model/job_model.dart';

final List<JobModel> activeJobs = [
  JobModel(
    id: '1',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.active,
  ),
  JobModel(
    id: '2',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.active,
  ),
  JobModel(
    id: '3',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.active,
  ),
  JobModel(
    id: '4',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.active,
  ),
];

final List<JobModel> pendingJobs = [
  JobModel(
    id: '5',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
  JobModel(
    id: '6',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
  JobModel(
    id: '7',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
];

final List<JobModel> completedJobs = [];

final List<JobModel> cancelledJobs = [
  JobModel(
    id: '8',
    title: 'Need help with setting up my new office space',
    quote: '4-6 hours',
    price: '\$600',
    bid: '1+',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.cancelled,
  ),
  // Add 8 more cancelled jobs to match the count
  ...List.generate(8, (index) => JobModel(
        id: '${9 + index}',
        title: 'Need help with setting up my new office space',
        quote: '4-6 hours',
        price: '\$600',
        bid: '1+',
        services: [
          'Office Furniture Assembly',
          'Custom Desk Assembly',
          'Chair Assembly',
        ],
        status: JobStatus.cancelled,
      )),
];

