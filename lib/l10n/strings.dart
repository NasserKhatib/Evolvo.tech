class AppStrings {
  final bool isAr;
  const AppStrings(this.isAr);

  // ── App Bar ───────────────────────────────────────────────────────────────
  String get navHome => isAr ? 'الرئيسية' : 'Home';
  String get navAbout => isAr ? 'من نحن' : 'About';
  String get navServices => isAr ? 'خدماتنا' : 'Services';
  String get navPortfolio => isAr ? 'أعمالنا' : 'Portfolio';
  String get navContact => isAr ? 'تواصل' : 'Contact';
  String get bookCall => isAr ? 'احجز مكالمة' : 'Book a Call';

  // ── Hero ──────────────────────────────────────────────────────────────────
  List<String> get heroWords => isAr
      ? ['طوّر ', 'إلى ', 'المستوى ', 'التالي']
      : ['EVOLVE ', 'TO ', 'THE ', 'NEXT ', 'LEVEL'];
  String get btnServices => isAr ? 'خدماتنا' : 'Our Services';
  String get btnWork => isAr ? 'أعمالنا' : 'See Our Work';

  // ── About ─────────────────────────────────────────────────────────────────
  String get aboutTitle => isAr ? 'من نحن' : 'About Us';
  String get statsProjects => isAr ? 'مشروع' : 'PROJECTS';
  String get statsClients => isAr ? 'عميل' : 'CLIENTS';
  String get statsYears => isAr ? 'سنة' : 'YEARS';
  String get aboutP1 => isAr
      ? 'تقوم شركة إيفولفو للتكنولوجيا بتصميم وتنفيذ أنظمة برمجية باستخدام أحدث التقنيات، مما يساعد العملاء والمنظمات على تحسين الأداء وتنظيم العمل. نسعى إلى تعزيز معارفنا ومهاراتنا القيادية لإيجاد تآزر بين فريقنا وعملائنا. نؤمن بإمكانياتنا ونسعى إلى تحقيق التميز.'
      : 'Evolvo Technology designs and implements software systems using modern technologies, helping customers and organizations improve performance and organize work. We strive to enhance our knowledge and leadership skills to create synergies between our team and customers. We believe in our potential and want to achieve greatness.';
  String get aboutP2 => isAr
      ? 'مهمتنا هي خلق قيمة اقتصادية من خلال التكنولوجيا. من خلال دفع حدود الابتكار باستمرار، نهدف إلى تقديم حلول مؤثرة ومستدامة تدفع الأعمال إلى الأمام.'
      : 'Our mission is to create economic value through technology. By continuously pushing the boundaries of innovation, we aim to deliver impactful and sustainable solutions that propel businesses forward.';
  String get ourTeam => isAr ? 'فريقنا' : 'Our Team';

  // ── Services ──────────────────────────────────────────────────────────────
  String get servicesTitle => isAr ? 'خدماتنا' : 'Services';
  String get sWebDev => isAr ? 'تطوير الويب' : 'Web Development';
  String get sWebDevDesc => isAr
      ? 'نبني تطبيقات ويب حديثة ومتجاوبة مصممة خصيصاً لاحتياجات عملك.'
      : 'We build responsive and modern web applications tailored to your business needs.';
  String get sMobile => isAr ? 'تطبيقات الجوال' : 'Mobile Apps';
  String get sMobileDesc => isAr
      ? 'نطور تطبيقات جوال عالية الأداء ومتعددة المنصات لأنظمة iOS وAndroid.'
      : 'We create high-performance cross-platform mobile apps for iOS and Android.';
  String get sUiUx => isAr ? 'تصميم واجهات المستخدم' : 'UI/UX Design';
  String get sUiUxDesc => isAr
      ? 'نصمم واجهات مستخدم بديهية وسهلة الاستخدام تبهج المستخدمين.'
      : 'We design intuitive and user-friendly interfaces that delight users.';
  String get sGame => isAr ? 'تطوير الألعاب' : 'Game Development';
  String get sGameDesc => isAr
      ? 'نطور ألعاباً غامرة ثنائية وثلاثية الأبعاد لمنصات متعددة، بما فيها AR وVR والإنتاج الافتراضي.'
      : 'We create immersive 2D/3D games for various platforms, including AR, VR, and virtual production.';
  String get sAi => isAr ? 'الذكاء الاصطناعي' : 'Artificial Intelligence';
  String get sAiDesc => isAr
      ? 'نطور أنظمة ذكية وحلول تعلم آلي لأتمتة وتعزيز الأداء.'
      : 'We develop intelligent systems and machine learning solutions to automate and enhance performance.';
  String get sEmbedded => isAr ? 'الأنظمة المدمجة' : 'Embedded Systems';
  String get sEmbeddedDesc => isAr
      ? 'نمكّن المهندسين والمطورين من إحداث ثورة في النماذج الأولية للأجهزة والإلكترونيات.'
      : 'We empower engineers and makers to revolutionize hardware prototyping and electronics.';

  // ── Portfolio ─────────────────────────────────────────────────────────────
  String get portfolioTitle => isAr ? 'أعمالنا' : 'Portfolio';
  String get viewDetails => isAr ? 'عرض التفاصيل' : 'View Details';
  String get viewAllProjects => isAr ? 'عرض جميع المشاريع' : 'View All Projects';
  String get ourProjects => isAr ? 'مشاريعنا' : 'Our Projects';
  String get availableOn => isAr ? 'متاح على' : 'AVAILABLE ON';

  // IMN
  String get imnCategory => isAr ? 'شبكة اجتماعية' : 'Social Network';
  String get imnDetails => isAr
      ? 'منصة مبنية على الاحترام والمجتمع، حيث تُلهمك موجزتك وتكون تفاعلاتك ذات معنى وتعليمية.'
      : 'A place built on respect and community, where your feed uplifts you, your interactions are meaningful, and your time is educational.';
  String get imnDescription => isAr
      ? 'IMN هو تطبيق شبكة اجتماعية يعزز الإيجابية عبر إزالة التعليقات السلبية. يتيح للمستخدمين التواصل والتعلم والكسب من خلال ميزة الكلية المدمجة، مما يحوّل التعليم إلى تجربة مجزية.'
      : 'IMN is a social network app that promotes positivity by removing negative feedback. It enables users to connect, learn, and earn through an integrated college feature, turning education into a rewarding experience.';

  // Foodora
  String get foodoraCategory => isAr ? 'توصيل طعام' : 'Food Delivery';
  String get foodoraDetails => isAr
      ? 'منصة لتوصيل الطعام تربط الشركات المحلية بالسائقين الماهرين لتوصيل وجبات سريعة وبأسعار معقولة.'
      : 'A platform for food delivery that connects local businesses and skilled riders to deliver fast, affordable meals.';
  String get foodoraDescription => isAr
      ? 'فودورا هي منصة توصيل طعام تربط الشركات المحلية والسائقين الماهرين وفريقاً متخصصاً لتوصيل وجبات سريعة وميسورة التكلفة وعالية الجودة. تمكّن المجتمعات من توفير وقت ثمين وتعزيز تجربتهم اليومية.'
      : 'Foodora is a food delivery platform that connects local businesses, skilled riders, and a dedicated team to deliver fast, affordable, and quality meals. It empowers communities by saving valuable time and enhancing everyday experiences.';

  // Outer Paradise
  String get outerParadiseCategory => isAr ? 'تطوير ألعاب' : 'Game Development';
  String get outerParadiseDetails => isAr
      ? 'حيث تُجسَّد أفكار ألعابك بإبداع ودقة عالية.'
      : 'Where your game ideas are brought to life with creativity and precision.';
  String get outerParadiseDescription => isAr
      ? 'من خلال شراكتنا مع Outer Paradise، حققنا جودة استثنائية في اللعب والرسومات. سواء كان لديك مشروع ثنائي أو ثلاثي الأبعاد، أو XR، أو إنتاج افتراضي، يمكنك الاعتماد على تعاوننا لتقديم تجربة عالية الجودة.'
      : 'Through our partnership with Outer Paradise, we have achieved exceptional quality in both gameplay and graphics. Whether you have a 2D, 3D, XR, or virtual production project in mind, you can count on our collaboration to deliver a high-quality experience.';

  // ── Contact ───────────────────────────────────────────────────────────────
  String get contactTitle => isAr ? 'تواصل معنا' : 'Get In Touch';
  String get contactSubtitle => isAr
      ? 'هل أنت مستعد لتحويل أفكارك إلى واقع؟ تواصل معنا ولنبني شيئاً رائعاً معاً.'
      : "Ready to bring your ideas to life? Reach out to us and let's build something amazing together.";
  String get contactBtn => isAr ? 'تواصل عبر واتساب' : 'Contact Us on WhatsApp';
}
