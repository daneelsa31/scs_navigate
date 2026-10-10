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
      'Web Development focuses on creating websites and web applications that people can use through a browser. You will learn how to build the visible parts of a website, handle user input, work with databases, and create the behind-the-scenes code that makes web applications work.',

  whatWillILearn: [
    'Build responsive websites using HTML, CSS, and JavaScript.',
    'Process forms and user input using server-side programming.',
    'Connect web applications to databases such as MySQL.',
    'Organize code using Object-Oriented Programming.',
    'Build larger web applications using frameworks such as Laravel.',
    'Apply basic security and good coding practices.',
  ],

  skillsRequired: [
    'HTML, CSS, and JavaScript Basics',
    'Programming Fundamentals',
    'Basic Object-Oriented Programming',
    'Basic Database Knowledge',
    'Problem-Solving and Debugging',
  ],

  targetTechnologies: [
    'HTML',
    'CSS',
    'JavaScript',
    'PHP',
    'MySQL',
    'Laravel',
    'Apache / Nginx',
  ],

  careerPaths: [
    {
      'title': 'Web Developer',

      'desc': 'Builds and maintains websites and web applications.',
    },

    {
      'title': 'Front-End Developer',

      'desc': 'Builds the parts of websites that users see and interact with.',
    },

    {
      'title': 'Back-End Developer',

      'desc':
          'Builds the behind-the-scenes logic and database features of web applications.',
    },

    {
      'title': 'Full-Stack Developer',

      'desc':
          'Works on both the user interface and the server/database side of a web application.',
    },
  ],

  isItForMe:
      'You may enjoy Web Development if you like creating websites, working with both design and programming, and turning ideas into systems that people can access through a browser.',

  expectText:
      'Expect frequent coding, debugging, and project work as you learn how websites connect to servers and databases.',

  sampleSubjects: [
    'Web Systems and Technologies',

    'Database Systems',

    'Client-Side Scripting',

    'Server-Side Programming',
  ],

  // Replace this with the official Web Development presentation link.
  presentationUrl:
      'https://drive.google.com/file/d/1Aq6G4fEfFZXlCAMQoZhKX0Mx_3_OVIVX/view?usp=sharing',

  // ----------------------------------------------------------

  // SAMPLE PROJECTS

  // ----------------------------------------------------------
  sampleProjects: [
    SampleProject(
      title: 'SCS Campus Event & Facility Booking Portal',

      description:
          'A web-based campus portal for viewing events, checking facility availability, and submitting reservation requests.',

      mediaType: 'image',

      technologies: ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Student Academic Portfolio & Project Showcase',

      description:
          'A responsive platform where students can showcase their projects, skills, achievements, and technical portfolios.',

      mediaType: 'image',

      technologies: ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Online Student Organization Management System',

      description:
          'A centralized web application for managing organization members, announcements, activities, and event registrations.',

      mediaType: 'video',

      technologies: ['PHP', 'MySQL', 'JavaScript', 'Laravel'],

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

  subtitle: 'Build cross-platform applications with Flutter.',

  icon: Icons.phone_android,

  whatIsIt:
      'Mobile Development focuses on creating applications for phones and other devices using Flutter. You will learn how to design app screens, manage app data, connect apps to online services, and gradually build more advanced mobile applications.',

  whatWillILearn: [
    'Build cross-platform applications using Flutter and Dart.',
    'Design responsive and user-friendly app screens.',
    'Manage app data and movement between screens.',
    'Connect apps to APIs, databases, and login services.',
    'Add features such as maps, file storage, and real-time data.',
    'Test and organize larger applications properly.',
    'Explore advanced features such as AI and machine learning.',
    'Prepare a complete application for deployment.',
  ],

  skillsRequired: [
    'Basic Programming',
    'Problem-Solving',
    'Basic Understanding of User Interfaces',
    'Testing and Debugging',
    'Patience When Learning New Tools',
  ],

  targetTechnologies: [
    'Flutter',
    'Dart',
    'Git & GitHub',
    'Supabase',
    'REST APIs',
    'Mapbox',
    'Firebase',
    'TensorFlow Lite',
  ],

  careerPaths: [
    {
      'title': 'Mobile App Developer',

      'desc': 'Builds applications for phones and other devices.',
    },

    {
      'title': 'Flutter Developer',

      'desc': 'Builds cross-platform applications using Flutter.',
    },

    {
      'title': 'Cross-Platform Developer',

      'desc': 'Builds applications that can run on more than one platform.',
    },

    {
      'title': 'Software Developer',

      'desc':
          'Builds and maintains software applications, including mobile solutions.',
    },
  ],

  isItForMe:
      'You may enjoy Mobile Development if you like creating apps that people can use directly on their phones and enjoy combining programming with interface design.',

  expectText:
      'Expect frequent Flutter and Dart coding, screen design, testing, debugging, and project work that becomes more advanced over time.',

  sampleSubjects: [
    'Mobile Application Development',

    'Human-Computer Interaction',

    'Database Systems',

    'Application Deployment',
  ],

  // Replace this with the official Mobile Development presentation link.
  presentationUrl: 'https://ahdzlee.github.io/usjr-mobile-cybsec-track/',

  // ----------------------------------------------------------

  // SAMPLE PROJECTS

  // ----------------------------------------------------------
  sampleProjects: [
    SampleProject(
      title: 'SCS Navigate Mobile App',

      description:
          'A student-focused mobile application that helps SCS students discover academic pathways, opportunities, events, and useful resources.',

      mediaType: 'image',

      technologies: ['Flutter', 'Dart', 'Supabase'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Campus Announcement & Bulletin App',

      description:
          'A mobile application for viewing campus announcements, student notices, and categorized updates in one place.',

      mediaType: 'image',

      technologies: ['Flutter', 'Dart', 'Supabase'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Student Expense Tracker',

      description:
          'A mobile budgeting application that helps students record expenses, organize spending categories, and monitor their budget.',

      mediaType: 'video',

      technologies: ['Flutter', 'Dart', 'Firebase'],

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

  subtitle: 'Understand attacks. Find weaknesses. Protect systems.',

  icon: Icons.security,

  whatIsIt:
      'Cybersecurity focuses on understanding how computer systems and networks can be attacked and how they can be protected. You will practice finding weaknesses, monitoring suspicious activity, securing systems, and responding to security incidents in controlled environments.',

  whatWillILearn: [
    'Understand common attacks against systems, networks, and applications.',
    'Find security weaknesses in controlled laboratory environments.',
    'Monitor and protect computer systems and networks.',
    'Investigate suspicious activity and security incidents.',
    'Analyze network traffic and system activity.',
    'Learn basic digital forensics and incident response.',
    'Recommend ways to improve system security.',
    'Document and clearly explain security findings.',
  ],

  skillsRequired: [
    'Basic Networking Knowledge',
    'Basic Linux Knowledge',
    'Programming or Scripting Fundamentals',
    'Problem-Solving',
    'Attention to Detail',
    'Patience With Troubleshooting',
  ],

  targetTechnologies: [
    'Linux',
    'Kali Linux',
    'Nmap',
    'Wireshark',
    'Burp Suite',
    'Metasploit',
  ],

  careerPaths: [
    {
      'title': 'Security Analyst',

      'desc':
          'Monitors systems and networks for suspicious activity and security problems.',
    },

    {
      'title': 'Penetration Tester',

      'desc':
          'Tests systems in authorized environments to find security weaknesses.',
    },

    {
      'title': 'Network Security Engineer',

      'desc':
          'Helps design and maintain networks that are protected against attacks.',
    },

    {
      'title': 'SOC Analyst',

      'desc': 'Monitors alerts and investigates possible security incidents.',
    },
  ],

  isItForMe:
      'You may enjoy Cybersecurity if you are curious about how systems work, like investigating problems, and want to understand both how attacks happen and how they can be prevented.',

  expectText:
      'Expect hands-on labs, troubleshooting, security tools, investigation, and written findings that explain what happened and how to improve security.',

  sampleSubjects: [
    'Information Assurance and Security',

    'Networking Fundamentals',

    'Ethical Hacking',

    'Systems Administration',
  ],

  // Replace this with the official Cybersecurity presentation link.
  presentationUrl: 'https://ahdzlee.github.io/usjr-mobile-cybsec-track/',

  // ----------------------------------------------------------

  // SAMPLE PROJECTS

  // ----------------------------------------------------------
  sampleProjects: [
    SampleProject(
      title: 'Campus Network Security Assessment',

      description:
          'A controlled security assessment project that identifies common vulnerabilities and recommends improvements for a campus network.',

      mediaType: 'image',

      technologies: ['Linux', 'Nmap', 'Wireshark', 'Kali Linux'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Phishing Awareness & Detection System',

      description:
          'An educational security project designed to help users recognize suspicious messages, links, and phishing attempts.',

      mediaType: 'image',

      technologies: ['Python', 'Machine Learning', 'HTML', 'JavaScript'],

      githubUrl: '',

      demoUrl: '',
    ),

    SampleProject(
      title: 'Secure Student Information Portal',

      description:
          'A prototype student portal demonstrating authentication, access control, password security, and secure data handling.',

      mediaType: 'video',

      technologies: ['PHP', 'MySQL', 'JavaScript', 'Encryption'],

      githubUrl: '',

      demoUrl: '',
    ),
  ],
);
