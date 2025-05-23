import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'appTitle': '٧ دقائق مع الرب',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'النهاية',
      'calling': 'الدعاء بإسم الرب',
      'callingDescription':
          'الدعاء بإسم الرب لوضع ذهننا على الروح (١كو ٣:١٢، رو٦:٨، ١٠-١٣:١٢)',
      'praying': 'الصلاة',
      'prayingDescription':
          'فتح قلوبنا، تليين قلوبنا وتفريغ أنفسنا. أن نقول له بإننا نحبه - (٢كو ١٦:٣؛ مز ٨:٦٢)',
      'prayReading': 'صلاة-القراءة',
      'prayReadingDescription':
          'إستخدام روحنا المُمَرن لنصلي آية او إثنتان. تحويل الآيات إلى صلاة شخصية - (أف ١٧:٦-١٨؛ ٢تي ١٦:٣)',
      'confession': 'الإعتراف',
      'confessionDescription':
          'الإعتراف بالخطايا والإساءات في ضميرنا ومحو كل الحواجز للشركة. سائل الرب الغفران والتطهير - (١ يو ١-٩:٧، مز ١٨:٦٦، إش ١:٥٩-٢)',
      'consecration': 'التكريس',
      'consecrationDescription':
          'نقدم نفوسنا للرب من جديد، ونعطيه المساحة التامة داخلنا- (رو ١:١٢-٢؛ ١٣:٦، ١٩؛ مر ٣٠:١٢)',
      'thanksgiving': 'الشُكر',
      'thanksgivingDescription':
          'إعطاء شكر للرب من أجل كل الأشياء، من أجل كل الأشخاص، المواقف والأشياء في حياتك وسبحه - (أف ٢٠:٥ ؛ ١تس ١٨:٥)',
      'petition': 'التضرع',
      'petitionDescription':
          'اسأل الرب الإحتياجات، النمو والأشخاص المحتاجين للخلاص - (١ تي ١:٢، أف ١٨:٦، مت ٧:٧، مز ٨:١٤٣)',
    },
    'en': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Calling',
      'callingDescription':
          'Calling on the Name of the Lord to set our mind on the spirit – 1 Cor.12:3; Rom. 8:6; 10:12-13',
      'praying': 'Praying',
      'prayingDescription':
          'Opening our heart, softening our heart and emptying ourselves. Telling Him that we love Him – 2 Cor. 3:16; Psa. 62:8',
      'prayReading': 'Pray-reading',
      'prayReadingDescription':
          'Using our exercised spirit to pray over a verse or two. Turning the verses into a personal prayer – Eph. 6:17-18; 2 Tim. 3:16',
      'confession': 'Confession',
      'confessionDescription':
          'Confessing the sins and offenses on our conscience and removing all blockages to fellowship. Asking for forgiveness and cleansing – 1 John 1:7, 9; Psa. 66:18; Isa. 59:1-2',
      'consecration': 'Consecration',
      'consecrationDescription':
          'Presenting ourselves to the Lord afresh, giving Him the full ground in us – Rom. 12:1-2; 6:13,19; Mark 12:30',
      'thanksgiving': 'Thanksgiving',
      'thanksgivingDescription':
          'Giving thanks for all things; for all the persons, situations and things in your life and praising Him – Eph. 5:20; 1 Thes. 5:18',
      'petition': 'Petition',
      'petitionDescription':
          'Asking the Lord for needs, growth and persons that need salvation – 1 Tim. 2:1: Eph. 6:18; Matt. 7:7; Psa. 143:8',
    },
    'de': {
      'appTitle': 'Sieben Minuten mit dem Herrn',
      'start': 'Start!',
      'goBack': 'Zurück',
      'language': 'Sprache',
      'completed': 'Abgeschlossen',
      'next': 'Nächste',
      'allActivitiesCompleted': 'Alle Aktivitäten abgeschlossen',
      'calling': 'Den Namen des Herrn anrufen',
      'callingDescription':
          'Den Namen des Herrn anrufen um unser Verstand auf den Geist zu setzen - 1.Kor 12:3; Röm. 8:6; 10:12-13',
      'praying': 'Beten',
      'prayingDescription':
          'Unser Herz öffnen, es weichmachen und unser sein entleeren. Sag Ihm dass, wir Ihn lieben. - 2. Kor 3:16; Ps. 62:8',
      'prayReading': 'Betenlesen',
      'prayReadingDescription':
          'Benutz unseren geübten Geist um über einen Vers oder zwei Verse zu beten. Wende diese Verse ins persönliche Gebet an. - Eph. 6:17-18; 2.Tim 3:16',
      'confession': 'Sünden bekennen',
      'confessionDescription':
          'Die Sünden und Verstöße in unser Gewissen bekennen um alle Hindernisse zu einer Gemeinschaft zu beseitigen. Bitten um eine Vergebung und Reinigung. - 1.Joh 1:7, 9; Ps. 66:18; Jes. 59:1-2',
      'consecration': 'Sich hingeben',
      'consecrationDescription':
          'Sich dem Herrn erneut hingeben, Ihm den ganzen Boden in unser Sein hingeben. - Röm. 12:1-2; 6:13,19; Mk. 12:30',
      'thanksgiving': 'Danksagung',
      'thanksgivingDescription':
          'Sag Dank im allen Dingen; für alle Personen, Situationen und Dingen in deinem Leben und loben Ihn. - Eph. 5:20; 1.Thes 5:18',
      'petition': 'Fürbitte',
      'petitionDescription':
          'Bittet dem Herrn um deine Bedürfnisse, deinen Wachstum und um Personen, die eine Errettung brauchen. - 1.Tim. 2:1: Eph. 6:18; Mt. 7:7; Ps. 143:8',
    },
    'es': {
      'appTitle': 'Siete Minutos Con El Señor',
      'start': '¡Comenzar!',
      'goBack': 'Regresar',
      'language': 'Idioma',
      'completed': 'Completado',
      'next': 'Siguiente',
      'allActivitiesCompleted': 'Todas las actividades completadas',
      'calling': 'Invocar el nombre del Señor',
      'callingDescription':
          'Invocar el nombre del Señor para poner nuestra mente en el espíritu - 1 Co.12:3; Rom. 8:6; 10:12-13',
      'praying': 'Orar',
      'prayingDescription':
          'Abrir nuestro corazón, suavizar nuestro corazón y vaciarnos a nosotros mismos. Decirle que lo amamos a Él - 2 Co. 3:16; Sal. 62:8',
      'prayReading': 'Orar-leer',
      'prayReadingDescription':
          'Usar nuestro espíritu ejercitado para orar uno o dos versículos. Tornar los versículos en una oración personal - Ef. 6:17-18; 2 Tim. 3:16',
      'confession': 'Confesión',
      'confessionDescription':
          'Confesar los pecados y las ofensas que están en nuestra conciencia y quitar todo lo que obstruye la comunión. Pedir perdón y lavamiento - 1 Jn 1:7, 9; Sal. 66:18; Is. 59:1-2',
      'consecration': 'Consagración',
      'consecrationDescription':
          'Presentarnos al Señor de manera fresca, dándole todo el terreno en nosotros - Rom. 12:1-2; 6:13,19; Marc 12:30',
      'thanksgiving': 'Dar gracias',
      'thanksgivingDescription':
          'Dar gracias por todas las cosas, por todas las personas, situaciones y cosas en su vida y alabarlo a Él - Ef. 5:20; 1 Tes. 5:18',
      'petition': 'Petición',
      'petitionDescription':
          'Pedirle al Señor por las necesidades, el crecimiento y las personas que necesitan salvación - 1 Tim. 2:1: Ef. 6:18; Mat. 7:7; Sal. 143:8',
    },
    'id': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Mulai!',
      'goBack': 'Kembali',
      'language': 'Bahasa',
      'completed': 'Selesai',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Berseru kepada nama Tuhan',
      'callingDescription':
          'Berseru kepada nama Tuhan untuk mengarahkan pikiran kita pada roh - 1 Korintus 12:3; Roma 8:6; 10:12-13',
      'praying': 'Berdoa',
      'prayingDescription':
          'Membuka hati kita, melembutkan hati kita, dan mengosongkan diri kita. Memberitahu Dia bahwa kita mengasihi Dia - 2 Korintus 3:16; Mazmur 62:8',
      'prayReading': 'Doa Baca',
      'prayReadingDescription':
          'Memakai roh kita mendoakan 1-2 ayat. Mengubah ayat-ayat itu menjadi doa pribadi kita - Efesus 6:17-18; 2 Timotius 3:16',
      'confession': 'Mengaku Dosa',
      'confessionDescription':
          'Mengakui dosa-dosa dan pelanggaran-pelanggaran yang ada pada hati nurani kita dan menyingkirkan semua penghalang persekutuan. Memohon pengampunan dan pembasuhan - 1 Yohanes 1:7, 9; Mazmur 66:18; Yesaya 59:1-2',
      'consecration': 'Konsikrasi',
      'consecrationDescription':
          'Mempersembahkan diri kita kepada Tuhan dengan segar, memberi Dia landasan di dalam seluruh diri kita - Roma 12:1-2; 6:13,19; Markus 12:30',
      'thanksgiving': 'Mengucap Syukur',
      'thanksgivingDescription':
          'Mengucap syukur untuk segala sesuatu; untuk semua orang, semua situasi, dan semua hal di dalam hidup Anda dan memuji Dia - Efesus 5:20; 1 Tesalonika 5:18',
      'petition': 'Doa Permohonan',
      'petitionDescription':
          'Memohon kepada Tuhan untuk semua kebutuhan kita, pertumbuhan kita, dan orang-orang yang memerlukan keselamatan - 1 Timotius 2:1: Efesus 6:18; Matius 7:7; Mazmur 143:8',
    },
    'ko': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': '끝',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': '주님의 이름 부르기',
      'callingDescription':
          '주의 이름을 불러 생각을 영으로 돌이킴&#8211; 고전12:3; 롬 8:6; 10:12&#8211;13',
      'praying': '기도',
      'prayingDescription':
          '마음을 열고 부드럽게하여 자신을 비우고 주님을 사랑한다고 말함 &#8211; 고후 3:16; 시62:8',
      'prayReading': '기도로 말씀 읽기',
      'prayReadingDescription':
          '훈련된 영을 사용하여 기도로 한  두 구절을 취하고 개인적인 기도로 적용 &#8211; 엡 6:17&#8211;18; 딤후 3:16',
      'confession': '자백',
      'confessionDescription':
          '양심에서 죄들과 잘못을 자백하고 교통을 위해 모든 방해물을 제거하고 죄사함과 정결케함을 구함 &#8211; 요일 1:7, 9; 시 66:18; 사 59:1&#8211;2',
      'consecration': '헌신',
      'consecrationDescription':
          '우리를 점유하시도록 우리 자신을 주님께 다시 드림 &#8211; 롬 12:1&#8211;2; 6:13,19; 막 12:30',
      'thanksgiving': '감사',
      'thanksgivingDescription':
          '모든 것, 모든 사람, 환경, 우리 생활의 모든 것에 감사와 찬양을 드리고 &#8211; 엡 5:20; 살전 5:18',
      'petition': '간구',
      'petitionDescription':
          '주님께 필요, 성장 그리고 구원이 필요한  사람을 구함 &#8211; 1 팀. 2:1: 엡 6:18; 마 7:7; 시 143:8',
    },
    'pt': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Fim',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Invocar o nome do Senhor',
      'callingDescription':
          'Invocar o nome do Senhor para nos ajudar a colocar nossa mente no espírito - 1Co 12:3; Rm 8:6; 10:12-13',
      'praying': 'Orar',
      'prayingDescription':
          'Abrir o nosso coração, amolecê-lo e esvaziar-nos. Dizer-Lhe que O amamos - 2Co 3:16; Sl 62:8',
      'prayReading': 'Orar-ler',
      'prayReadingDescription':
          'Usar nosso espírito exercitado para orar sobre um ou dois versículos. Transformar os versículos em uma oração pessoal - Ef 6:17-18; 2Tm. 3:16',
      'confession': 'Confessar',
      'confessionDescription':
          'Confessar os pecados e ofensas em nossa consciência e remover todas as barreiras à comunhão. Pedir perdão e purificação - 1Jo 1:7, 9; Sl 66:18; Is 59:1-2',
      'consecration': 'Consagrar',
      'consecrationDescription':
          'Apresentar-nos ao Senhor de modo fresco, dando-Lhe todo o terreno em nós - Rm 12:1-2; 6:13,19; Mc 12:30',
      'thanksgiving': 'Agradecer',
      'thanksgivingDescription':
          'Dar graças por todas as coisas; por todas as pessoas, situações e coisas em sua vida e louvá-Lo - Ef 5:20; 1Ts 5:18',
      'petition': 'Pedir',
      'petitionDescription':
          'Pedir ao Senhor por necessidades, crescimento e por pessoas que precisam de salvação - 1Tm 2:1; Ef 6:18; Mt 7:7; Sl 143:8',
    },
    'ru': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Конец',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Призывание',
      'callingDescription':
          'Призывать имя Господа, чтобы обратить свой разум к нашему духу - 1Кор 12:3; Рим. 8:6; 10:12-13',
      'praying': 'Молитва',
      'prayingDescription':
          'Открывать, смягчать своё сердце и опустошать себя - 2Кор. 3:16; Пс. 62:8',
      'prayReading': 'Молитвочтение',
      'prayReadingDescription':
          'Использовать свой дух, чтобы молиться одним или двумя стихами. Обращать стихи в личную молитву - Эф. 6:17-18; 2Тим. 3:16',
      'confession': 'Исповедь',
      'confessionDescription':
          'Исповедовать грехи и проступки на нашей совести и удалять все преграды для общения. Просить и прощении и очищении - 1Ин. 1:7, 9;Пс. 66:18; Ис. 59:1-2',
      'consecration': 'Посвящение',
      'consecrationDescription':
          'По-свежему предоставить себя Господу, давая Ему полное основание в нас - Рим. 12:1-2; 6:13,19; Мк. 12:30',
      'thanksgiving': 'Благодарение',
      'thanksgivingDescription':
          'Воздавать благодарение за всё: за всех людей, все обстоятельства и все вещи в нашей жизни, восхвалять Его - Ef. 5:20; 1 Ts. 5:18',
      'petition': 'Прошение',
      'petitionDescription':
          'Просить Господа в отношении нужд, роста и людей, которые нуждаются в спасении - 1Тим. 2:1; Эф. 6:18; Мф. 7:7; Пс. 143:8',
    },
    'tl': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Wakas',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Tumatawag sa Pangalan ng Panginoon',
      'callingDescription':
          'Tumatawag sa Pangalan ng Panginoon upang ilagak ang ating isip sa espiritu - 1Cor 12:3; Roma 8:6; 10:12-13',
      'praying': 'Nananalangin',
      'prayingDescription':
          'Binubuksan ang ating puso, pinalalambot ang ating puso at binabasyo ang ating sarili.  Sinasabi sa Kanya na iniibig natin Siya - 2Cor 3:16; Awit 62:8',
      'prayReading': 'Pagbabasa-dalangin',
      'prayReadingDescription':
          'Ginagamit ang ating naensayong espiritu upang manalangin hinggil sa isa o dalawang bersikulo. Ginagawang personal na panalangin ang mga bersikulo - Efe 6:17-18; 2Tm. 3:16',
      'confession': 'Nagpapahayag ng mga Kasalanan',
      'confessionDescription':
          'Ipinapahayag ang mga kasalanan at mga pagsalangsang sa ating budhi at inaalis ang lahat ng hadlang sa salamuha. Humihingi ng kapatawaran at paglilinis - 1Juan 1:7, 9; Awit 66:18; Isa 59:1-2',
      'consecration': 'Pag-aalay',
      'consecrationDescription':
          'Muling inihahandog ang ating sarili sa Panginoon, ibinibigay sa Kanya ang buong puwang sa loob natin - Roma 12:1-2; 6:13,19; Marcos 12:30',
      'thanksgiving': 'Pasasalamat',
      'thanksgivingDescription':
          'Nagpapasalamat para sa lahat ng bagay, para sa lahat ng tao, mga sitwasyon at mga bagay sa iyong buhay at nagpupuri sa Kanya - Efe 5:20; 1Tes 5:18',
      'petition': 'Kahilingan',
      'petitionDescription':
          'Humihiling sa Panginoon para sa mga pangangailangan, paglago at mga tao na nangangailangan ng kaligtasan - 1Tim 2:1; Efe 6:18; Mat 7:7; Awit 143:8',
    },
    'uk': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Кінець',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Прикликати Ім\'я Господа',
      'callingDescription':
          'Прикликати Ім\'я Господа для того, щоб повернути свій розум до духа - 1Кор 12:3; Рим. 8:6; 10:12-13',
      'praying': 'Молитва',
      'prayingDescription':
          'Відкривати своє серце, зм\'якшувати своє серце и спустошувати себе. Казати Йому, що ми любимо Його - 2Кор. 3:16; Пс. 62:8',
      'prayReading': 'Молитовне читання',
      'prayReadingDescription':
          'Використовувати наш вправний дух для того, щоб молитися одним або двома віршами. Повернути вірші на особисту молитву - Еф. 6:17-18; 2 Тим. 3:16',
      'confession': 'Сповідь',
      'confessionDescription':
          'Сповідати гріхи та кривди на нашій совісті та прибрати всі перепони для спілкування. Просити прощення і очищення - 1Івана 1:7, 9;Пс. 66:18; Ісая 59:1-2',
      'consecration': 'Посвячення',
      'consecrationDescription':
          'Заново передати самих себе Господу, надаючи Йому повну підставу (щось робити) в нас. - Рим. 12:1-2; 6:13,19; Мк. 12:30',
      'thanksgiving': 'Подяка',
      'thanksgivingDescription':
          'Дякувати за все, за всіх людей, ситуації і за все у вашому житті й славити Його - Еф. 5:20; 1 Солунян 5:18',
      'petition': 'Прохання',
      'petitionDescription':
          'Просити Господа за потреби, зростання та осіб, які потребують спасіння - 1Тим. 2:1; Еф. 6:18; Матвія 7:7; Пс. 143:8',
    },
    'zh': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': '结束',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': '呼求主名',
      'callingDescription': '藉着呼求主名，将心思置於灵 - 林前十二:3; 罗八:6; 十:12-13',
      'praying': '祷告',
      'prayingDescription': '敞开我们的心，软化我们的心并倒空自己，告诉祂：主阿！我爱你 - 林后三:16; 诗六十二:8',
      'prayReading': '祷读',
      'prayReadingDescription':
          '用我们操练过的灵祷读一至二节，把所读的经节化为自己个人的祷告 - 弗六:17-18; 提后三:16',
      'confession': '认罪',
      'confessionDescription':
          '凭着良心承认自己的罪与过犯，除去一切与主交通的拦阻，求主赦免并结净 - 约壹一:7, 9; 诗六十六:18; 赛五十九:1-2',
      'consecration': '奉献',
      'consecrationDescription':
          '更新自己的奉献，并使祂在我们里面得着完全的地位 - 罗十二:1-2; 六:13,19; 可十二:30',
      'thanksgiving': '感谢',
      'thanksgivingDescription': '为着你在日常生活中的一切人，事，物，感谢祂并赞美祂 - 弗五:20; 帖前五:18',
      'petition': '祈求',
      'petitionDescription':
          '为着自己的需要，生命的长大，以及别人的得救，向主祈求 - 提前二:1: 弗六:18; 太七:7; 诗一百四十三:8',
    },
    'zt': {
      'appTitle': '7 Minutes With The Lord',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': '呼求主名',
      'callingDescription': '藉着呼求主名，將心思置於靈 - 林前十二:3; 羅八:6; 十:12-13',
      'praying': '禱告',
      'prayingDescription': '敞開我們的心，軟化我們的心並倒空自己，告訴祂: 主阿！我愛你 -林後三:16; 詩六十二:8',
      'prayReading': '禱讀',
      'prayReadingDescription':
          '用我們操練過的靈禱讀一至二節, 把所讀的經節化爲自己個人的禱告 - 弗六:17-18; 提後三:16',
      'confession': '認罪',
      'confessionDescription':
          '憑着良心承認自己的罪與過犯，除去一切與主交通的攔阻，求主赦免並潔凈 - 約壹一:7, 9; 詩六十六18；賽五十九1-2',
      'consecration': '奉獻',
      'consecrationDescription':
          '更新自己的奉獻，並使祂在我們裏面得着完全的地位 - 羅十二:1-2; 六:13,19; 可十二:30',
      'thanksgiving': '感謝',
      'thanksgivingDescription': '爲着你在曰常生活中的一切人，事，物，感謝祂並讚美祂 - 弗五:20; 帖前五:18',
      'petition': '祈求',
      'petitionDescription':
          '爲着自己的需要，生命的長大，以及别人的得救，向主祈求 - 提前二:1: 弗六:18; 太七:7; 詩一百四十三:8',
    },
    'fa': {
      'appTitle': '٧ دقیقه با خداوند',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'صدا زدن نام خداوند',
      'callingDescription':
          'صدا زدن نام خداوند برای  گذاشتن فکر بر روح. اول قرنتیان ٣:١٢؛ رومیان ۶:٨؛ ١٢:١٠-١٣',
      'praying': 'دعا کردن',
      'prayingDescription':
          'باز کردن قلبمان، نرم کردن قلبمان و خالی کردن خودمان. به خداوند بگوییم که عاشق او هستیم. دوم قرنتیان ١۶:٣؛ مزمور ٨:۶٢',
      'prayReading': 'دعایی-خواندن',
      'prayReadingDescription':
          'بکار گیری روح پرورش یافته خود، برای دعا کردن یک یا دو آیه. چرخاندن آیه ها به یک دعای شخصی - افسسیان ١٧:۶-١٨؛ دوم تیموتائوس ١۶:٣',
      'confession': 'اعتراف کردن',
      'confessionDescription':
          'اعتراف کردن به گناهان و خطاهای وجدان خود و برداشتن تمام موانع برای مشارکت. درخواست برای بخشش و پاکسازی - اول یوحنا ٧:١، ٩؛ مزمور ١٨:۶۶؛ اشعیاء ١:۵٩-٢',
      'consecration': 'وقف شدن',
      'consecrationDescription':
          'تقدیم کردن خودمان به خداوند بطور تازه، یعنی کاملا در خودمان به او میدان دهیم - رومیان ١:١٢-٢؛ ١٣:۶، ١٩؛ مرقس ٣٠:١٢',
      'thanksgiving': 'سپاسگزاری',
      'thanksgivingDescription':
          'شاکر بودن برای همه چیز؛ برای همهٔ اشخاص، موقعیت ها و موارد در زندگی شما و ستایش کردن خداوند - افسسیان ٢٠:۵؛ اول تسالونیکیان ١٨:۵',
      'petition': 'دادخواست',
      'petitionDescription':
          'درخواست کردن از خداوند برای نیازها، رشد و اشخاصی که نیاز به نجات دارند - اول تیموتائوس ١:٢؛ افسسیان ۱۸:۶؛ متی ٧:٧؛ مزمور ٨:١۴٣',
    },
    'pl': {
      'appTitle': 'Siedem minut z Panem',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'Wzywanie',
      'callingDescription':
          'Wzywanie imienia Pana, by nastawić swój umysł na ducha – 1 Kor 12:3; Rz 8:6; 10:12-13 (1/2 minuty)',
      'praying': 'Modlitwa',
      'prayingDescription':
          'Otwarcie serca, zmiękczenie serca i opustoszenie siebie. Wyznanie Panu, że Go kochamy – 2 Kor 3:16; Ps 62:9 (1 minuta)',
      'prayReading': 'Modlitewne czytanie',
      'prayReadingDescription':
          'Używanie wyćwiczonego ducha do modlitwy jednym lub dwoma wersetami. Uczynienie treści wersetów osobistą modlitwą – Ef 6:17-18; 2 Tm 3:16 (2 1/2 minuty)',
      'confession': 'Wyznawanie',
      'confessionDescription':
          'Wyznanie grzechów i przewinień, których jesteśmy świadomi oraz usunięcie wszystkiego, co blokuje społeczność. Prośba o przebaczenie i oczyszczenie – J 1:7, 9; Ps 66:18; Iz 59:1-2 (1 minuta)',
      'consecration': 'Poświęcenie',
      'consecrationDescription':
          'Ofiarowanie się Panu na nowo, przekazanie Mu pełnego prawa do nas – Rz 12:1-2; 6:13, 19; Mk 12:30 (1/2 minuty)',
      'thanksgiving': 'Dziękczynienie',
      'thanksgivingDescription':
          'Podziękowanie za wszystko: wszystkie osoby, sytuacje, rzeczy w naszym życiu oraz chwalenie Pana – Ef 5:20; 1 Tes 5:18 (1/2 minuty)',
      'petition': 'Prośba',
      'petitionDescription':
          'Prośba o to, czego potrzebujemy, o wzrost, a także o osoby, które potrzebują zbawienia – 1 Tm 2:1; Ef 6:18; Mt 7:7; Ps 143:8 (1 minuta)',
    },
    'ta': {
      'appTitle': 'கர்த்தருடன் 7 நிமிடங்கள்',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'கர்த்தருடைய நாமத்தை நோக்கி கூப்பிடுதல்',
      'callingDescription':
          'ஆவியின்மீது நம் மனதை பொருத்த கர்த்தருடைய நாமத்தை நோக்கி கூப்பிடுதல் – 1 கொரி. 12:3, ரோ. 8:6; 10:12-13',
      'praying': 'ஜெபித்தல்',
      'prayingDescription':
          'நம் இருதயத்தை திறந்து, நம் இருதயத்தை மிருதுவாக்கி, நம்மைநாமே வெறுமையாக்குதல். நாம் அவரை நேசிக்கிறோம் என்று அவரிடம் கூறுதல் – 2 கொரி. 3:16; சங். 62:8',
      'prayReading': 'ஜெப-வாசிப்பு',
      'prayReadingDescription':
          'நம் பயிற்றுவிக்கப்பட்ட ஆவியை பயன்படுத்தி ஒன்று அல்லது இரண்டு வசனத்தை ஜெபித்தல். வசனங்களை தனிப்பட்ட ஜெபமாக மாற்றுதல் – எபே. 6:17-18; 2 தீமோ. 3:16',
      'confession': 'அறிக்கையிடுதல்',
      'confessionDescription':
          'நம் மனச்சாட்சியில் இருக்கும் பாவங்களையும், குற்றங்களையும் அறிக்கைசெய்து, ஐக்கியத்திற்கான எல்லா தடைகளையும் அகற்றுதல். மன்னிக்கப்படும்படியும் கழுவப்படும்படியும் கேட்குதல் – 1 யோவான் 1:7, 9; சங். 66:18; ஏசா. 59:1-2',
      'consecration': 'அர்ப்பணித்தல்',
      'consecrationDescription':
          'கர்த்தருக்கு நம்மையே பசுமையாக ஒப்புக்கொடுத்து, நம்மில் முழு தளத்தை அவருக்கு கொடுத்தல் – ரோ. 12:1-2; 6:13, 19; மாற். 12:30',
      'thanksgiving': 'நன்றிக்கூறுதல்',
      'thanksgivingDescription':
          'எல்லா காரியங்களுக்காகவும் நன்றி செலுத்துதல்; எல்லா நபர்களுக்காகவும், சூழ்நிலைகளுக்காகவும், உன் வாழ்க்கையில் உள்ள காரியங்களுக்காகவும் அவரை துதித்தல் – எபே. 5:20; 1 தெச. 5:18',
      'petition': 'விண்ணப்பித்தல்',
      'petitionDescription':
          'தேவைக்காகவும், வளர்ச்சிக்காகவும், இரட்சிப்பு தேவைப்படுகிற நபர்களுக்காகவும் கர்த்தரிடம் கேட்குதல் – 1 தீமோ. 2:2; எபே. 6:18; மத். 7:7; சங். 143:8',
    },
    'ka': {
      'appTitle': '7 წუთი უფალთან',
      'start': 'Start!',
      'goBack': 'Go back',
      'language': 'Language',
      'completed': 'Completed',
      'next': 'Next',
      'allActivitiesCompleted': 'All activities completed',
      'calling': 'უფლის სახელის მოხმობა',
      'callingDescription':
          'მოვუხმოთ უფლის სახელს, რათა მოვმართოთ ჩვენი გონება სულისკენ – 1 კორ. 12:3; რომ. 8:6; 10:12-13',
      'praying': 'ლოცვა',
      'prayingDescription':
          'გავხსნათ ჩვენი გული, დავირბილოთ ჩვენი გული და გამოვიცარიელოთ საკუთარი თავები. ვუთხრათ უფალს, რომ გვიყვარს ის – 2 კორ. 3:16; ფსალ. 61:8',
      'prayReading': 'ლოცვა-კითხვა',
      'prayReadingDescription':
          'გამოვიყენოთ ჩვენი ნავარჯიშები სული, რათა ვილოცოთ ერთი ან ორი მუხლით. გადავაქციოთ მუხლები პირად ლოცვად – ეფ. 6:17-18; 2 ტიმ. 3:16',
      'confession': 'აღიარება',
      'confessionDescription':
          'ვაღიაროთ ცოდვები და დანაშაულები ჩვენს სინდისში და მოვიშოროთ ყველაფერი, რაც აბრკოლებს ურთიერთობას. ვითხოვოთ პატიება და გაწმენდა – 1 იოანე 1:7, 9; ფსალ. 65:18; ეს. 59:1-2',
      'consecration': 'თავის მიძღვნა',
      'consecrationDescription':
          'წარვუდგინოთ ჩვენი თავი უფალს ახლებურად, მივცეთ მას სრული ნიადაგი – რომ. 12:1-2, 6:13, 19; მარკ. 12:30',
      'thanksgiving': 'მადლიერება',
      'thanksgivingDescription':
          'იყავით ყველაფრისთვის მადლიერი; ყველა ადამიანისთვის, სიტუაციისათვის და ყველაფრისთვის თქვენს ცხოვრებაში, და აქეთ ის – ეფ. 5:20; 1 თეს. 5:18',
      'petition': 'შუამდგომლობა',
      'petitionDescription':
          'ვილოცოთ უფლის წინაშე საჭიროებებისთვის, სიცოცხლეში ზრდისთვის და ადამიანებისთვის, რომლებსაც გადარჩენა სჭირდებათ – 1 ტიმ. 2:1; ეფ. 6:18; მათე 7:7; ფსალ. 142:8',
    },
    'ja': {
      'appTitle': '主と共に7分間',
      'start': '開始！',
      'goBack': '戻る',
      'language': '言語',
      'completed': '完了',
      'next': '次へ',
      'allActivitiesCompleted': 'すべてのアクティビティが完了しました',
      'calling': '呼び求める',
      'callingDescription':
          '主の御名を呼び求めることによって、私たちの思いを霊に付けます―1コリ12:3;ローマ8:6; 10:12-13 (1/2分間)',
      'praying': '祈り',
      'prayingDescription':
          '私たちの心を開き、心を柔らかくし、私たち自身を空にします。私たちが彼を愛していることを伝えます－2 コリ 3:16; 詩篇. 62:8 (1 分間)',
      'prayReading': '祈り読み',
      'prayReadingDescription':
          '活用された霊を用いて１～２節の御言葉を用いて祈りましょう。その節を個人的な祈りに転換しましょう－エペソ6:17-18; 2 テモテ3:16 (2分半)',
      'confession': '告白する',
      'confessionDescription':
          '自分の良心にある罪と過ちを告白し、交わりを妨げるものをすべて取り除き、赦しと清めを求めます－ 1 ヨハネ1:7, 9; 詩篇66:18; イザヤ59:1-2 (1 分間)',
      'consecration': '献身',
      'consecrationDescription':
          '主に新たに自分自身を捧げ、私たちの中ですべての立場を主に捧げます－ローマ 12:1-2; 6:13,19; マルコ 12:30 (1/2 分間)',
      'thanksgiving': '感謝をささげる',
      'thanksgivingDescription':
          'すべてのことに感謝をささげて、すべての人、状況、物事に感謝し、神を賛美します－エペソ5:20; 1 テサ 5:18 (1/2 分間)',
      'petition': 'とりなし',
      'petitionDescription':
          '必要、成長、救いが必要な人のために主に祈ります－1 テモテ2:1: エペソ6:18;マタイ7:7; 詩篇143:8 (1 分間)',
    },
    // 'template': {
    //   'appTitle': '7 Minutes With The Lord',
    //   'start': 'Start!',
    //   'goBack': 'Go back',
    //   'language': 'Language',
    //   'completed': 'Completed',
    //   'next': 'Next',
    //   'allActivitiesCompleted': 'All activities completed',
    //   'calling': '',
    //   'callingDescription': '',
    //   'praying': '',
    //   'prayingDescription': '',
    //   'prayReading': '',
    //   'prayReadingDescription': '',
    //   'confession': '',
    //   'confessionDescription': '',
    //   'consecration': '',
    //   'consecrationDescription': '',
    //   'thanksgiving': '',
    //   'thanksgivingDescription': '',
    //   'petition': '',
    //   'petitionDescription': '',
    // },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Get locale display name
  String getLanguageDisplayName() {
    switch (locale.languageCode) {
      case 'ar':
        return 'عربي';
      case 'de':
        return 'Deutsch';
      case 'es':
        return 'Español';
      case 'id':
        return 'Bahasa Indonesia';
      case 'ko':
        return '한국어';
      case 'pt':
        return 'Portuguese';
      case 'ru':
        return 'русский язык';
      case 'uk':
        return 'українська мова';
      case 'tl':
        return 'Tagalog';
      case 'zt':
        return '中文(繁體)';
      case 'zh':
        return '中文(简体)';
      case 'ja':
        return '日本語';
      case 'en':
      default:
        return 'English';
    }
  }

  // Get all supported languages
  static List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'ar', 'name': 'عربي'},
      {'code': 'id', 'name': 'Bahasa Indonesia'},
      {'code': 'zh', 'name': '中文(简体)'},
      {'code': 'zt', 'name': '中文(繁體)'},
      {'code': 'de', 'name': 'Deutsch'},
      {'code': 'en', 'name': 'English'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'es', 'name': 'Español'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'pt', 'name': 'Portuguese'},
      {'code': 'ru', 'name': 'русский язык'},
      {'code': 'tl', 'name': 'Tagalog'},
      {'code': 'uk', 'name': 'українська мова'},
    ];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'ar',
      'en',
      'de',
      'es',
      'id',
      'ko',
      'pt',
      'ru',
      'tl',
      'uk',
      'zh',
      'zt',
      'ja',
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
