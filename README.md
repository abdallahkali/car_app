# تطبيق معرض السيارات (Flutter)

> يحتاج Flutter 3.27 أو أحدث.

## التشغيل
```bash
flutter create --org com.yourcompany --project-name car_showroom .
flutter pub get
flutter run
```
> أمر `flutter create .` بيولّد فولدرات android/ios ومش هيمسح كود lib.

## إعدادات مطلوبة لفتح الاتصال/واتساب (url_launcher)
**Android** — في `android/app/src/main/AndroidManifest.xml` قبل `<application>`:
```xml
<queries>
  <intent><action android:name="android.intent.action.VIEW"/><data android:scheme="https"/></intent>
  <intent><action android:name="android.intent.action.DIAL"/><data android:scheme="tel"/></intent>
</queries>
```
**iOS** — في `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array><string>tel</string><string>https</string></array>
```

## الميزات
- ثيم داكن/فاتح بتدرجات عصرية (زر تبديل في الرئيسية وصفحة المعرض)
- حاسبة تقسيط (مقدم / مدة / فائدة) مع ربط بأي سيارة
- مقارنة حتى 3 سيارات مع إبراز الأفضل في كل بند
- إضافة سيارة جديدة (من الرئيسية أو صفحة المعرض) مع كتالوج 30 ماركة وموديلاتها
- عرض قائمة أو شبكة، فلاتر وترتيب، شاهدتها مؤخرًا، مفضلة، حجز تجربة قيادة

## المعمارية
```
lib/
 core/       theme, constants, format
 models/     Car, Booking, CarFilter
 data/       CarRepository (interface) + MockCarRepository + CarCatalog
 providers/  CarsProvider (بحث/فلاتر/ترتيب), FavoritesProvider
 screens/    splash, shell, home, browse, details, booking, favorites, more
 widgets/    CarCard, CarImage, FilterSheet, state views
```

## ربط الداتا لاحقًا
1. اعمل `lib/data/api_car_repository.dart` يـ implements `CarRepository` (استخدم `http` أو `dio` + `Car.fromJson`).
2. في `main.dart` بدّل `MockCarRepository()` بـ `ApiCarRepository()`.
3. الصور: املا `imageUrls` وهتظهر تلقائيًا بدل الـ placeholder.
