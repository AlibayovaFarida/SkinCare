//
//  SkinProblemDetailsViewController.swift
//  Skincare-app
//
//  Created by Apple on 19.09.24.
//

import UIKit

class SkinProblemDetailsViewController: UIViewController {
    private var problemName: String? = ""
    private var datas: [AccordionCellModel] = []
    let rosaceaData: [AccordionCellModel] = [
        .init(question: "Rosacea (Rozaseya) nədir?", answer: "Rosacea, üzün əsasən yanaqlar, burun, alın və çənə hissəsində qızartı, qan damarlarının genişlənməsi və bəzən sızanaqlara bənzər iltihablı səpgilər ilə müşayiət olunan xroniki dəri xəstəliyidir. Xəstəlik xüsusilə yetkinlər arasında yaygındır və gözlərdə də qıcıqlanma, qızartı və yanma hissi yarada bilər."),
        .init(question: "Rosaceanın növləri hansılardır?", answer: """
              Rosaceanın müxtəlif növləri mövcuddur:
              - Eritematotelangiektatik rozaseya: Üzdə qalıcı qızartı və qan damarlarının genişlənməsi ilə müşayiət edilir.
              - Papulopüstüler rozaseya: Üzdə sızanaqlara bənzər iltihablı səpgilər əmələ gəlir.
              - Fimatöz rozaseya: Dəridə qalınlaşma, xüsusilə burun nahiyəsində deformasiyalar yaradır.
              - Oftalmik rozaseya: Gözlərdə yanma, qıcıqlanma və qızartı ilə müşayiət edilir.
            """),
        .init(question: "Rosaceanın yaranma səbəbləri:", answer: "Rosaceanın dəqiq səbəbi bilinməsə də, genetik meyllilik, dəri və qan damarlarının həssaslığı, həmçinin günəş işığı, alkoqol və baharatlı qidalar kimi faktorlar xəstəliyin inkişafını təşviq edə bilər."),
        .init(question: "Rosaceanın əlamətləri:", answer: "Əsas əlamətlər üzün mərkəzi hissəsində qızartı, genişlənmiş qan damarları, bəzən papulalar və püstüllər, gözlərdə qıcıqlanma və iltihabdır. Dəri bəzən yanma və qaşınma hissi verə bilər."),
        .init(question: "Rosacea necə müalicə olunur?", answer: "Rosaceanın müalicəsi topikal antibiotiklər, iltihab əleyhinə dərmanlar və lazer terapiyasını əhatə edir. Xəstələr həmçinin günəşdən qoruyucu kremlərdən istifadə etməli və xəstəliyi şiddətləndirən faktorlar, məsələn, günəş işığı və baharatlı qidalardan uzaq durmalıdırlar."),
        .init(question: "Rosaceanın qarşısını necə almaq olar?", answer: "Günəşdən qoruyucu kremlərdən mütəmadi istifadə etmək, stresdən qaçmaq və həssas dəriyə uyğun yumşaq məhsullardan istifadə rosaceanın ağırlaşmasının qarşısını ala bilər."),
    ]
    let acneData: [AccordionCellModel] = [
        .init(question: "Akne nədir?", answer: "Sızanaq əri məsamələrinin tıxantığı ümumi bir dəri xəstəliyidir. Məsamələrin tıxanması qara nöqtələr, ağ nöqtələr və digər növ sızanaqlar yaradır. Sızanaqlar dərinizdə irinlə dolu, bəzən ağrılı,\nqabardır.\nSızanaq üçün tibbi termin acne\nvulgarisdir."),
        .init(question: "Aknenin növləri hansılardır?", answer: "Sızanaqların bir neçə növü var, o cümlədən:\n\n\u{2022} Göbələk sızanaqları (pityrosporum folliculitis): Göbələk sızanaqları saç follikullarınızda maya yığıldıqda meydana gəlir. Bunlar qaşınma və iltihab ola bilər.\n\u{2022} Kistik sızanaq: Kistik sızanaq dərin, irinli sızanaq və düyünlərə səbəb olur. Bunlar çapıqlara səbəb ola bilər.\n\u{2022} Hormonal sızanaqlar: Hormonal sızanaqlar məsamələrini tıxayan sebum həddindən artıq istehsalı olan yetkinləri təsir edir.\n\u{2022} Düyünlü sızanaq: Düyünlü sızanaq dərinin səthində sızanaqlara və dəriniz altında həssas, düyünlü topaqlara səbəb olan sızanaqların ağır formasıdır.\nSızanaqların bütün bu formaları özünə hörmətinizə təsir edə bilər və həm kistik, həm də düyünlü sızanaqlar çapıq şəklində qalıcı dəri zədələnməsinə səbəb ola bilər. Ən yaxşısı sizin üçün ən yaxşı müalicə variantını müəyyən edə bilməsi üçün bir tibb işçisindən erkən kömək istəməkdir."),
        .init(question: "Aknenin yaranma səbəbləri", answer: "Tıxanmış saç kökləri və ya məsamələri sızanaqlara səbəb olur. Saç follikullarınız saçınızın bir telini saxlayan kiçik borulardır. Saç follikullarınıza boşaldılan bir neçə vəzi var. Saç follikulunun içərisində çoxlu material olduqda, bir tıxanma meydana gəlir. Məsamələriniz tıxaya bilər:\n\n\u{2022} Sebum: Dəriniz üçün qoruyucu bir maneə təmin edən yağlı bir maddə.\n\u{2022} Bakteriyalar: Dərinizdə təbii olaraq az miqdarda bakteriya yaşayır. Əgər çox bakteriya varsa, məsamələrinizi bağlaya bilər.\n\u{2022} Ölü dəri hüceyrələri: Dəri hüceyrələriniz daha çox hüceyrənin böyüməsi üçün yer açmaq üçün tez-tez tökülür. Dəriniz ölü dəri hüceyrələrini buraxdıqda, onlar saç follikullarınızda ilişib qala bilər.\nMəsamələriniz tıxandıqda, maddələr saç folikülünüzü bağlayır və sızanaq yaradır. Bu, ağrı və şişkinlik kimi hiss etdiyiniz iltihabı tetikler. Siz həmçinin sızanaq ətrafındakı qızartı kimi dərinin rəngsizləşməsi ilə iltihabı görə bilərsiniz."),
        .init(question: "Aknenin əlamətləri hansılardır?", answer: "Dərinizdə sızanaqların əlamətlərinə aşağıdakılar daxildir:\n\n\u{2022} Sızanaqlar (püstüllər): İrinlə dolu qabarlar (papüllər).\n\u{2022} Papüllər: Kiçik, rəngi dəyişmiş qabar, tez-tez qırmızıdan bənövşəyi və ya təbii dəri tonunuzdan daha tünd.\n\u{2022} Qara nöqtələr: Tıxanmış məsamələr qara üstü ilə.\n\u{2022} Ağ başlıqlar: Üstü ağ olan tıxanmış məsamələr.\n\u{2022} Düyünlər: Dərinizin altında ağrılı olan böyük topaklar.\n\u{2022} Kistlər: Dərinizin altında maye ilə dolu ağrılı (irinli) topaklar.\nSızanaqlar yüngül ola bilər və bir neçə arabir sızanaqlara səbəb ola bilər və ya orta dərəcədə iltihablı papüllərə səbəb ola bilər. Şiddətli sızanaqlar düyünlərə və kistlərə səbəb olur."),
        .init(question: "Akne necə müalicə olunur?", answer: "Aknə müalicəsi üçün:\n\n1. Dəriyə qulluq məhsulları: Salitsil turşusu, benzoyl peroksid, retinoidlər.\n2. Dərmanlar: Antibiotiklər, hormon tənzimləyici dərmanlar, izotretinoin.\n3. Həkim prosedurları: Kimyəvi pilinq, lazer terapiyası, steroid inyeksiyaları.\n4. Qidalanma və həyat tərzi: Sağlam qida, çox su içmək, dərini nəmləndirmək.\n5. Təbii vasitələr: Çay ağacı yağı, aloe vera, yaşıl çay ekstraktları.\n5. Təbii vasitələr: Çay ağacı yağı, aloe vera, yaşıl çay ekstraktları.\n7. Məsamələrin təmizlənməsi: Skrab və maskalar."),
        .init(question: "Aknenin yaranmasının qarşısını almaq", answer: "Aknenin yaranmasının qarşısını almaq üçün:\n\n\u{2022} Dəri təmizliyinə diqqət edin, gün ərzində iki dəfə yumşaq təmizləyici ilə yuyun.\n\u{2022} Yağsız, komedogenik olmayan (məsamələri tıxamayan) nəmləndiricilər və günəşdən qoruyucu kremlər istifadə edin.\n\u{2022} Üzə tez-tez toxunmaqdan çəkinin və əl təmizliyinə diqqət edin.\n\u{2022} Sağlam qidalanmaya önəm verin, şəkərli və yağlı qidalardan uzaq durun.\n\u{2022} Çox su için və dərini nəmli saxlayın.\n\u{2022} Stressi idarə edin, çünki stres aknəni pisləşdirə bilər.\n\u{2022} Tez-tez yastıq üzlərini və dəsmalları dəyişin.\n\u{2022} Dərman vasitələrini və ya kosmetik məhsulları istifadə etməzdən əvvəl dermatoloqla məsləhətləşin.")
    ]
    
