class StudentInsight {
  final String quote;
  final String author;

  const StudentInsight({
    required this.quote,
    required this.author,
  });
}

// SAMPLE PLACEHOLDERS ONLY.
// Replace these with verified SCS student insights before publishing.
List<StudentInsight> studentInsightsFor(String specializationTitle) {
  final title = specializationTitle.toLowerCase();

  if (title.contains('web')) {
    return const [
      StudentInsight(
        quote:
            'I wish I had practiced connecting the frontend to a database earlier. Once I understood how the whole flow worked, the projects became much easier to understand.',
        author: '— Sample: 4th Year BSIT, Web Development',
      ),
      StudentInsight(
        quote:
            'Do not focus only on making the page look good. Learn how data moves from the form to the backend and database because that is where many of the harder tasks come from.',
        author: '— Sample: SCS Senior, Web Development',
      ),
      StudentInsight(
        quote:
            'Small personal projects helped me more than memorizing syntax. Build something simple, break it, fix it, and keep improving it.',
        author: '— Sample: SCS Senior, Web Development',
      ),
    ];
  }

  if (title.contains('mobile')) {
    return const [
      StudentInsight(
        quote:
            'I wish I had become comfortable with state management and APIs earlier. Those two things appear in many app features once projects become more complex.',
        author: '— Sample: 4th Year BSIT, Mobile Development',
      ),
      StudentInsight(
        quote:
            'Test your app on different screen sizes from the beginning. Fixing responsiveness at the very end can take more time than expected.',
        author: '— Sample: SCS Senior, Mobile Development',
      ),
      StudentInsight(
        quote:
            'Do not be afraid to build small apps before the major projects. Even a simple login, notes, or maps app can teach you a lot about how Flutter projects are structured.',
        author: '— Sample: SCS Senior, Mobile Development',
      ),
    ];
  }

  if (title.contains('cyber')) {
    return const [
      StudentInsight(
        quote:
            'Networking and Linux fundamentals matter a lot. Security tools make more sense when you understand what the system and network are doing underneath.',
        author: '— Sample: 4th Year BSIT, Cybersecurity',
      ),
      StudentInsight(
        quote:
            'Take notes during labs. The command is only one part of the activity; being able to explain the result and why it matters is just as important.',
        author: '— Sample: SCS Senior, Cybersecurity',
      ),
      StudentInsight(
        quote:
            'Expect troubleshooting. Sometimes the hardest part is not the security concept itself but getting the lab environment, permissions, or network configuration to work correctly.',
        author: '— Sample: SCS Senior, Cybersecurity',
      ),
    ];
  }

  return const [
    StudentInsight(
      quote:
          'Start building small projects early so you can discover which parts of the specialization you enjoy most.',
      author: '— Sample SCS Senior',
    ),
    StudentInsight(
      quote:
          'Ask seniors about their project experience and the tools they actually used. It can help you prepare before the major subjects begin.',
      author: '— Sample SCS Senior',
    ),
  ];
}
