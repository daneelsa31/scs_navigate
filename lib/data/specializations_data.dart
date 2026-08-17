import 'package:flutter/material.dart';
import '../models/specialization.dart';
import '../models/sample_project.dart';


// ============================================================
// WEB DEVELOPMENT
// ============================================================

final Specialization webDevelopmentSpec = Specialization(
  title: 'Web Development',
  subtitle: 'Build websites. Build applications. Build solutions.',
  icon: Icons.language,

  whatIsIt:
      'Web Development focuses on designing, building, and deploying interactive web applications. You will learn front-end design systems, robust backend server architectures, relational/non-relational databases, and modern cloud deployment APIs.',

  whatWillILearn: [
    'Modern Front-end Architecture (HTML5, CSS3, Modern JS Frameworks)',
    'Backend API Development (RESTful Services, Node.js, PHP)',
    'Database Design & Management (SQL, NoSQL, ORMs)',
    'Web Security & Authentication Standards',
    'Cloud Deployment & Hosting Maintenance',
  ],

  skillsRequired: [
    'Programming',
    'Problem-Solving',
    'Database Management',
    'UI Development',
    'API Design',
  ],

  targetTechnologies: [
    'HTML',
    'CSS',
    'JavaScript',
    'TypeScript',
    'PHP',
    'React',
    'Node.js',
    'MySQL',
    'Git',
  ],

  careerPaths: [
    {
      'title': 'Web Developer',
      'desc': 'Creates and maintains functional, responsive websites.',
    },
    {
      'title': 'Front-End Developer',
      'desc':
          'Specializes in user interface design, animations, and user experience.',
    },
    {
      'title': 'Back-End Developer',
      'desc':
          'Builds server logic, database architectures, and API integrations.',
    },
    {
      'title': 'Full-Stack Developer',
      'desc':
          'Handles both client-side UI and server-side infrastructure.',
    },
  ],

  isItForMe:
      'You may enjoy Web Development if you like building websites, coding interactive interfaces, designing user experiences, and seeing your solutions instantly accessible on the browser.',

  expectText:
      'Programming • Debugging • Project-Based Evaluation • Continuous practice with modern frameworks',

  sampleSubjects: [
    'Web Systems and Technologies',
    'Database Systems',
    'Client-Side Scripting',
    'Server-Side Programming',
  ],

  // ----------------------------------------------------------
  // SAMPLE PROJECTS
  // ----------------------------------------------------------

  sampleProjects: [
    SampleProject(
      title: 'SCS Campus Event & Facility Booking Portal',
      description:
          'A web-based campus portal for viewing events, checking facility availability, and submitting reservation requests.',
      mediaType: 'image',
      technologies: [
        'HTML',
        'CSS',
        'JavaScript',
        'Node.js',
        'MySQL',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Student Academic Portfolio & Project Showcase',
      description:
          'A responsive platform where students can showcase their projects, skills, achievements, and technical portfolios.',
      mediaType: 'image',
      technologies: [
        'React',
        'TypeScript',
        'Tailwind CSS',
        'Supabase',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Online Student Organization Management System',
      description:
          'A centralized web application for managing organization members, announcements, activities, and event registrations.',
      mediaType: 'video',
      technologies: [
        'PHP',
        'MySQL',
        'JavaScript',
        'Bootstrap',
      ],
      githubUrl: '',
      demoUrl: '',
    ),
  ],
);


// ============================================================
// MOBILE DEVELOPMENT
// ============================================================

final Specialization mobileDevelopmentSpec = Specialization(
  title: 'Mobile Development',
  subtitle:
      'Create native and cross-platform mobile apps for millions of users.',
  icon: Icons.phone_android,

  whatIsIt:
      'Mobile Development focuses on designing and building applications for smartphones and tablets. You will learn native and cross-platform frameworks, mobile UI/UX principles, device APIs, and app store deployment.',

  whatWillILearn: [
    'Cross-Platform App Development (Flutter, Dart)',
    'Native Android/iOS Fundamentals',
    'Mobile UI/UX & Responsive Layouts',
    'Local Storage & State Management',
    'App Store Deployment & Distribution',
  ],

  skillsRequired: [
    'Programming',
    'UI Development',
    'Problem-Solving',
    'App Design',
    'Testing & Debugging',
  ],

  targetTechnologies: [
    'Dart',
    'Flutter',
    'Kotlin',
    'Java',
    'Swift',
    'Firebase',
    'Git',
  ],

  careerPaths: [
    {
      'title': 'Mobile App Developer',
      'desc':
          'Builds and maintains apps for Android and iOS platforms.',
    },
    {
      'title': 'Flutter Developer',
      'desc':
          'Specializes in cross-platform apps using a single codebase.',
    },
    {
      'title': 'Android Developer',
      'desc':
          'Focuses on native Android app development.',
    },
    {
      'title': 'iOS Developer',
      'desc':
          'Focuses on native iOS app development using Swift.',
    },
  ],

  isItForMe:
      'You may enjoy Mobile Development if you like building apps people carry in their pockets, designing touch-friendly interfaces, and seeing your work run on real devices.',

  expectText:
      'Programming • Debugging • Device Testing • Continuous practice with mobile frameworks',

  sampleSubjects: [
    'Mobile Application Development',
    'Human-Computer Interaction',
    'Database Systems',
    'Application Deployment',
  ],

  // ----------------------------------------------------------
  // SAMPLE PROJECTS
  // ----------------------------------------------------------

  sampleProjects: [
    SampleProject(
      title: 'SCS Navigate Mobile App',
      description:
          'A student-focused mobile application that helps SCS students discover academic pathways, opportunities, events, and useful resources.',
      mediaType: 'image',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Campus Announcement & Bulletin App',
      description:
          'A mobile application for viewing campus announcements, student notices, and categorized updates in one place.',
      mediaType: 'image',
      technologies: [
        'Flutter',
        'Dart',
        'Hive',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Student Expense Tracker',
      description:
          'A mobile budgeting application that helps students record expenses, organize spending categories, and monitor their budget.',
      mediaType: 'video',
      technologies: [
        'Flutter',
        'Dart',
        'SQLite',
        'Firebase',
      ],
      githubUrl: '',
      demoUrl: '',
    ),
  ],
);


// ============================================================
// CYBERSECURITY
// ============================================================

final Specialization cybersecuritySpec = Specialization(
  title: 'Cybersecurity',
  subtitle:
      'Protect networks, data, and systems from emerging cyber threats.',
  icon: Icons.security,

  whatIsIt:
      'Cybersecurity focuses on protecting networks, systems, and data from digital attacks. You will learn network defense, ethical hacking fundamentals, risk assessment, and security policy implementation.',

  whatWillILearn: [
    'Network Security & Defense Fundamentals',
    'Ethical Hacking & Penetration Testing Basics',
    'Risk Assessment & Vulnerability Management',
    'Cryptography & Secure Communication',
    'Security Policy & Incident Response',
  ],

  skillsRequired: [
    'Networking',
    'Problem-Solving',
    'Analytical Thinking',
    'Attention to Detail',
    'Scripting',
  ],

  targetTechnologies: [
    'Wireshark',
    'Linux',
    'Nmap',
    'Metasploit',
    'Python',
    'Firewalls',
  ],

  careerPaths: [
    {
      'title': 'Security Analyst',
      'desc':
          'Monitors systems and networks for threats and breaches.',
    },
    {
      'title': 'Penetration Tester',
      'desc':
          'Simulates attacks to find and fix security weaknesses.',
    },
    {
      'title': 'Network Security Engineer',
      'desc':
          'Designs and maintains secure network infrastructure.',
    },
    {
      'title': 'SOC Analyst',
      'desc':
          'Works in a Security Operations Center monitoring live threats.',
    },
  ],

  isItForMe:
      'You may enjoy Cybersecurity if you like solving puzzles, thinking like an attacker to defend systems, and staying sharp on the latest digital threats.',

  expectText:
      'Networking • Scripting • Threat Analysis • Continuous practice with security tools',

  sampleSubjects: [
    'Information Assurance and Security',
    'Networking Fundamentals',
    'Ethical Hacking',
    'Systems Administration',
  ],

  // ----------------------------------------------------------
  // SAMPLE PROJECTS
  // ----------------------------------------------------------

  sampleProjects: [
    SampleProject(
      title: 'Campus Network Security Assessment',
      description:
          'A controlled security assessment project that identifies common vulnerabilities and recommends improvements for a campus network.',
      mediaType: 'image',
      technologies: [
        'Linux',
        'Nmap',
        'Wireshark',
        'Kali Linux',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Phishing Awareness & Detection System',
      description:
          'An educational security project designed to help users recognize suspicious messages, links, and phishing attempts.',
      mediaType: 'image',
      technologies: [
        'Python',
        'Machine Learning',
        'HTML',
        'JavaScript',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Secure Student Information Portal',
      description:
          'A prototype student portal demonstrating authentication, access control, password security, and secure data handling.',
      mediaType: 'video',
      technologies: [
        'PHP',
        'MySQL',
        'JavaScript',
        'Encryption',
      ],
      githubUrl: '',
      demoUrl: '',
    ),
  ],
);


// ============================================================
// PROFESSIONAL ELECTIVE / AIoT
// ============================================================

final Specialization aiotSpec = Specialization(
  title: 'Professional Elective / AIoT',
  subtitle: 'Bridging embedded devices and artificial intelligence.',
  icon: Icons.bolt,

  whatIsIt:
      'AIoT combines Artificial Intelligence and the Internet of Things, focusing on smart, connected devices that can sense, process, and act on data. You will learn embedded systems, sensor integration, and applied machine learning.',

  whatWillILearn: [
    'Embedded Systems & Microcontroller Programming',
    'Sensor & Actuator Integration',
    'Applied Machine Learning on Edge Devices',
    'IoT Communication Protocols',
    'Data Collection & Real-Time Processing',
  ],

  skillsRequired: [
    'Programming',
    'Electronics Basics',
    'Problem-Solving',
    'Data Analysis',
    'Systems Thinking',
  ],

  targetTechnologies: [
    'Python',
    'Arduino',
    'Raspberry Pi',
    'TensorFlow Lite',
    'MQTT',
    'C++',
  ],

  careerPaths: [
    {
      'title': 'IoT Developer',
      'desc':
          'Builds connected device systems and embedded applications.',
    },
    {
      'title': 'AI/ML Engineer',
      'desc':
          'Designs and deploys machine learning models, including on-device.',
    },
    {
      'title': 'Embedded Systems Engineer',
      'desc':
          'Works on hardware-software integration for smart devices.',
    },
    {
      'title': 'Automation Engineer',
      'desc':
          'Builds smart automation and monitoring solutions.',
    },
  ],

  isItForMe:
      'You may enjoy AIoT if you like combining hardware and software, experimenting with sensors and smart devices, and applying AI in the physical world.',

  expectText:
      'Programming • Hardware Experimentation • Data Modeling • Continuous practice with embedded tools',

  sampleSubjects: [
    'Internet of Things',
    'Embedded Systems',
    'Machine Learning Fundamentals',
    'Data Analytics',
  ],

  // ----------------------------------------------------------
  // SAMPLE PROJECTS
  // ----------------------------------------------------------

  sampleProjects: [
    SampleProject(
      title: 'Smart Classroom Monitoring System',
      description:
          'An IoT-based classroom system that monitors environmental conditions such as temperature, humidity, and room activity.',
      mediaType: 'image',
      technologies: [
        'Arduino',
        'ESP32',
        'IoT Sensors',
        'MQTT',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'AI-Based Plant Monitoring System',
      description:
          'A smart agriculture prototype that collects plant and environmental data and uses intelligent analysis to support plant care.',
      mediaType: 'image',
      technologies: [
        'Raspberry Pi',
        'Python',
        'Machine Learning',
        'IoT Sensors',
      ],
      githubUrl: '',
      demoUrl: '',
    ),

    SampleProject(
      title: 'Smart Energy Monitoring System',
      description:
          'A connected device system that monitors electricity usage and provides data that can be analyzed for energy-saving opportunities.',
      mediaType: 'video',
      technologies: [
        'ESP32',
        'Python',
        'MQTT',
        'IoT',
      ],
      githubUrl: '',
      demoUrl: '',
    ),
  ],
);