    let melazmaData: [AccordionCellModel] = [
        .init(question: "Melazma nədir?", answer: "Melazma, üz dərisində tünd rəngli ləkələrin yaranması ilə müşayiət olunan bir pigmentasiya pozğunluğudur. Bu ləkələr adətən yanaqlar, alın və üst dodaq nahiyəsində görünür və əsasən hamiləlik dövründə, hormonal dəyişikliklər və ya günəşə həddindən artıq məruz qalma nəticəsində yaranır."),
        .init(question: "Melazmanın növləri hansılardır?", answer: """
            Melazmanın əsas iki növü var:
                - Epidermal melazma: Dərinin üst təbəqəsində daha açıq və aydın sərhədləri olan ləkələr.
                - Dermal melazma: Dərinin dərin təbəqələrində daha tünd və müalicəsi çətin olan ləkələr.
            """),
        .init(question: "Melazmanın yaranma səbəbləri:", answer: "Hormonal dəyişikliklər (hamiləlik, kontraseptiv dərmanlar), günəş işığına məruz qalma və genetik meyllilik melazmanın əsas yaranma səbəbləri arasındadır. "),
        .init(question: "Melazmanın əlamətləri:", answer: "Üzdə, xüsusilə yanaq, alın və dodaq üstü nahiyədə tünd rəngli, simmetrik ləkələr əsas əlamət kimi ortaya çıxır. Bu ləkələr bəzən bir qədər qaşıntılı ola bilər, amma ümumiyyətlə ağrısızdır."),
        .init(question: "Melazma necə müalicə olunur?", answer: "Melazmanın müalicəsi əsasən topikal dərmanlar, hidrokinon tərkibli kremlər, kimyəvi pilinqlər və lazer terapiyası ilə aparılır. Həmçinin günəşdən qoruyucu kremlərdən istifadə çox vacibdir."),
        .init(question: "Melazmanın qarşısını necə almaq olar?", answer: "Melazmanın qarşısını almaq üçün günəşdən qoruyucu kremlərdən mütəmadi istifadə edilməli, günəş işığından uzaq durmalı və hormonal balansın qorunmasına diqqət edilməlidir."),
    ]
    
