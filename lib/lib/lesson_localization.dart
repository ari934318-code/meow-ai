import 'package:flutter/material.dart';

class LessonLocalization {
  final Locale locale;

  LessonLocalization(this.locale);

  bool get isPersian => locale.languageCode == 'fa';

  String lessonTitle(String id, String fallback) {
    if (!isPersian) return fallback;

    switch (id) {
      case 'a1_01':
        return 'سلام و احوالپرسی';
      case 'a1_02':
        return 'معرفی خودت';
      case 'a1_03':
        return 'اعداد و سن';
      case 'a1_04':
        return 'کشورها و ملیت‌ها';
      case 'a1_05':
        return 'خانواده';
      case 'a1_06':
        return 'روتین روزانه';
      case 'a1_07':
        return 'غذا و نوشیدنی';
      case 'a1_08':
        return 'علاقه‌ها و چیزهایی که دوست نداریم';
      case 'a1_09':
        return 'خانه و اتاق‌ها';
      case 'a1_10':
        return 'زمان و تاریخ';
      case 'a1_11':
        return 'مکالمه‌های روزمره';
      case 'a1_12':
        return 'مرور A1';
      default:
        return fallback;
    }
  }

  String lessonDescription(String id, String fallback) {
    if (!isPersian) return fallback;

    switch (id) {
      case 'a1_01':
        return 'سلام کردن، خداحافظی، معرفی و مکالمه‌های ساده روزمره را یاد بگیر.';
      case 'a1_02':
        return 'یاد بگیر چطور خودت را معرفی کنی و درباره اطلاعات شخصی پایه صحبت کنی.';
      case 'a1_03':
        return 'اعداد، سن و سؤال‌های ساده درباره اعداد را یاد بگیر.';
      case 'a1_04':
        return 'درباره کشورها، ملیت‌ها و اینکه اهل کجا هستی صحبت کن.';
      case 'a1_05':
        return 'کلمات رایج مربوط به خانواده را یاد بگیر و درباره اعضای خانواده صحبت کن.';
      case 'a1_06':
        return 'درباره روتین روزانه و کارهای معمول هر روز صحبت کن.';
      case 'a1_07':
        return 'کلمات رایج غذا و نوشیدنی را یاد بگیر و چیزهای ساده سفارش بده.';
      case 'a1_08':
        return 'یاد بگیر چطور درباره چیزهایی که دوست داری یا دوست نداری صحبت کنی.';
      case 'a1_09':
        return 'کلمات مربوط به اتاق‌ها، وسایل خانه و چیزهای معمول داخل خانه را یاد بگیر.';
      case 'a1_10':
        return 'یاد بگیر چطور درباره ساعت، روزها، تاریخ‌ها و برنامه‌های ساده صحبت کنی.';
      case 'a1_11':
        return 'مکالمه‌های ساده و کاربردی برای موقعیت‌های روزمره را تمرین کن.';
      case 'a1_12':
        return 'واژگان، عبارت‌ها، گرامر و مکالمه‌های مسیر کامل A1 را مرور کن.';
      default:
        return fallback;
    }
  }

  String sectionTitle(String title) {
    if (!isPersian) return title;

    switch (title) {
      case 'Vocabulary':
      case 'Numbers':
      case 'Vocabulary Review':
        return 'واژگان';

      case 'Useful Phrases':
        return 'عبارت‌های کاربردی';

      case 'Grammar':
      case 'Grammar Review':
        return 'گرامر';

      case 'Real-Life Examples':
        return 'مثال‌های واقعی';

      case 'Common Mistakes':
        return 'اشتباهات رایج';

      case 'Practice':
      case 'Final Practice':
        return 'تمرین';

      case 'Mini Conversation':
        return 'مکالمه کوتاه';

      case 'Speaking':
        return 'مکالمه و صحبت کردن';

      case 'Review':
        return 'مرور';

      case 'At a Café':
        return 'در کافه';

      case 'Meeting Someone':
        return 'آشنا شدن با یک نفر';

      default:
        return title;
    }
  }

  String sectionExplanation(String text) {
    if (!isPersian) return text;

    switch (text) {
      case 'Learn the most useful words for greeting people in everyday English.':
        return 'مفیدترین کلمات برای سلام و احوالپرسی در انگلیسی روزمره را یاد بگیر.';

      case 'These are common phrases you can actually use when meeting people.':
        return 'این‌ها عبارت‌های رایجی هستند که واقعاً هنگام آشنا شدن با افراد می‌توانی استفاده کنی.';

      case 'Use “I’m” as the short form of “I am”. It is one of the most common structures in English.':
        return 'از “I’m” به‌عنوان شکل کوتاه “I am” استفاده می‌شود. این یکی از رایج‌ترین ساختارهای انگلیسی است.';

      case 'See how these expressions work in normal conversations.':
        return 'ببین این عبارت‌ها چطور در مکالمه‌های معمولی استفاده می‌شوند.';

      case 'A few small mistakes can make your English sound unnatural.':
        return 'چند اشتباه کوچک می‌توانند باعث شوند انگلیسی‌ات غیرطبیعی به نظر برسد.';

      case 'Choose the correct phrase, complete sentences and build your own answers.':
        return 'عبارت درست را انتخاب کن، جمله‌ها را کامل کن و جواب‌های خودت را بساز.';

      case 'Practice a short conversation with Meow. Later, this section will use AI and voice recognition.':
        return 'یک مکالمه کوتاه با میو تمرین کن. بعداً این بخش از هوش مصنوعی و تشخیص صدا استفاده خواهد کرد.';

      case 'Review the important words and phrases before finishing the lesson.':
        return 'قبل از تمام کردن درس، کلمات و عبارت‌های مهم را مرور کن.';

      case 'Use “I am” or “I’m” to give basic information about yourself.':
        return 'برای گفتن اطلاعات پایه درباره خودت از “I am” یا “I’m” استفاده کن.';

      case 'Use “I am” with age in English, not “I have”.':
        return 'در انگلیسی برای گفتن سن از “I am” استفاده می‌کنیم، نه “I have”.';

      case 'Use the present simple to talk about routines and things you do regularly.':
        return 'برای صحبت درباره روتین‌ها و کارهایی که مرتب انجام می‌دهی از زمان حال ساده استفاده کن.';

      case 'Use “like” with things you enjoy. Use “don’t like” for things you dislike.':
        return 'برای چیزهایی که دوست داری از “like” و برای چیزهایی که دوست نداری از “don’t like” استفاده کن.';

      case 'Review the basic sentence patterns used throughout A1.':
        return 'ساختارهای پایه جمله را که در طول سطح A1 استفاده کردی مرور کن.';

      case 'A mixed review of vocabulary, grammar, translation and real-life situations.':
        return 'مروری ترکیبی بر واژگان، گرامر، ترجمه و موقعیت‌های واقعی روزمره.';
      
      case 'Use everything you learned in A1 to have a short conversation.':
        return 'از چیزهایی که در A1 یاد گرفتی برای داشتن یک مکالمه کوتاه استفاده کن.';

      case 'Introduce yourself to Meow using your name, age and where you are from.':
        return 'با گفتن نام، سن و محل زندگی یا کشورت، خودت را برای میو معرفی کن.';

      default:
        return text;
    }
  }

  String itemPersian(String english, String fallback) {
    return fallback;
  }

  String exampleLabel(String example) {
    if (!isPersian) {
      return 'Example: $example';
    }

    return 'مثال: $example';
  }
}