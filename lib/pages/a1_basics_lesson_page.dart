        return [
          // Basics 10 uses the complete structured teaching path first.
          // Practice starts only after the possessive-adjective concepts
          // have been taught. Speaking remains the final stage.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_basic_06':
      case 'a1_06_simple_wh':
      case 'lesson_6':
      case '6':
        return [
          _stage('Question Words', 'کلمه‌های پرسشی', [0, 1, 2, 3, 4]),
          _stage('To Be Questions', 'سؤال با To Be', [5, 6, 7, 8]),
          _stage('Present Simple Questions', 'سؤال با Present Simple', [9, 10, 11, 12]),
          _stage('Recognition and Word Order', 'تشخیص و ترتیب کلمات', [13, 14, 15]),
          _stage('Real-Life Practice', 'تمرین کاربردی', List.generate(_questions.length, (i) => i)),
          _speakingStage('Speaking', 'تمرین تلفظ و لهجه'),
        ];

      case 'a1_basic_13':
      case 'a1_13':
      case 'lesson_13':
      case '13':
        return [
          _stage('Will / Going to', 'Will / Going to', [0, 1, 2, 3, 4, 5]),
          _stage('Will: Positive, Negative, Questions', 'Will: مثبت، منفی و سؤال', [6, 7, 8, 9]),
          _stage('Going to: Positive, Negative, Questions', 'Going to: مثبت، منفی و سؤال', [10, 11, 12, 13]),
          _stage('Will vs Going to', 'فرق Will و Going to', [14, 15, 16, 17, 18, 19]),
          _stage('Guided Practice', 'تمرین هدایت‌شده', [20, 21, 22, 23, 24, 25]),
          _stage('Recognition and Word Order', 'تشخیص و مرتب‌سازی', [26, 27, 28, 29, 30, 31, 32, 33]),
          _stage('Real-Life Practice', 'تمرین کاربردی', List.generate(_questions.length, (i) => i)),
          _speakingStage('Speaking', 'تمرین تلفظ و لهجه'),
        ];

      case 'a1_basic_14':
      case 'a1_14':
      case 'lesson_14':
      case '14':
        return [
          _stage('Wh-words and Structure', 'کلمه‌های Wh و ساختار', [0, 1, 2, 3, 4, 5]),
          _stage('Structures and Examples', 'ساختارها و مثال‌ها', [6, 7, 8, 9, 10, 11]),
          _stage('Did and Who', 'Did و Who', [12, 13, 14, 15, 16, 17]),
          _stage('What + Noun and Translation', 'What + اسم و ترجمه', [18, 19, 20, 21, 22]),
          _stage('Guided Practice', 'تمرین هدایت‌شده', [23, 24, 25, 26, 27]),
          _stage('Real-Life Practice', 'تمرین کاربردی', List.generate(_questions.length, (i) => i)),
          _speakingStage('Speaking', 'تمرین تلفظ و لهجه'),
        ];

      case 'a1_12':
      case 'lesson_12':
      case '12':
        return [
          // Basics 12 follows the teaching order: structure first,
          // then guided/diagnostic practice, with Speaking always last.
          _stage('What Is the Present Continuous?', 'Present Continuous چیست؟', [0, 1, 2, 3, 4, 5]),
          _stage('Positive Sentences', 'جمله‌های مثبت', [6, 7, 8, 9]),
          _stage('Negative Sentences', 'جمله‌های منفی', [10]),
          _stage('Questions and Short Answers', 'سؤال‌ها و جواب‌های کوتاه', [11, 12, 13]),
          _stage('-ing Rules', 'قوانین -ing', [14]),
          _stage('Present Simple vs Present Continuous', 'Present Simple در برابر Present Continuous', [15, 16, 17, 18, 19, 20]),
          _stage('Translation Practice', 'تمرین ترجمه', [21, 22, 23, 24, 25]),
          _stage('Recognition and Word Order', 'تشخیص و مرتب‌سازی', [26, 27, 28, 29, 30, 31, 32, 33, 34, 35]),
          _stage('Real-Life Practice', 'تمرین کاربردی', List.generate(_questions.length, (i) => i)),
          _speakingStage('Speaking', 'تمرین تلفظ و لهجه'),
        ];