    let ekzemaData: [AccordionCellModel] = [
        .init(question: "Ekzema nədir?", answer: "Ekzema, dəridə iltihablanma, qaşınma və qabıqlanma ilə müşayiət olunan xroniki bir dəri xəstəliyidir. Bu xəstəlik əsasən allergik reaksiya nəticəsində meydana gəlir və çox vaxt quru dəri, qızartı və qaşıntı ilə xarakterizə olunur."),
        .init(question: "Ekzemanın növləri hansılardır?", answer: """
            Ekzema bir neçə formaya malikdir:
            - Atopik dermatit: Ən geniş yayılmış ekzema növü olub, uşaqlıqda başlayır və çox vaxt allergiyalarla əlaqələndirilir.
            - Kontakt dermatit: Qıcıqlandırıcı maddələrlə təmas nəticəsində yaranan dəri iltihabıdır.
            - Seboreik dermatit: Daha çox saç dərisi və yağlı dəri bölgələrində müşahidə olunur və qızartı ilə müşayiət edilir.
            """),
        .init(question: "Ekzemanın yaranma səbəbləri:", answer: "Ekzemanın əsas səbəbi genetik meyllilik və allergik reaksiyalardır. Eyni zamanda, stress, quru hava və müəyyən qidalar da ekzemanın yaranmasını təşviq edə bilər."),
        .init(question: "Ekzemanın əlamətləri:", answer: "Dəridə qızartı, şiddətli qaşınma, quruluq və qabıqlanma əsas əlamətlərdir. Bəzən sulu qabarcıqlar və ya çatlar da yaranır."),
        .init(question: "Ekzema necə müalicə olunur?", answer: "Ekzemanın müalicəsi üçün iltihab əleyhinə kremlər, dərini nəmləndirən məhsullar və antihistaminiklər istifadə edilir. Qaşınmanın qarşısını almaq və dərini qıcıqlandıran maddələrdən uzaq durmaq vacibdir."),
        .init(question: "Ekzemanın qarşısını necə almaq olar?", answer: "Dərini mütəmadi olaraq nəmləndirmək, qaşınmaya səbəb olan qıcıqlandırıcılardan qaçmaq və yumşaq təmizləyicilərdən istifadə ekzemanın şiddətlənməsinin qarşısını alır."),
    ]
    
