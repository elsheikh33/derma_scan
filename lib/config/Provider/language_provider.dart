import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{
  int defLan = 1;

  LanguageProvider(){
    _loadLanguage();
  }

  void changeLan({required int lan}) async {
    print("Language changed to: $lan"); // Debugging line
    defLan = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("defLan", defLan);
  }


  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defLan = prefs.getInt("defLan") ?? 1;
    notifyListeners();
  }
  TextDirection get textDirection {
    return defLan == 0 ? TextDirection.rtl : TextDirection.ltr;
  }

  String getTexts(String txt) {
    if (defLan == 0) {
      return textsAr[txt] ?? txt;
    } else if (defLan == 1) {
      return textsEn[txt] ?? txt;
    }
    return txt;
  }

  Map<String, String> textsAr = {
    "Save" : "حفظ",
    "Edit":"تعديل",
    "english": "English",
    "catchLineHome": "بشرتك، علمنا",
    "arabic": "عربي",
    "phraseHome": "آلاف الأشخاص يستخدمون DermaScan\n                   للكشف عن البشرة",
    "signUp": "التسجيل",
    "accountCheckHome": "هل لديك حساب بالفعل؟",
    "logIn": "تسجيل الدخول",
    "createAcc": "أنشئ حسابك",
    "Username": "اسم المستخدم",
    "Email": "البريد الإلكتروني",
    "Password": "كلمة المرور",
    "Date of Birth": "تاريخ الميلاد",
    "Male": "ذكر",
    "Female": "أنثى",
    "Gender": "النوع",
    "errorM1": "خطأ: يرجى إدخال جميع المعلومات",
    "hi": "مرحبًا",
    "questionTitle": "يرجى الإجابة على الأسئلة التالية لمساعدتنا في تقديم تقرير دقيق!",
    "welcomeBack": "مرحبًا بعودتك!",
    "ContWithFaceBook": "المتابعة باستخدام فيسبوك",
    "ContWithGoogle": "المتابعة باستخدام جوجل",
    "ContWithMail": "أو تسجيل الدخول عبر البريد الإلكتروني",
    "noAccount": "ليس لديك حساب؟",
    "nearestLocation": "أقرب موقع لك",
    "loading": "جارى التحميل...",
    "mainTitle": "يمكننا أن نتعلم كيف تكشف بشرتنا عن قصتها اليومية، مما يساعدنا على التعرف على العلامات التي تظهر عليها.",
    "homeToggle": "الرئيسية",
    "locatorToggle": "الموقع",
    "detectToggle": "الفحص",
    "historyToggle": "سجلات",
    "profileToggle": ",الملف الشخصي",
      "herpes_zoster": "الهربس النطاقي",
      "psoriasis": "الصدفية",
      "eczema": "الإكزيما",
      "warts": "الثآليل",
      "urticaria": "الشرى",
      "bruise": "كدمة",
      "acne": "حب الشباب",
      "vitiligo": "البهاق",
      "dermatitis": "التهاب الجلد",
      "basal_cell": "الخلية القاعدية",
      "melanoma": "الميلانوما",
      "cancer": "سرطان",
    "questionReport": "يرجى الإجابة على الأسئلة التالية لمساعدتنا في تقديم تقرير دقيق!",
    "questionSymptom": "ما الأعراض التي تعاني منها؟",
    "rednessSymptom": "احمرار",
    "Pain level":"مستوى الألم [١-١٠]",
    "swellingSymptom": "تورم",
    "ItchinessSymptom": "حكة",
    "PainSymptom": "ألم",
    "questionHowLong": "منذ متى تعاني من هذه الأعراض؟",
    "daysList": "1-3 أيام",
    "week1List": "أسبوع واحد",
    "week2List": "أسبوعان",
    "monthList": "أكثر من شهر",
    "questionItch": "هل هناك حكة؟",
    "Agree": "نعم",
    "Disagree": "لا",
    "painList1": "١",
    "painList2": "٢",
    "painList3": "٣",
    "painList4": "٤",
    "painList5": "٥",
    "painList6": "٦",
    "painList7": "٧",
    "painList8": "٨",
    "painList9": "٩",
    "painList10": "١٠",
    "question_progressive": "هل الحالة تتطور أم تتراجع أم ثابته؟",
    "progressiveList": "تتطور",
    "RegressiveList": "تتراجع",
    "NoChangeList":"ثابته",
    "upload_photo": "يرجى تحميل صورة",
    "choose_photo": "اختر من الصور",
    "selected_photo": "تم اختيار الصورة",
    "detect_button": "افحص الآن",
    "logOut": "تسجيل خروج",
    "checkMssg": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    "cancel": "إلغاء",
    "Help_question": "ساعدنا في معرفة المزيد عنك",
    "None_question": "لا شيء",
    "Oily_question": "دهني",
    "Dry_question": "جاف",
    "Combination_question": "مختلط",
    "skin_type": "نوع البشرة",
    "Nuts": "المكسرات",
    "Pollen": "حبوب اللقاح",
    "Dust": "الغبار",
    "Others": "أخرى",
    "Allergies": "الحساسية",
    "findNearestButton": "اعثر على أقرب عيادة",
    "waitText": "الرجاء الانتظار يتم إنشاء تقرير بشرتك...",
    "Language": "لغة",
    "Skip":"تخطى >",
    "get started": "البدء",
    "cameraNote": "يرجى ملاحظة أنه من الأفضل التقاط صورة بالكاميرا الخلفية والإضاءة الجيدة للحصول على اكتشاف أفضل!",
     "VIEW YOUR PREVIOUS DETECTIONS":"عرض نتائج الفحص السابقة",
    "No detection history found":"لم يتم العثور على سجل الكشوفات",
    "Refresh":"تحديث",
    "View":"عرض",
    "Know more about your condition!":"اعرف المزيد عن حالتك!",
    'acne_title': 'حب الشباب',
    'acne_description': 'حب الشباب هو حالة جلدية شائعة تحدث عندما تصبح بصيلات الشعر مسدودة بالزيوت وخلايا الجلد الميتة. يمكن أن يسبب رؤوسًا بيضاء أو سوداء أو بثورًا. يكون حب الشباب أكثر شيوعًا بين المراهقين، على الرغم من أنه يصيب الأشخاص من جميع الأعمار.',
    'acne_symptoms_title': 'الأعراض',
    'acne_symptoms': '• الرؤوس البيضاء (مسام مسدودة مغلقة)\n'
        '• الرؤوس السوداء (مسام مسدودة مفتوحة)\n'
        '• نتوءات حمراء صغيرة مؤلمة (حطاطات)\n'
        '• البثور (بثرات)، وهي حطاطات بها صديد عند أطرافها\n'
        '• كتل كبيرة صلبة مؤلمة تحت الجلد (عقيدات)\n'
        '• كتل مؤلمة مليئة بالصديد تحت الجلد (آفات كيسية)',
    'acne_causes_title': 'الأسباب',
    'acne_causes': 'أربعة عوامل رئيسية تسبب حب الشباب:\n'
        '1. الإفراط في إنتاج الزيوت\n'
        '2. انسداد بصيلات الشعر بالزيوت وخلايا الجلد الميتة\n'
        '3. البكتيريا\n'
        '4. الالتهاب',
    'acne_treatment_title': 'العلاج',
    'acne_treatment': 'يعتمد علاج حب الشباب على شدته ويمكن أن يشمل علاجات موضعية دون وصفة طبية، وأدوية موصوفة، وتغييرات في نمط الحياة.',
    'ad_title': 'التهاب الجلد التأتبي',
    'ad_description': 'التهاب الجلد التأتبي هو حالة جلدية مزمنة تتميز بجفاف الجلد والحكة والالتهاب. وهو أكثر شيوعًا عند الأطفال ولكن يمكن أن يستمر حتى مرحلة البلوغ. غالبًا ما تكون الحالة وراثية وترتبط بالحساسية أو الربو أو حمى القش.',
    'ad_symptoms_title': 'الأعراض الشائعة',
    'ad_symptoms': '• حكة شديدة\n'
        '• بقع حمراء إلى بنية مائلة للرمادي\n'
        '• نتوءات صغيرة مرتفعة قد تفرز سائلاً\n'
        '• جلد سميك أو متشقق أو متقشر\n'
        '• جلد خام أو حساس بسبب الخدش',
    'ad_causes_title': 'المحفزات والأسباب',
    'ad_causes': 'تشمل المحفزات مسببات الحساسية والصابون القاسي والتوتر وتغيرات الطقس والتعرق. ترتبط الحالة بطفرات جينية تؤثر على وظيفة حاجز الجلد، مما يسمح بفقدان الرطوبة ودخول الجراثيم.',
    'ad_treatment_title': 'الإدارة والعلاج',
    'ad_treatment': 'يركز العلاج على تخفيف الأعراض. ويشمل الترطيب اليومي، والكورتيكوستيرويدات الموضعية، وتجنب المحفزات المعروفة، واستخدام مضادات الهيستامين أو المثبطات المناعية في الحالات الشديدة. الانتظام في العناية بالبشرة هو المفتاح.',
    'bcc_title': 'سرطان الخلايا القاعدية',
    'bcc_description': 'سرطان الخلايا القاعدية هو أكثر أنواع سرطان الجلد شيوعًا. ينشأ من الخلايا القاعدية في الطبقة الخارجية من الجلد ويحدث عادة بسبب التعرض الطويل للأشعة فوق البنفسجية من الشمس أو أسرّة التسمير. نادرًا ما ينتشر هذا النوع إلى أجزاء أخرى من الجسم لكنه يمكن أن ينمو بعمق ويسبب ضررًا موضعيًا.',
    'bcc_symptoms_title': 'الأعراض',
    'bcc_symptoms': '• نتوء لؤلؤي أو شمعي\n'
        '• آفة مسطحة بلون الجلد أو بنية تشبه الندبة\n'
        '• قرحة تنزف أو تتقشر ثم تلتئم وتعود\n'
        '• بقعة وردية أو حمراء لامعة مع قشور خفيفة\n'
        '• منطقة بيضاء أو صفراء أو شمعية ذات حدود غير واضحة',
    'bcc_causes_title': 'الأسباب وعوامل الخطر',
    'bcc_causes': 'السبب الرئيسي هو التعرض الطويل للأشعة فوق البنفسجية. تشمل عوامل الخطر البشرة الفاتحة، والعمر فوق 50 سنة، والتاريخ من حروق الشمس، واستخدام أسرّة التسمير، وضعف الجهاز المناعي.',
    'bcc_treatment_title': 'خيارات العلاج',
    'bcc_treatment': 'يعتمد العلاج على حجم الورم وموقعه وعمقه. تشمل الخيارات الاستئصال الجراحي، جراحة موس، العلاج بالتبريد، الأدوية الموضعية، العلاج الإشعاعي، أو العلاج بالليزر. الكشف المبكر يحسن النتائج بشكل كبير.',
    'bruise_title': 'كدمة (رضّ)',
    'bruise_description': 'الكدمة أو الرض هي إصابة جلدية شائعة تسبب تغير لون الجلد نتيجة الصدمة أو الارتطام، مما يؤدي إلى تمزق الأوعية الدموية الصغيرة (الشعيرات الدموية) وتسرب الدم تحت الجلد.',
    'bruise_symptoms_title': 'الأعراض',
    'bruise_symptoms': '• تغير اللون إلى الأزرق أو الأسود أو البنفسجي\n'
        '• ألم أو إيلام عند اللمس\n'
        '• تورم حول المنطقة المصابة\n'
        '• تغير اللون مع الوقت (إلى الأخضر أو الأصفر أو البني أثناء الشفاء)',
    'bruise_causes_title': 'الأسباب الشائعة',
    'bruise_causes': 'تحدث الكدمات عادة بسبب الاصطدامات أو السقوط أو الضربات على الجسم. يمكن أن تكون أيضًا أحد الآثار الجانبية لبعض الأدوية (مثل مميعات الدم) أو تدل على اضطراب نزيفي كامن.',
    'bruise_treatment_title': 'العلاج',
    'bruise_treatment': 'معظم الكدمات تشفى من تلقاء نفسها. يشمل العلاج:\n'
        '• إراحة المنطقة المصابة\n'
        '• وضع كمادات باردة لمدة 15-20 دقيقة\n'
        '• رفع المنطقة لتقليل التورم\n'
        '• تناول مسكنات الألم التي لا تستلزم وصفة طبية (إذا لزم الأمر)',
    'eczema_title': 'الإكزيما (التهاب الجلد التأتبي)',
    'eczema_description': 'الإكزيما، المعروفة أيضًا باسم التهاب الجلد التأتبي، هي حالة جلدية مزمنة تسبب بقعًا حمراء وحاكة وملتهبة من الجلد. توجد عادة عند الأطفال ولكن يمكن أن تحدث في أي عمر. الإكزيما طويلة الأمد وتميل إلى التفاقم بشكل دوري.',
    'eczema_symptoms_title': 'الأعراض',
    'eczema_symptoms': '• جلد جاف وحساس\n'
        '• جلد أحمر وملتهب\n'
        '• حكة شديدة\n'
        '• بقع جلدية داكنة اللون\n'
        '• بقع خشنة أو جلدية أو متقشرة\n'
        '• إفرازات أو قشور\n'
        '• تورم',
    'eczema_causes_title': 'الأسباب',
    'eczema_causes': 'السبب الدقيق للإكزيما غير معروف، ولكن يعتقد أنه مرتبط باستجابة مفرطة النشاط للجهاز المناعي للمهيجات. تلعب العوامل الوراثية والبيئية أيضًا دورًا.',
    'eczema_treatment_title': 'العلاج',
    'eczema_treatment': 'يشمل العلاج ترطيب الجلد، واستخدام الأدوية المضادة للالتهابات، وتجنب المحفزات. في الحالات الشديدة، قد يتم وصف أدوية عن طريق الفم أو العلاج الضوئي.',
    'herpes_zoster_title': 'الهربس النطاقي (الحزام الناري)',
    'herpes_zoster_description': 'الهربس النطاقي، المعروف أيضًا باسم الحزام الناري، هو عدوى فيروسية تسبب طفحًا جلديًا مؤلمًا. يسببه فيروس الحماق النطاقي، وهو نفس الفيروس المسبب لجدري الماء. بعد التعافي من جدري الماء، يمكن أن يظل الفيروس كامنًا في الأنسجة العصبية وينشط لاحقًا كحزام ناري.',
    'herpes_zoster_symptoms_title': 'الأعراض',
    'herpes_zoster_symptoms': '• ألم، حرقة، تنميل، أو وخز\n'
        '• حساسية للمس\n'
        '• طفح جلدي أحمر يبدأ بعد أيام قليلة من الألم\n'
        '• بثور مليئة بالسوائل تنفتح وتتقشر\n'
        '• حكة',
    'herpes_zoster_causes_title': 'الأسباب',
    'herpes_zoster_causes': 'يحدث الهربس النطاقي بسبب فيروس الحماق النطاقي. بعد إصابة الشخص بجدري الماء، يظل الفيروس كامنًا في الجهاز العصبي ويمكن أن ينشط بعد سنوات على شكل حزام ناري.',
    'herpes_zoster_treatment_title': 'العلاج',
    'herpes_zoster_treatment': 'قد يشمل العلاج الأدوية المضادة للفيروسات، مسكنات الألم، والمراهم الموضعية لتخفيف الأعراض. تتوفر أيضًا لقاحات لتقليل خطر الإصابة بالحزام الناري.',
    'melanoma_title': 'الميلانوما',
    'melanoma_description': 'الميلانوما هي شكل خطير من سرطان الجلد يتطور في الخلايا الصبغية (الميلانوسايتس) المسؤولة عن إنتاج الصبغة (الميلانين). وهي أكثر عرضة للنمو والانتشار من أنواع سرطان الجلد الأخرى، مما يجعل الكشف المبكر والعلاج أمرًا بالغ الأهمية.',
    'melanoma_warning_signs_title': 'علامات التحذير (قاعدة ABCDE)',
    'melanoma_warning_signs': '• **A** عدم التناظر: نصف الشامة يختلف عن النصف الآخر\n'
        '• **B** الحدود: حدود غير منتظمة أو متعرجة أو غير محددة بوضوح\n'
        '• **C** اللون: يختلف من منطقة إلى أخرى\n'
        '• **D** القطر: عادة أكبر من 6 مم (بحجم ممحاة القلم)\n'
        '• **E** التطور: تغيرات في الحجم أو الشكل أو اللون مع الوقت',
    'melanoma_risk_factors_title': 'عوامل الخطر',
    'melanoma_risk_factors': 'تشمل عوامل الخطر التعرض المفرط للأشعة فوق البنفسجية، البشرة الفاتحة، التاريخ العائلي أو الشخصي للميلانوما، كثرة الشامات، وضعف وظيفة المناعة.',
    'melanoma_treatment_title': 'التشخيص والعلاج',
    'melanoma_treatment': 'يشمل التشخيص الفحص الجلدي وأخذ الخزعة. يعتمد العلاج على المرحلة وقد يشمل الاستئصال الجراحي، العلاج المناعي، العلاج الموجه، العلاج الكيميائي، أو الإشعاعي. عند الكشف المبكر، تكون الميلانوما قابلة للعلاج بنسبة عالية.',
    'psoriasis_title': 'الصدفية',
    'psoriasis_description': 'الصدفية هي حالة جلدية مزمنة تسرع دورة حياة خلايا الجلد. تتراكم الخلايا بسرعة على سطح الجلد مسببة بقعًا متقشرة غالبًا ما تكون مثيرة للحكة وأحيانًا مؤلمة.',
    'psoriasis_symptoms_title': 'الأعراض',
    'psoriasis_symptoms': '• بقع حمراء من الجلد مغطاة بقشور فضية سميكة\n'
        '• جلد جاف متشقق قد ينزف\n'
        '• حكة، حرقة، أو ألم\n'
        '• أظافر سميكة أو منقرة أو متعرجة\n'
        '• تورم وتيبس المفاصل (في التهاب المفاصل الصدفي)',
    'psoriasis_types_title': 'الأنواع',
    'psoriasis_types': 'هناك عدة أنواع من الصدفية، بما في ذلك:\n'
        '1. الصدفية اللويحية\n'
        '2. الصدفية النقطية\n'
        '3. الصدفية العكسية\n'
        '4. الصدفية البثرية\n'
        '5. الصدفية الاحمرارية',
    'psoriasis_treatment_title': 'العلاج',
    'psoriasis_treatment': 'لا يوجد علاج شافٍ للصدفية، ولكن العلاجات يمكن أن تساعد في السيطرة على الأعراض. قد تشمل هذه العلاجات الموضعية، العلاج الضوئي، والأدوية الجهازية.',
    'urticaria_title': 'الشرى (الأرتيكاريا)',
    'urticaria_description': 'الشرى، المعروف شعبياً بالأرتيكاريا، هو تفاعل جلدي يسبب انتفاخات مثيرة للحكة. يمكن أن تختلف هذه الانتفاخات في الحجم وتظهر في أي مكان بالجسم. غالباً ما تكون حمراء أو وردية أو بلون الجلد وقد تكون مؤلمة أو مثيرة للحكة.',
    'urticaria_symptoms_title': 'الأعراض',
    'urticaria_symptoms': '• انتفاخات مثيرة للحكة على الجلد\n'
        '• انتفاخات تختلف في الحجم والشكل\n'
        '• بقع حمراء أو وردية أو بلون الجلد\n'
        '• تورم أو التهاب\n'
        '• انزعاج أو ألم',
    'urticaria_causes_title': 'الأسباب',
    'urticaria_causes': 'يمكن أن يحدث الشرى بسبب ردود فعل تحسسية، أو التوتر، أو العدوى، أو عوامل بيئية مثل تغيرات درجة الحرارة أو التعرض للشمس. في بعض الحالات، قد يكون السبب غير معروف (شرى مجهول السبب).',
    'urticaria_treatment_title': 'العلاج',
    'urticaria_treatment': 'قد يشمل العلاج مضادات الهيستامين لتخفيف الحكة والتورم، وتجنب المحفزات المعروفة، واستخدام مستحضرات موضعية مهدئة. في الحالات الشديدة، قد يتم وصف الكورتيكوستيرويدات أو أدوية أخرى.',
    'vitiligo_title': 'البهاق',
    'vitiligo_description': 'البهاق هو حالة جلدية طويلة الأمد تتميز بفقدان بقع الجلد لصبغتها. يحدث هذا عندما يتم تدمير الخلايا الصبغية (الميلانوسايتس) المسؤولة عن لون الجلد. يصبح الجلد المصاب أبيض اللون مع حواف حادة.',
    'vitiligo_symptoms_title': 'الأعراض',
    'vitiligo_symptoms': '• فقدان لون الجلد على شكل بقع\n'
        '• شيب الشعر المبكر\n'
        '• تغير لون الشبكية\n'
        '• فقدان اللون في الأنسجة داخل الفم والأنف',
    'vitiligo_causes_title': 'الأسباب',
    'vitiligo_causes': 'السبب الدقيق للبهاق غير معروف، ولكن يعتقد أنه حالة من أمراض المناعة الذاتية حيث يهاجم الجسم خلاياه الصبغية. قد تلعب العوامل الوراثية والبيئية دورًا أيضًا.',
    'vitiligo_treatment_title': 'العلاج',
    'vitiligo_treatment': 'لا يوجد علاج شافٍ للبهاق، ولكن تهدف العلاجات إلى استعادة لون الجلد أو توحيد لون البشرة. تشمل الخيارات الكورتيكوستيرويدات الموضعية، العلاج الضوئي، ومستحضرات التجميل التمويهية.',
    'warts_title': 'الثآليل',
    'warts_description': 'الثآليل هي زوائد جلدية صغيرة وحبيبية تسببها فيروس الورم الحليمي البشري (HPV). تظهر عادة على اليدين والقدمين ولكن يمكن أن تظهر في أي مكان بالجسم.',
    'warts_symptoms_title': 'الأعراض',
    'warts_symptoms': '• نتوءات صغيرة لحمية على الجلد\n'
        '• خشنة الملمس\n'
        '• نقاط سوداء (أوعية دموية متجلطة)\n'
        '• ألم أو إيلام',
    'warts_treatment_title': 'العلاج',
    'warts_treatment': 'تشمل خيارات العلاج الأدوية التي لا تستلزم وصفة طبية، العلاج بالتبريد (التجميد)، العلاج بالليزر، والإزالة الجراحية.',
    'skin_cancer_title': 'سرطان الجلد',
    'skin_cancer_description': 'سرطان الجلد هو نمو غير طبيعي لخلايا الجلد، يظهر غالبًا في المناطق المعرضة للشمس. ويشمل أنواعًا مختلفة مثل سرطان الخلايا القاعدية، وسرطان الخلايا الحرشفية، والأورام الميلانينية. الكشف المبكر ضروري للعلاج الناجح.',
    'skin_cancer_symptoms_title': 'الأعراض',
    'skin_cancer_symptoms': '• نمو جديد أو قرحة لا تلتئم\n'
        '• تغيرات في شامة موجودة\n'
        '• شامة ذات حدود غير منتظمة أو ألوان متعددة\n'
        '• حكة أو ألم أو نزيف في بقعة جلدية\n'
        '• بقع مسطحة متقشرة قد تكون حمراء أو بنية',
    'skin_cancer_causes_title': 'الأسباب',
    'skin_cancer_causes': 'يحدث سرطان الجلد بشكل رئيسي بسبب التعرض الطويل للأشعة فوق البنفسجية من الشمس أو أسرّة التسمير. تشمل عوامل الخطر:\n'
        '1. البشرة الفاتحة\n'
        '2. التعرض المفرط للشمس\n'
        '3. تاريخ عائلي لسرطان الجلد\n'
        '4. تاريخ من حروق الشمس\n'
        '5. ضعف الجهاز المناعي',
    'skin_cancer_treatment_title': 'العلاج',
    'skin_cancer_treatment': 'يعتمد العلاج على نوع ومرحلة السرطان وقد يشمل الاستئصال الجراحي، العلاج الإشعاعي، العلاج الكيميائي، أو العلاج المناعي. غالبًا ما يمكن علاج سرطانات الجلد في المراحل المبكرة بإجراءات العيادات الخارجية.',
    "Done":"انتهيت"

  };


  Map<String, String> textsEn = {
    "Know more about your condition!":"Know more about your condition!",
    "Save" : "Save",
    "Edit" : "Edit",
    "catchLineHome": "Your Skin , Our Science",
    "phraseHome": "    Thousand of people are using DermaScan\n                       for Skin Detection",
    "signUp": "Sign Up",
    "accountCheckHome": "ALREADY HAVE AN ACCOUNT?",
    "logIn": "LOG IN",
    "createAcc": "Create Your Account",
    "Username": "Username",
    "Email": "Email",
    "Password": "Password",
    "Date of Birth": "Date of Birth",
    "Male": "Male",
    "Female": "Female",
    "Gender": "Gender",
    "Language": "Language",
    "errorM1": "Error: Please fill in all fields",
    "hi": "HI",
    "questionTitle":"Please answer the following questions to help us give you a precise report!",
    "welcomeBack": "Welcome Back!",
    "ContWithFaceBook": "CONTINUE WITH FACEBOOK",
    "ContWithGoogle": "CONTINUE WITH GOOGLE",
    "ContWithMail": "OR LOG IN WITH EMAIL",
    "noAccount": "I Don't HAVE AN ACCOUNT?",
    "nearestLocation": "Nearest Locations",
    "loading":"Loading...",
    "mainTitle": "We can learn to understand how our skin reveals its everyday story, helping us recognize the signs it shows us.",
    "homeToggle": "Home",
    "locatorToggle": "Locator",
    "detectToggle": "DETECT",
    "historyToggle": "History",
    "profileToggle": "Profile",
      "herpes_zoster": "Herpes Zoster",
      "psoriasis": "Psoriasis",
      "eczema": "Eczema",
      "warts": "Warts",
      "urticaria": "Urticaria",
      "bruise": "Bruise",
      "acne": "Acne",
      "vitiligo": "Vitiligo",
      "dermatitis": "Dermatitis",
      "basal_cell": "Basal Cell",
      "melanoma": "Melanoma",
      "cancer": "Cancer",
    "Pain level": "Pain level [1-10]",
    "MelanomaTitle":"Melanoma",
    "questionReport": "Please answer the following questions to help us give you a precise report!",
    "questionSymptom": "What symptoms are you experiencing?",
    "rednessSymptom": "Redness",
    "swellingSymptom": "Swelling",
    "ItchinessSymptom": "Itchiness",
    "PainSymptom": "Pain",
    "questionHowLong": "How long have you been experiencing these symptoms?",
    "daysList": "1-3 days",
    "week1List": "1 week",
    "week2List": "2 weeks",
    "monthList": "More than a month",
    "questionItch": "Is there itchiness?",
    "Agree": "Yes",
    "Disagree": "No",
    "painList1": "1",
    "painList2": "2",
    "painList3": "3",
    "painList4": "4",
    "painList5": "5",
    "painList6": "6",
    "painList7": "7",
    "painList8": "8",
    "painList9": "9",
    "painList10": "10",
    "question_progressive": "Is it progressive or regressive?",
    "progressiveList": "Progressive",
    "RegressiveList": "Regressive",
    "NoChangeList":"No change",
    "upload_photo": "upload photo please",
    "choose_photo": "Choose from photos",
    "selected_photo": "Photo Selected",
    "detect_button": "DETECT NOW",
    "logOut": "Logout",
    "checkMssg": "Are you sure you want to logout?",
    "cancel": "Cancel",
    "Help_question": "Help us know more about you",
    "None_question": "None",
    "Oily_question": "Oily",
    "Dry_question": "Dry",
    "Combination_question": "Combination",
    "skin_type":"Skin Type",
    "Nuts":"Nuts",
    "Pollen": "Pollen",
    "Dust": "Dust",
    "Others": "Others",
    "Allergies": "Allergies",
    "findNearestButton": "Find Nearest Clinic",
    "waitText": "Generating your skin report...",
    "Skip":"SKIP >",
    "get started": "get started",
    "cameraNote": "please note that it\'s better to take a photo with the back camera and good lightning for a better detection !",
    "VIEW YOUR PREVIOUS DETECTIONS":"VIEW YOUR PREVIOUS DETECTIONS",
    "No detection history found":"No detection history found",
    "Refresh":"Refresh",
    "View":"View",
    'acne_title': 'Acne',
    'acne_description': 'Acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells. It can cause whiteheads, blackheads, or pimples. Acne is most common among teenagers, though it affects people of all ages.',
    'acne_symptoms_title': 'Symptoms',
    'acne_symptoms': '• Whiteheads (closed clogged pores)\n'
        '• Blackheads (open clogged pores)\n'
        '• Small red, tender bumps (papules)\n'
        '• Pimples (pustules), which are papules with pus at their tips\n'
        '• Large, solid, painful lumps beneath the skin (nodules)\n'
        '• Painful, pus-filled lumps beneath the skin (cystic lesions)',
    'acne_causes_title': 'Causes',
    'acne_causes': 'Four main factors cause acne:\n'
        '1. Excess oil production\n'
        '2. Hair follicles clogged by oil and dead skin cells\n'
        '3. Bacteria\n'
        '4. Inflammation',
    'acne_treatment_title': 'Treatment',
    'acne_treatment': 'Treatment for acne depends on its severity and can include over-the-counter topical treatments, prescription medications, and lifestyle changes.',
    'ad_title': 'Atopic Dermatitis',
    'ad_description': 'Atopic Dermatitis is a chronic skin condition characterized by dry, itchy, and inflamed skin. It is most common in children but can persist into adulthood. The condition often runs in families and is associated with allergies, asthma, or hay fever.',
    'ad_symptoms_title': 'Common Symptoms',
    'ad_symptoms': '• Intense itching\n'
        '• Red to brownish-gray patches\n'
        '• Small raised bumps that may leak fluid\n'
        '• Thickened, cracked, or scaly skin\n'
        '• Raw or sensitive skin from scratching',
    'ad_causes_title': 'Triggers & Causes',
    'ad_causes': 'Triggers include allergens, harsh soaps, stress, weather changes, and sweating. The condition is linked to genetic mutations that affect the skin\'s barrier function, allowing moisture out and germs in.',
    'ad_treatment_title': 'Management & Treatment',
    'ad_treatment': 'Treatment focuses on relieving symptoms. It includes daily moisturizing, topical corticosteroids, avoiding known triggers, and using antihistamines or immunosuppressants in severe cases. Consistency in skincare is key.',
    'bcc_title': 'Basal Cell Carcinoma (BCC)',
    'bcc_description': 'Basal Cell Carcinoma is the most common type of skin cancer. It arises from basal cells in the skin\'s outermost layer and is typically caused by prolonged exposure to ultraviolet (UV) radiation from the sun or tanning beds. BCC rarely spreads to other parts of the body but can grow deeply and cause local damage.',
    'bcc_symptoms_title': 'Symptoms',
    'bcc_symptoms': '• A pearly or waxy bump\n'
        '• A flat, flesh-colored or brown scar-like lesion\n'
        '• A bleeding or scabbing sore that heals and returns\n'
        '• A shiny pink or red, slightly scaly patch\n'
        '• A white, yellow, or waxy area with poorly defined borders',
    'bcc_causes_title': 'Causes & Risk Factors',
    'bcc_causes': 'The primary cause is long-term UV radiation exposure. Risk factors include fair skin, age over 50, a history of sunburns, use of tanning beds, and a weakened immune system.',
    'bcc_treatment_title': 'Treatment Options',
    'bcc_treatment': 'Treatment depends on size, location, and depth of the tumor. Options include surgical excision, Mohs surgery, cryotherapy, topical medications, radiation therapy, or laser treatment. Early detection significantly improves outcomes.',
    'bruise_title': 'Bruise (Contusion)',
    'bruise_description': 'A bruise, or contusion, is a common skin injury that results in discoloration of the skin due to trauma or impact, which causes small blood vessels (capillaries) to break and leak under the skin.',
    'bruise_symptoms_title': 'Symptoms',
    'bruise_symptoms': '• Blue, black, or purple discoloration\n'
        '• Tenderness or pain at the site\n'
        '• Swelling around the area\n'
        '• Color change over time (green, yellow, or brown as it heals)',
    'bruise_causes_title': 'Common Causes',
    'bruise_causes': 'Bruises are typically caused by bumps, falls, or blows to the body. They can also be a side effect of certain medications (like blood thinners) or indicate an underlying bleeding disorder.',
    'bruise_treatment_title': 'Treatment',
    'bruise_treatment': 'Most bruises heal on their own. Treatment includes:\n'
        '• Resting the area\n'
        '• Applying ice packs for 15-20 minutes\n'
        '• Elevating the area to reduce swelling\n'
        '• Taking over-the-counter pain relievers (if needed)',
    'eczema_title': 'Eczema (Atopic Dermatitis)',
    'eczema_description': 'Eczema, also known as atopic dermatitis, is a chronic skin condition that causes red, itchy, and inflamed patches of skin. It is commonly found in children but can occur at any age. Eczema is long-lasting and tends to flare periodically.',
    'eczema_symptoms_title': 'Symptoms',
    'eczema_symptoms': '• Dry, sensitive skin\n'
        '• Red, inflamed skin\n'
        '• Severe itching\n'
        '• Dark-colored patches of skin\n'
        '• Rough, leathery, or scaly patches\n'
        '• Oozing or crusting\n'
        '• Swelling',
    'eczema_causes_title': 'Causes',
    'eczema_causes': 'The exact cause of eczema is unknown, but it is believed to be linked to an overactive immune system response to irritants. Genetic and environmental factors also play a role.',
    'eczema_treatment_title': 'Treatment',
    'eczema_treatment': 'Treatment includes moisturizing the skin, using anti-inflammatory medications, and avoiding triggers. In severe cases, oral medications or light therapy may be prescribed.',
    'herpes_zoster_title': 'Herpes Zoster (Shingles)',
    'herpes_zoster_description': 'Herpes Zoster, also known as shingles, is a viral infection that causes a painful rash. It is caused by the varicella-zoster virus, the same virus that causes chickenpox. After recovering from chickenpox, the virus can lie dormant in nerve tissue and reactivate later as shingles.',
    'herpes_zoster_symptoms_title': 'Symptoms',
    'herpes_zoster_symptoms': '• Pain, burning, numbness, or tingling\n'
        '• Sensitivity to touch\n'
        '• Red rash that begins a few days after the pain\n'
        '• Fluid-filled blisters that break open and crust over\n'
        '• Itching',
    'herpes_zoster_causes_title': 'Causes',
    'herpes_zoster_causes': 'Herpes Zoster is caused by the varicella-zoster virus. After a person has chickenpox, the virus remains dormant in the nervous system and can reactivate years later as shingles.',
    'herpes_zoster_treatment_title': 'Treatment',
    'herpes_zoster_treatment': 'Treatment may include antiviral medications, pain relievers, and topical ointments to alleviate symptoms. Vaccines are also available to reduce the risk of developing shingles.',
    'melanoma_title': 'Melanoma',
    'melanoma_description': 'Melanoma is a serious form of skin cancer that develops in the melanocytes — the cells responsible for producing pigment (melanin). It is more likely to grow and spread than other types of skin cancer, making early detection and treatment critical.',
    'melanoma_warning_signs_title': 'Warning Signs (ABCDE Rule)',
    'melanoma_warning_signs': '• **A**symmetry: One half is unlike the other\n'
        '• **B**order: Irregular, scalloped, or poorly defined border\n'
        '• **C**olor: Varies from one area to another\n'
        '• **D**iameter: Usually greater than 6 mm (pencil eraser size)\n'
        '• **E**volving: Changes in size, shape, or color over time',
    'melanoma_risk_factors_title': 'Risk Factors',
    'melanoma_risk_factors': 'Risk factors include excessive UV exposure, fair skin, a family or personal history of melanoma, many moles, and weakened immune function.',
    'melanoma_treatment_title': 'Diagnosis & Treatment',
    'melanoma_treatment': 'Diagnosis involves skin examination and biopsy. Treatment depends on the stage and may include surgical removal, immunotherapy, targeted therapy, chemotherapy, or radiation. When detected early, melanoma is highly treatable.',
    'psoriasis_title': 'Psoriasis',
    'psoriasis_description': 'Psoriasis is a chronic skin condition that speeds up the life cycle of skin cells. It causes cells to build up rapidly on the surface of the skin, leading to scaly patches that are often itchy and sometimes painful.',
    'psoriasis_symptoms_title': 'Symptoms',
    'psoriasis_symptoms': '• Red patches of skin covered with thick, silvery scales\n'
        '• Dry, cracked skin that may bleed\n'
        '• Itching, burning, or soreness\n'
        '• Thickened, pitted, or ridged nails\n'
        '• Swollen and stiff joints (in psoriatic arthritis)',
    'psoriasis_types_title': 'Types',
    'psoriasis_types': 'There are several types of psoriasis, including:\n'
        '1. Plaque Psoriasis\n'
        '2. Guttate Psoriasis\n'
        '3. Inverse Psoriasis\n'
        '4. Pustular Psoriasis\n'
        '5. Erythrodermic Psoriasis',
    'psoriasis_treatment_title': 'Treatment',
    'psoriasis_treatment': 'While there is no cure for psoriasis, treatments can help manage symptoms. These may include topical treatments, light therapy, and systemic medications.',
    'urticaria_title': 'Urticaria (Hives)',
    'urticaria_description': 'Urticaria, commonly known as hives, is a skin reaction that causes itchy welts. These welts can vary in size and can appear anywhere on the body. They are often red, pink, or flesh-colored and can be painful or itchy.',
    'urticaria_symptoms_title': 'Symptoms',
    'urticaria_symptoms': '• Itchy, raised welts on the skin\n'
        '• Welts that vary in size and shape\n'
        '• Red, pink, or flesh-colored patches\n'
        '• Swelling or inflammation\n'
        '• Discomfort or pain',
    'urticaria_causes_title': 'Causes',
    'urticaria_causes': 'Urticaria can be triggered by allergic reactions, stress, infections, or environmental factors such as temperature changes or sun exposure. In some cases, the cause may be unknown (idiopathic urticaria).',
    'urticaria_treatment_title': 'Treatment',
    'urticaria_treatment': 'Treatment may include antihistamines to relieve itching and swelling, avoiding known triggers, and using topical soothing agents. In severe cases, corticosteroids or other medications may be prescribed.',
    'vitiligo_title': 'Vitiligo',
    'vitiligo_description': 'Vitiligo is a long-term skin condition characterized by patches of skin losing their pigment. This occurs when melanocytes, the cells responsible for skin color, are destroyed. The affected skin becomes white, with sharp margins.',
    'vitiligo_symptoms_title': 'Symptoms',
    'vitiligo_symptoms': '• Loss of skin color in patches\n'
        '• Premature graying of hair\n'
        '• Change in color of the retina\n'
        '• Loss of color in the tissues inside the mouth and nose',
    'vitiligo_causes_title': 'Causes',
    'vitiligo_causes': 'The exact cause of vitiligo is unknown, but it is believed to be an autoimmune condition where the body attacks its own melanocytes. Genetics and environmental factors may also play a role.',
    'vitiligo_treatment_title': 'Treatment',
    'vitiligo_treatment': 'While there is no cure for vitiligo, treatments aim to restore skin color or even out skin tone. Options include topical corticosteroids, light therapy, and camouflage cosmetics.',
    'warts_title': 'Warts',
    'warts_description': 'Warts are small, grainy skin growths caused by the human papillomavirus (HPV). They commonly occur on the hands and feet but can appear anywhere on the body.',
    'warts_symptoms_title': 'Symptoms',
    'warts_symptoms': '• Small, fleshy bumps on the skin\n'
        '• Rough to the touch\n'
        '• Black pinpoints (clotted blood vessels)\n'
        '• Pain or tenderness',
    'warts_treatment_title': 'Treatment',
    'warts_treatment': 'Treatment options include over-the-counter medications, cryotherapy (freezing), laser treatment, and surgical removal.',
    'skin_cancer_title': 'Skin Cancer',
    'skin_cancer_description': 'Skin cancer is the abnormal growth of skin cells, often developing on areas of the skin exposed to the sun. It includes different types such as basal cell carcinoma, squamous cell carcinoma, and melanoma. Early detection is crucial for successful treatment.',
    'skin_cancer_symptoms_title': 'Symptoms',
    'skin_cancer_symptoms': '• A new growth or sore that doesn\'t heal\n'
        '• Changes in an existing mole\n'
        '• A mole with irregular borders or multiple colors\n'
        '• Itching, tenderness, or bleeding on a skin spot\n'
        '• Flat, scaly patches that may be red or brown',
    'skin_cancer_causes_title': 'Causes',
    'skin_cancer_causes': 'Skin cancer is primarily caused by prolonged exposure to ultraviolet (UV) radiation from the sun or tanning beds. Risk factors include:\n'
        '1. Fair skin\n'
        '2. Excessive sun exposure\n'
        '3. Family history of skin cancer\n'
        '4. History of sunburns\n'
        '5. Weakened immune system',
    'skin_cancer_treatment_title': 'Treatment',
    'skin_cancer_treatment': 'Treatment depends on the type and stage of cancer and may include surgical removal, radiation therapy, chemotherapy, or immunotherapy. Early-stage skin cancers are often treatable with outpatient procedures.',
    "Done":"Done"
  };
}