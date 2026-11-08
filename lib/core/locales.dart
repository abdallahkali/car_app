import 'package:flutter/material.dart';

class AppLocale {
  final Locale locale;
  const AppLocale(this.locale);

  static const _ar = 'ar';
  static const _en = 'en';

  bool get isArabic => locale.languageCode == _ar;
  bool get isEnglish => locale.languageCode == _en;

  String _get(String ar, String en) => isArabic ? ar : en;

  String get appName => _get('معرضكم', 'Your Showroom');

  String get welcome => _get('أهلًا بك 👋', 'Welcome 👋');
  String get searchHint => _get('ابحث عن ماركة أو موديل...', 'Search brand or model...');
  String get specialOffer => _get('عرض خاص', 'Special Offer');
  String get installmentBanner => _get('قسّط سيارتك\nلحد 7 سنين', 'Finance Your Car\nUp to 7 Years');
  String get installmentSub => _get('مقدم من 10% وأقساط مريحة', 'Down payment from 10% with easy installments');
  String get calculateInstallment => _get('احسب قسطك', 'Calculate Installment');
  String get browseByType => _get('تصفح حسب النوع', 'Browse by Type');
  String get suv => _get('SUV', 'SUV');
  String get sedan => _get('سيدان', 'Sedan');
  String get electric => _get('كهربائية', 'Electric');
  String get brands => _get('الماركات', 'Brands');
  String get featuredCars => _get('سيارات مميزة', 'Featured Cars');
  String get recentlyViewed => _get('شاهدتها مؤخرًا', 'Recently Viewed');
  String get newArrivals => _get('وصل حديثًا', 'New Arrivals');
  String get viewAll => _get('عرض الكل', 'View All');

  String get home => _get('الرئيسية', 'Home');
  String get browse => _get('تصفح', 'Browse');
  String get finance => _get('التقسيط', 'Finance');
  String get favorites => _get('المفضلة', 'Favorites');
  String get more => _get('المعرض', 'Showroom');
  String get compare => _get('قارن', 'Compare');

  String get carsCount => _get('سيارة', 'cars');
  String get noResults => _get('مفيش نتائج مطابقة', 'No matching results');
  String get noResultsSub => _get('جرّب تغيّر البحث أو تمسح الفلاتر', 'Try changing search or clear filters');
  String get clearFilters => _get('مسح الفلاتر', 'Clear Filters');

  String get filterTitle => _get('تصفية النتائج', 'Filter Results');
  String get clearAll => _get('مسح الكل', 'Clear All');
  String get sortBy => _get('الترتيب', 'Sort By');
  String get condition => _get('الحالة', 'Condition');
  String get all => _get('الكل', 'All');
  String get newCar => _get('جديدة', 'New');
  String get used => _get('مستعملة', 'Used');
  String get brand => _get('الماركة', 'Brand');
  String get bodyType => _get('نوع الهيكل', 'Body Type');
  String get transmission => _get('ناقل الحركة', 'Transmission');
  String get auto => _get('أوتوماتيك', 'Automatic');
  String get manual => _get('مانيوال', 'Manual');
  String get fuelType => _get('نوع الوقود', 'Fuel Type');
  String get showResults => _get('عرض النتائج', 'Show Results');

  String get newest => _get('الأحدث', 'Newest');
  String get priceLow => _get('السعر: الأقل', 'Price: Low');
  String get priceHigh => _get('السعر: الأعلى', 'Price: High');
  String get leastMileage => _get('الأقل استخدامًا', 'Least Mileage');

  String get yearLabel => _get('سنة الصنع', 'Year');
  String get mileageLabel => _get('العداد', 'Mileage');
  String get zero => _get('زيرو', 'Zero');
  String get transmissionLabel => _get('ناقل الحركة', 'Transmission');
  String get fuelLabel => _get('الوقود', 'Fuel');
  String get power => _get('القوة', 'Power');
  String get horsepower => _get('حصان', 'HP');
  String get engine => _get('المحرك', 'Engine');
  String get electricEngine => _get('كهربائي', 'Electric');
  String get cc => _get('سي سي', 'cc');
  String get structure => _get('الهيكل', 'Body');
  String get color => _get('اللون', 'Color');
  String get specs => _get('المواصفات', 'Specifications');
  String get features => _get('المميزات', 'Features');
  String get description => _get('الوصف', 'Description');
  String get addToCompare => _get('أضف للمقارنة', 'Add to Compare');
  String get addedToCompare => _get('تمت الإضافة للمقارنة', 'Added to Compare');
  String get maxCompare => _get('تقدر تقارن 3 سيارات بحد أقصى', 'You can compare up to 3 cars');
  String get bookTestDrive => _get('احجز تجربة قيادة', 'Book Test Drive');

  String get noFavorites => _get('لسه ماضفتش أي سيارة', 'No cars added yet');
  String get noFavoritesSub => _get('اضغط على القلب في أي سيارة علشان تحفظها هنا', 'Tap the heart on any car to save it here');