    let seboreikData: [AccordionCellModel] = [
        .init(question: "Seboreik dermatit nədir?", answer: "Seboreik dermatit, saç dərisində və üz nahiyəsində yağlı və qızarmış qabıqlarla müşayiət olunan xroniki dəri xəstəliyidir. Bu xəstəlik xüsusilə yağlı dəriyə sahib insanlarda daha çox müşahidə olunur və qızartı, qaşınma və yağlılıq ilə xarakterizə edilir."),
        .init(question: "Seboreik dermatitin növləri hansılardır?", answer: """
        Seboreik dermatitin əsasən iki növü var:
        - Körpələrdə (beşik qapağı): Baş dərisində qalın, yağlı qabıqlarla müşayiət olunur.
        - Böyüklərdə: Saç dərisi, qaşlar və burun ətrafı nahiyələrdə qızartı və yağlı qabıqlar yaranır.
        """),
        .init(question: "Seboreik dermatitin yaranma səbəbləri:", answer: "Seboreik dermatitin səbəbi Malassezia adlı maya göbələyi və dəri yağlarının artıq ifrazı ilə bağlıdır. Həmçinin stress, hormonal dəyişikliklər və soyuq hava xəstəliyin şiddətini artıra bilər."),
        .init(question: "Seboreik dermatitin əlamətləri:", answer: "Dəridə qızarmış, yağlı və qabıqlanmış nahiyələr, şiddətli qaşınma və dərinin yağlı olması əsas əlamətlərdir. Körpələrdə baş dərisində qalın, sarımtıl qabıqlar müşahidə olunur."),
        .init(question: "Seboreik dermatit necə müalicə olunur?", answer: "Seboreik dermatitin müalicəsi üçün antifungal şampunlar, kortikosteroidlər və iltihab əleyhinə dərmanlar istifadə olunur. Dərinin müntəzəm təmizlənməsi və stressdən uzaq durmaq xəstəliyin şiddətini azalda bilər."),
        .init(question: "Seboreik dermatitin qarşısını necə almaq olar?", answer: "Seboreik dermatitin qarşısını almaq üçün düzgün dəri təmizliyi, yağlı dəriyə uyğun məhsullardan istifadə"),
    ]
    
