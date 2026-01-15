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
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    provider: 'Ali Hasan',
    description: 'I need professional help to assemble office furniture in my new shop. The furniture includes desks, chairs, and storage units. I\'m looking for someone experienced with furniture assembly who can complete the work efficiently and carefully. The shop is located in a convenient location with easy access. Please contact me if you have experience with similar projects.',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
  JobModel(
    id: '6',
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    provider: 'Ali Hasan',
    description: 'I need professional help to assemble office furniture in my new shop. The furniture includes desks, chairs, and storage units. I\'m looking for someone experienced with furniture assembly who can complete the work efficiently and carefully. The shop is located in a convenient location with easy access. Please contact me if you have experience with similar projects.',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
  JobModel(
    id: '7',
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    provider: 'Ali Hasan',
    description: 'I need professional help to assemble office furniture in my new shop. The furniture includes desks, chairs, and storage units. I\'m looking for someone experienced with furniture assembly who can complete the work efficiently and carefully. The shop is located in a convenient location with easy access. Please contact me if you have experience with similar projects.',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.pending,
  ),
];

final List<JobModel> completedJobs = [
  JobModel(
    id: '10',
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    reviewStatus: 'Due Review',
    description:
        'I am seeking a skilled and reliable service provider to handle the assembly of furniture in my shop. The ideal candidate will have experience with assembling various types of furniture, including shelving units, display cases, and seating. Attention to detail and the ability to work efficiently are essential qualities. The project requires someone who can work independently and complete the task within the specified timeframe.',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.completed,
  ),
  JobModel(
    id: '11',
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    rating: 3.5,
    description:
        'I am seeking a skilled and reliable service provider to handle the assembly of furniture in my shop. The ideal candidate will have experience with assembling various types of furniture, including shelving units, display cases, and seating. Attention to detail and the ability to work efficiently are essential qualities. The project requires someone who can work independently and complete the task within the specified timeframe.',
    services: [
      'Office Furniture Assembly',
      'Custom Desk Assembly',
      'Chair Assembly',
    ],
    status: JobStatus.completed,
  ),
];

final List<JobModel> cancelledJobs = [
  JobModel(
    id: '8',
    title: "I'm looking for a service provider for furniture assembly in my shop",
    estimate: '4-6 hours',
    cost: '\$600',
    provider: 'Ali Hasan',
    description: 'I need professional help to assemble office furniture in my new shop. The furniture includes desks, chairs, and storage units. I\'m looking for someone experienced with furniture assembly who can complete the work efficiently and carefully.',
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
        title: "I'm looking for a service provider for furniture assembly in my shop",
        estimate: '4-6 hours',
        cost: '\$600',
        provider: 'Ali Hasan',
        description: 'I need professional help to assemble office furniture in my new shop. The furniture includes desks, chairs, and storage units. I\'m looking for someone experienced with furniture assembly who can complete the work efficiently and carefully.',
        services: [
          'Office Furniture Assembly',
          'Custom Desk Assembly',
          'Chair Assembly',
        ],
        status: JobStatus.cancelled,
      )),
];