  String get noCompare => _get('مفيش سيارات للمقارنة', 'No cars to compare');
  String get noCompareSub => _get('أضف 2 أو 3 سيارات من البحث', 'Add 2 or 3 cars from search');

  String get financeTitle => _get('حاسبة التقسيط', 'Installment Calculator');
  String get monthlyPayment => _get('القسط الشهري', 'Monthly Payment');
  String get forMonths => _get('شهر', 'months');
  String get carPrice => _get('سعر السيارة', 'Car Price');
  String get downPayment => _get('المقدم', 'Down Payment');
  String get duration => _get('المدة بالشهور', 'Duration (months)');
  String get financedAmount => _get('المبلغ الممول', 'Financed Amount');
  String get disclaimer => _get('⚠️ هذه الحسابات تقريبية وقد تختلف عن العرض الفعلي من البنك.', '⚠️ These calculations are approximate and may differ from the actual bank offer.');

  String get bookingTitle => _get('حجز تجربة قيادة', 'Book Test Drive');
  String get name => _get('الاسم', 'Name');
  String get phone => _get('رقم الموبايل', 'Phone Number');
  String get date => _get('التاريخ', 'Date');
  String get selectDate => _get('اختر التاريخ', 'Select Date');
  String get time => _get('الموعد', 'Time');
  String get notes => _get('ملاحظات (اختياري)', 'Notes (optional)');
  String get confirmBooking => _get('تأكيد الحجز', 'Confirm Booking');
  String get selectDateTime => _get('اختر التاريخ والموعد', 'Select date and time');
  String get bookingConfirmed => _get('تم تأكيد الحجز', 'Booking Confirmed');
  String get bookingSub => _get('هنكلمك قريب لتأكيد موعد تجربة', 'We will contact you soon to confirm your test drive');
  String get ok => _get('تمام', 'OK');
  String get error => _get('حصلت مشكلة، حاول مرة أخرى', 'Something went wrong, try again');

  String get addCar => _get('إضافة سيارة', 'Add Car');
  String get model => _get('الموديل', 'Model');
  String get yearMade => _get('سنة الصنع', 'Year');
  String get price => _get('السعر (جنيه)', 'Price (EGP)');
  String get mileage => _get('العداد (كم)', 'Mileage (km)');
  String get fuel => _get('نوع الوقود', 'Fuel Type');
  String get trans => _get('ناقل الحركة', 'Transmission');
  String get body => _get('نوع الهيكل', 'Body Type');
  String get col => _get('اللون', 'Color');
  String get powerLabel => _get('القوة (حصان)', 'Power (HP)');
  String get engineLabel => _get('المحرك (سي سي)', 'Engine (cc)');
  String get desc => _get('الوصف', 'Description');
  String get addCarBtn => _get('إضافة السيارة', 'Add Car');
  String get carAdded => _get('تمت إضافة السيارة بنجاح ✓', 'Car added successfully ✓');
  String get required => _get('هذا الحقل مطلوب', 'This field is required');

  String get darkMode => _get('الوضع الداكن', 'Dark Mode');
  String get addNewCar => _get('إضافة سيارة جديدة', 'Add New Car');
  String get addNewCarSub => _get('أضف سيارة للمعرض', 'Add a car to the showroom');
  String get address => _get('العنوان', 'Address');
  String get workHours => _get('مواعيد العمل', 'Working Hours');
  String get callUs => _get('اتصل بنا', 'Call Us');
  String get whatsapp => _get('واتساب', 'WhatsApp');
  String get whatsappSub => _get('تواصل معنا مباشرة', 'Chat with us directly');
  String get map => _get('الموقع على الخريطة', 'Location on Map');
  String get mapSub => _get('افتح في الخرائط', 'Open in Maps');
  String get version => _get('الإصدار', 'Version');
  String get linkError => _get('تعذّر فتح الرابط', 'Failed to open link');

  String get retry => _get('إعادة المحاولة', 'Retry');
  String get networkError => _get('تعذّر تحميل السيارات. تأكد من الاتصال وحاول مرة أخرى.', 'Failed to load cars. Check connection and try again.');

  String get splashSub => _get('سيارتك القادمة في انتظارك', 'Your next car is waiting');

  String get newBadge => _get('جديدة', 'New');
  String get usedBadge => _get('مستعملة', 'Used');

  String get currency => _get('جنيه', 'EGP');

  String get nameValidation => _get('اكتب اسمك الكامل', 'Enter your full name');
  String get phoneValidation => _get('اكتب رقم موبايل مصري صحيح', 'Enter a valid Egyptian phone number');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocale> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ar' || locale.languageCode == 'en';

  @override
  Future<AppLocale> load(Locale locale) => Future.value(AppLocale(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

extension AppLocaleX on BuildContext {
  AppLocale get l10n => Localizations.of<AppLocale>(this, AppLocale)!;
}