    let cancerData: [AccordionCellModel] = [
        .init(question: "Dəri xərçəngi nədir?", answer: "Dəri xərçəngi, dəridəki hüceyrələrin nəzarətsiz şəkildə böyüməsi nəticəsində yaranan bir xəstəlikdir. Dəri xərçəngi əsasən dərinin günəşə məruz qalan hissələrində inkişaf edir, lakin bədənin hər hansı bir nahiyəsində də yarana bilər. Əsas növləri bazal hüceyrəli, yastı hüceyrəli və melanomadır."),
        .init(question: "Dəri xərçənginin növləri hansılardır?", answer: """
        Dəri xərçənginin əsas üç növü mövcuddur:
        - Bazal hüceyrəli karsinoma: Ən geniş yayılmış növdür. Adətən üzdə və günəşə məruz qalan digər nahiyələrdə yaranır. Yavaş böyüyür və metastaz etmə ehtimalı azdır.
        - Yastı hüceyrəli karsinoma: Həmçinin günəşə məruz qalan bölgələrdə yaranır, lakin daha aqressiv ola bilər və bədənin digər nahiyələrinə yayılma ehtimalı daha yüksəkdir.
        - Melanoma: Dəri xərçənginin ən aqressiv növüdür və dəridəki melanositlərdən (piqment hüceyrələrindən) əmələ gəlir. Melanoma tez-tez qəhvəyi və ya qara ləkələr şəklində görünür.
        """),
        .init(question: "Dəri xərçənginin yaranma səbəbləri:", answer: "Dəri xərçənginin əsas səbəbi ultrabənövşəyi (UV) şüalara məruz qalmaqdır. Uzun müddət günəş altında olmaq və ya solaryumdan istifadə etmək xərçəng riskini artırır. Genetik meyllilik və dəri tipi də xəstəliyin yaranmasında rol oynaya bilər."),
        .init(question: "Dəri xərçənginin əlamətləri:", answer: """
        - Üz və bədənin günəşə məruz qalan nahiyələrində yaranan dəridə qırmızı, ağrısız qabarcıqlar.
        - Dəri üzərində açıq yaralar və ya sağalmayan yara izləri.
        - Dəridə qara və ya tünd rəngli ləkələr (xüsusilə melanomada).
        - Xalların formasında və rəngində dəyişikliklər.
        """),
        .init(question: "Dəri xərçəngi necə müalicə olunur?", answer: "Dəri xərçənginin müalicəsi xərçəngin növü və mərhələsinə görə dəyişir. Əsas müalicə üsulları cərrahiyyə (şişin çıxarılması), radiasiya terapiyası və kimyəvi terapiyadır. Erkən mərhələdə diaqnoz qoyulduqda, müalicə çox vaxt uğurlu olur."),
        .init(question: "Dəri xərçənginin qarşısını necə almaq olar?", answer: "Dəri xərçənginin qarşısını almaq üçün günəşdən qoruyucu kremlərdən istifadə edilməli, günəşin ən intensiv olduğu saatlarda açıq havada olmaqdan çəkinməli və solaryumdan istifadə edilməməlidir. Həmçinin, dəridəki hər hansı dəyişikliklər mütəmadi olaraq yoxlanılmalı və şübhəli hallarda dermatoloqa müraciət edilməlidir."),
    ]
    
    let rednessData: [AccordionCellModel] = [
        .init(question: "Qızartı (Eritema) nədir?", answer: "Eritema, dəri səthində yaranan qızartıdır və müxtəlif xəstəliklər, iltihablar və ya allergik reaksiyalar nəticəsində meydana gələ bilər. Qızartı adətən dəridə qan damarlarının genişlənməsi və dərinin iltihablanması ilə bağlıdır."),
        .init(question: "Qızartının növləri hansılardır?", answer: """
        Qızartı (eritema) fərqli xəstəliklərlə əlaqəli ola bilər, məsələn:
        - **Ertema multiforme:** Dərinin müxtəlif səpgilərlə örtülməsi ilə müşayiət olunur və çox vaxt dərinin allergik reaksiyası ilə bağlıdır.
        - **Ertema nodozum:** Dərinin altındakı yağa iltihabın təsir etməsi nəticəsində yaranan ağrılı qırmızı şişkinliklərdir. Adətən bədəndə xüsusilə ayaqların ön hissəsində görünür.
        - **Rosacea ilə əlaqəli qızartı:** Üzün ortasında qızartı, genişlənmiş qan damarları və sızanaqlarla müşayiət edilən xroniki dəri xəstəliyi.
        """),
        .init(question: "Qızartının yaranma səbəbləri:", answer: """
        Qızartı müxtəlif səbəblərdən yarana bilər, o cümlədən:
        - Günəşə məruz qalma və ya yanma
        - Allergik reaksiyalar (qidalar, dərmanlar və ya kosmetik vasitələr)
        - İnfeksiyalar (məsələn, virus və ya bakteriyaların yaratdığı xəstəliklər)
        - İltihablı dəri xəstəlikləri (rosacea, ekzema və s.)
        - Fiziki təsirlər (isti hava, intensiv idman və s.)
        """),
        .init(question: "Qızartının əlamətləri:", answer: "Dəridə qızartı, bəzən yanma və ya qaşınma hissi yarana bilər. Qızartı çox vaxt lokal olaraq müşahidə edilir, lakin bəzi hallarda bütün bədən səthinə yayıla bilər."),
        .init(question: "Qızartı necə müalicə olunur?", answer: "Müalicə qızartının səbəbindən asılıdır. Allergik reaksiya və ya iltihab nəticəsində yaranan qızartılar üçün antihistaminlər və ya iltihab əleyhinə dərmanlar istifadə edilə bilər. Günəş yanığı və ya istilik nəticəsində yaranan qızartı üçün isə soyuducu kremlər və günəşdən qorunmaq tövsiyə edilir."),
        .init(question: "Qızartının qarşısını necə almaq olar?", answer: "Qızartının qarşısını almaq üçün dəriyə qulluq etmək, allergiyaya səbəb olan maddələrdən qaçmaq və günəşdən qoruyucu vasitələrdən istifadə etmək vacibdir. Stressin idarə olunması və qıcıqlandırıcı məhsullardan uzaq durmaq da önəmlidir."),
    ]
    
