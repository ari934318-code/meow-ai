/// فیلتر حریم خصوصی Meow.
///
/// وظیفه این کلاس این است که قبل از ورود یک جمله
/// به سیستم یادگیری عمومی Meow، اطلاعات شخصی احتمالی
/// را شناسایی و حذف یا ناشناس کند.
///
/// نکته:
/// این نسخه اولیه است.
/// بعداً می‌توانیم آن را با فیلترهای دقیق‌تر و
/// سیستم امنیتی قوی‌تر توسعه بدهیم.
class PrivacyFilter {
  const PrivacyFilter();

  /// بررسی می‌کند که آیا جمله احتمالاً شامل
  /// اطلاعات شخصی است یا نه.
  bool containsPersonalInformation(String text) {
    final value = text.toLowerCase();

    // ایمیل
    final emailPattern = RegExp(
      r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
    );

    if (emailPattern.hasMatch(value)) {
      return true;
    }

    // شماره تلفن ساده
    final phonePattern = RegExp(
      r'(\+?\d[\d\s\-]{7,}\d)',
    );

    if (phonePattern.hasMatch(value)) {
      return true;
    }

    // برخی عبارت‌هایی که معمولاً قبل از اطلاعات شخصی می‌آیند.
    final personalPatterns = [
      'my name is ',
      'i am ',
      'i\'m ',
      'من اسمم ',
      'اسم من ',
      'من ',
      'نام من ',
      'شماره من ',
      'ایمیل من ',
    ];

    for (final pattern in personalPatterns) {
      if (value.contains(pattern)) {
        return true;
      }
    }

    return false;
  }

  /// حذف اطلاعات شخصی احتمالی از جمله.
  ///
  /// اگر جمله شامل اطلاعات شخصی باشد،
  /// بخش مشکوک با [PERSONAL_DATA] جایگزین می‌شود.
  String sanitize(String text) {
    var result = text.trim();

    // حذف ایمیل
    result = result.replaceAll(
      RegExp(
        r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
      ),
      '[PERSONAL_DATA]',
    );

    // حذف شماره تلفن
    result = result.replaceAll(
      RegExp(r'(\+?\d[\d\s\-]{7,}\d)'),
      '[PERSONAL_DATA]',
    );

    // حذف الگوهای رایج معرفی نام در انگلیسی
    result = result.replaceAll(
      RegExp(
        r"\b(my name is|i am|i'm)\s+[a-zA-Z]+",
        caseSensitive: false,
      ),
      '[PERSONAL_DATA]',
    );

    // حذف الگوهای رایج معرفی نام در فارسی
    result = result.replaceAll(
      RegExp(
        r'(اسم من|نام من|من اسمم)\s+[^\s،,.!?]+',
      ),
      '[PERSONAL_DATA]',
    );

    return result.trim();
  }

  /// آماده‌سازی جمله برای ورود به سیستم یادگیری.
  ///
  /// اگر جمله کاملاً شخصی باشد، null برمی‌گرداند.
  String? prepareForLearning(String text) {
    final sanitized = sanitize(text);

    if (sanitized.isEmpty) {
      return null;
    }

    // اگر بعد از حذف اطلاعات شخصی چیز مفیدی باقی نمانده باشد،
    // اصلاً آن را وارد یادگیری عمومی نمی‌کنیم.
    if (sanitized == '[PERSONAL_DATA]') {
      return null;
    }

    return sanitized;
  }
}