    let vitiligoData: [AccordionCellModel] = [
        .init(question: "Vitiliqo nədir?", answer: "Vitiliqo, dəridəki melanositlərin (piqment istehsal edən hüceyrələrin) zədələnməsi nəticəsində yaranan bir xəstəlikdir və bu, dəridə açıq rəngli ləkələrin yaranmasına səbəb olur. Bu ləkələr bədənin müxtəlif hissələrində görünə bilər və tədricən genişlənə bilər."),
        .init(question: "Vitiliqonun növləri hansılardır?", answer: """
        Vitiliqo bir neçə formada yaranır:
        - **Fokal vitiliqo:** Ləkələr bədənin bir və ya bir neçə məhdud nahiyəsində meydana gəlir.
        - **Generalizə edilmiş vitiliqo:** Ləkələr bədənin müxtəlif hissələrinə yayılır.
        - **Segmental vitiliqo:** Ləkələr bədənin bir tərəfində və ya bir hissəsində yaranır.
        """),
        .init(question: "Vitiliqonun yaranma səbəbləri:", answer: "Vitiliqonun dəqiq səbəbi məlum deyil, lakin bunun otoimmün xəstəlik olduğu düşünülür. Bədəndə immun sistem melanositlərə hücum edərək onları məhv edir. Genetik meyllilik, stres və müəyyən xəstəliklər də vitiliqonun yaranmasına təsir göstərə bilər."),
        .init(question: "Vitiliqonun əlamətləri:", answer: "Vitiliqonun tam müalicəsi yoxdur, lakin bir sıra müalicə üsulları ləkələrin görünüşünü azaltmağa kömək edir. Topikal steroid kremlər, fototerapiya (UVB şüaları ilə müalicə), immunosupressiv dərmanlar və lazer terapiyası istifadə edilə bilər. Müalicə vitiliqonun yayılmasını yavaşlatmağa və piqmentin bərpasına kömək edə bilər."),
        .init(question: "Vitiliqonun qarşısını necə almaq olar?", answer: "Vitiliqonun qarşısını almağın konkret yolu yoxdur, lakin stresin idarə edilməsi və dərinin günəşdən qorunması əhəmiyyətli faktorlardır. Dərini qoruyucu kremlər istifadə edərək piqmentsiz bölgələri UV şüalarından qorumaq da vacibdir."),
    ]
    
    private var problemDescriptionData: DescriptionModel?
    
    let rosaceaDescription = DescriptionModel(
        imageName: "rosacea",
        description: "Üzdə damar genişlənmələri və iltihablanma nəticəsində qızartı, həssaslıq və iltihablı sızanaqlar yaranır."
    )
    
    let acneDescription = DescriptionModel(
        imageName: "acne-detail",
        description: "Üzdə yağ və ölü dəri hüceyrələrinin tük follikullarını tıxaması nəticəsində sızanaqlar, qara nöqtələr və ya kistlər yaranır."
    )
    
    let melazmaDescription = DescriptionModel(
        imageName: "melazma-cropped",
        description: "Günəş şüaları və hormonal dəyişikliklər səbəbindən üzdə qeyri-bərabər qəhvəyi və ya boz rəngli ləkələr yaranır."
    )
    
    let ekzemaDescription = DescriptionModel(
        imageName: "ekzema-cropped",
        description: "Dərinin iltihabı nəticəsində qaşınma, qızartı və quru ləkələr yaranır."
    )
    
    let seboreikDescription = DescriptionModel(
        imageName: "seboreik-cropped",
        description: "Dərinin yağı çox istehsal etməsi nəticəsində üzdə, xüsusilə burun və alın bölgəsində qaşınan, qabıq verən sarımtıl və ya qırmızı ləkələr yaranır."
    )
    
    let cancerDescription = DescriptionModel(
        imageName: "skinCancer-cropped",
        description: "Dərinin hüceyrələrində genetik dəyişikliklər nəticəsində qeyri-adi ləkələr, yaralar və ya dərinin rəngində dəyişikliklər baş verir."
    )
    
    let rednessDescription = DescriptionModel(
        imageName: "redSkin-cropped",
        description: "Dərinin iltihabı və ya irritasiya nəticəsində üzdə qızarmış bölgələr meydana gəlir."
    )
    
    let vitiligoDescription = DescriptionModel(
        imageName: "Vitiligo-cropped",
        description: "Dərinin müəyyən bölgələrində piqment itkisi nəticəsində ağ ləkələr yaranır."
    )
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "customBgBlue")
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 16
        tv.register(MainProblemCardTableViewCell.self, forCellReuseIdentifier: MainProblemCardTableViewCell.identifier)
        tv.register(AccordionTableViewCell.self, forCellReuseIdentifier: AccordionTableViewCell.identifier)
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData(for: problemName)
        view.backgroundColor = .systemBackground
        title = problemName
        if let navigationController = navigationController {
            let titleTextAttributes: [NSAttributedString.Key: Any] =
            [
                .foregroundColor: UIColor(named: "customDarkBlue") ?? UIColor.black,
                .font: UIFont(name: "Montserrat-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20)
            ]
            navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        let backButtonImage = UIImage(named: "back-button")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .customDarkBlue
        navigationItem.leftBarButtonItem = backButton
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }
    init(problemName: String){
        super.init(nibName: nil, bundle: nil)
        self.problemName = problemName
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func setupUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func setupData(for problem: String?) {
        guard let problem = problem else { return }
        
        switch problem {
        case "Rosacea":
            datas = rosaceaData
            problemDescriptionData = rosaceaDescription
        case "Akne":
            datas = acneData
            problemDescriptionData = acneDescription
        case "Melazma":
            datas = melazmaData
            problemDescriptionData = melazmaDescription
        case "Ekzema":
            datas = ekzemaData
            problemDescriptionData = ekzemaDescription
        case "Seboreik":
            datas = seboreikData
            problemDescriptionData = seboreikDescription
        case "Dəri xərçəngi":
            datas = cancerData
            problemDescriptionData = cancerDescription
        case "Qızartı":
            datas = rednessData
            problemDescriptionData = rednessDescription
        case "Vitiliqo":
            datas = vitiligoData
            problemDescriptionData = vitiligoDescription
        default:
            break
        }
    }
}
extension SkinProblemDetailsViewController: UITableViewDataSource, UITableViewDelegate, AccordionTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainProblemCardTableViewCell.identifier) as! MainProblemCardTableViewCell
            
            if let descriptionData = problemDescriptionData {
                cell.configure(with: descriptionData)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccordionTableViewCell.identifier) as! AccordionTableViewCell
            cell.configure(datas[indexPath.row-1])
            cell.delegate = self
            return cell
        }
    }
    
    func didTapAccordionButton(in cell: AccordionTableViewCell) {
        guard tableView.indexPath(for: cell) != nil else { return }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


