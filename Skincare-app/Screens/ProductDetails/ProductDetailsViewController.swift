//
//  ProductDetailsViewController.swift
//  Skincare-app
//
//  Created by Umman on 30.09.24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    private var problemName: String? = ""
    private var datas: [AccordionCellModel] = []
    let cleansersData: [AccordionCellModel] = [
        .init(question: "Təmizləyicilər nə üçün vacibdir?", answer: "Təmizləyicilər dəridə yığılan kir və makiyaj qalıqlarını təmizləyir, bu da məsamələri açıq saxlayaraq qara nöqtələrin və sızanaqların yaranmasının qarşısını alır. Bu məhsullar həmçinin dərinin təmiz qalmasına kömək edir, bakteriyaların yayılmasını azaldır. Gündəlik təmizləmə dərinin daha sağlam və parlaq olmasını təmin edir."),
        .init(question: "Hər dəri tipi üçün fərqli təmizləyicilər varmı?", answer: "Bəli, müxtəlif dəri tipləri üçün fərqli təmizləyicilər mövcuddur. Quru dərilər üçün nəmləndirici tərkibli təmizləyicilər seçilməlidir, yağlı dərilər üçün isə yağ tənzimləyici və məsamə təmizləyici məhsullar daha uyğundur. Həssas dərilər üçün isə spirtsiz və yumşaq formulalı təmizləyicilər tövsiyə olunur."),
        .init(question: "Təmizləyici məhsul gündə neçə dəfə istifadə edilməlidir?", answer: "Təmizləyicilər adətən səhər və axşam olmaqla gündə iki dəfə istifadə olunmalıdır. Axşam təmizləyici məhsul makiyaj qalıqlarını və gün ərzində toplanan çirkləri təmizləyir, səhər isə dərinin gecə ərzində ifraz etdiyi yağları və toksinləri aradan qaldırır. Gündəlik təmizləmə rutini dərini nəmləndirici və serumlar üçün daha yaxşı hazırlayır."),
        .init(question: "Təmizləyici məhsullar dərini qurutsa nə etməli?", answer: "Əgər təmizləyici məhsul dərini qurutmağa başlayırsa, daha yumşaq, nəmləndirici xüsusiyyətli təmizləyicilərə keçmək lazımdır. Bununla yanaşı, dəridən nəm itkisinin qarşısını almaq üçün təmizləmədən sonra mütləq nəmləndirici krem istifadə olunmalıdır. Təmizləyicidəki sərt maddələr dərinin təbii yağlarını yuyaraq onu quruda bilər, buna görə balanslı məhsul seçmək vacibdir.")
        
    ]
    let tonicsData: [AccordionCellModel] = [
        .init(question: "Toniklər nə üçün istifadə olunur?", answer: "Toniklər dərinin pH səviyyəsini bərpa edir və məsamələri sıxlaşdırır. Təmizləyicidən sonra qalan kir və yağ qalıqlarını təmizləyərək dərinin daha dərindən təmizlənməsinə kömək edir. Nəticədə, dəriniz digər məhsulları daha effektiv şəkildə qəbul edir və makiyaj üçün mükəmməl bir baza yaradır."),
        .init(question: "Hər dəri tipi üçün uyğun tonik varmı?", answer: "Bəli, hər dəri tipi üçün uyğun tonik mövcuddur. Yağlı dərilər üçün yağ istehsalını tənzimləyən, quru dərilər üçün nəmləndirici tərkibli toniklər tövsiyə olunur. Həssas dəri üçün isə spirtsiz, yumşaq formulalı toniklər daha uyğundur ki, dərini qıcıqlandırmasın."),
        .init(question: "Tonik məhsulu necə tətbiq olunur?", answer: "Tonik pambıq diski vasitəsilə təmiz dəriyə tətbiq olunur. Onu hər səhər və axşam təmizləyici məhsuldan sonra istifadə etmək məsləhətdir. Bu məhsul dərinin pH balansını bərpa edərək məsamələri sıxlaşdırır və dərini daha sağlam görünüşə gətirir."),
        .init(question: "Tonik istifadəsi dərini quruda bilərmi?", answer: "Bəzi toniklər tərkibində spirt olduğu üçün dərini quruda bilər. Əgər tonik dərini qurudursa, spirtsiz və nəmləndirici tərkibli toniklərə keçmək lazımdır. Dərinin qurumasının qarşısını almaq üçün tonikdən sonra həmişə nəmləndirici krem istifadə edilməlidir.")
    ]
    
    let scrabsData: [AccordionCellModel] = [
        .init(question: "Skrablar nə üçün istifadə olunur?", answer: "Skrablar ölü dəri hüceyrələrini təmizləyərək dərini yeniləyir və hamarlaşdırır. Ölü hüceyrələr məsamələri bağlayaraq qara nöqtələrin və sızanaqların yaranmasına səbəb ola bilər. Skrab istifadə etdikdən sonra dəri daha yumşaq və parlaq görünür, həmçinin digər məhsulların təsiri güclənir."),
        .init(question: "Həftədə neçə dəfə skrab istifadə edilməlidir?", answer: "Skrab həftədə 1-3 dəfə istifadə olunmalıdır, lakin bu, dəri tipinə və skrabın növünə bağlıdır. Həddindən artıq skrab istifadəsi dərini zədələyə və qıcıqlandıra bilər. Yağlı dərilər daha tez-tez skrab istifadə edə bilər, quru və həssas dərilər isə daha nadir hallarda istifadə etməlidir."),
        .init(question: "Fiziki və kimyəvi skrablar arasındakı fərq nədir?", answer: "Fiziki skrablar dərini mexaniki olaraq təmizləyir, yəni tərkibində kiçik hissəciklər olur ki, dərini sürtməklə ölü hüceyrələri təmizləyir. Kimyəvi skrablar isə alfa-hidroksi və ya beta-hidroksi turşular kimi maddələrlə dərinin üst qatını həll edir. Kimyəvi skrablar daha yumşaq və effektiv ola bilər, çünki dərinin alt qatlarına daha yaxşı nüfuz edir."),
        .init(question: "Həssas dərilər üçün skrab istifadəsi necə olmalıdır?", answer: "Həssas dərilər üçün yumşaq formulalı skrablar seçilməlidir. Fiziki skrablar həddindən artıq sərt ola bilər, buna görə kimyəvi skrablar daha yaxşı seçimdir. Həssas dərilərdə həftədə bir dəfə yumşaq skrab istifadə etmək məsləhətdir ki, dərini qıcıqlandırmadan yeniləyəsiniz.")
    ]
    
    let serumsData: [AccordionCellModel] = [
        .init(question: "Serumların əsas funksiyası nədir?", answer: "Serumlar dərinin spesifik problemlərini hədəfləyir. Onlar qırışlar, yaşlanma əlamətləri, ləkələr və quruluq kimi problemləri həll etməyə kömək edir. Serumlar yüksək konsentrasiyalı maddələrlə problemlərin həllini sürətləndirir."),
        .init(question: "Serumlar hansı maddələrlə zəngindir?", answer: "Serumların tərkibində vitamin C, retinol, hyaluron turşusu və niacinamide kimi aktiv maddələr var ki, onlar dərini yeniləyir və problemləri həll edir. Bu maddələr dəriyə hədəflənmiş fayda təmin edir və dərin qatlara nüfuz edir."),
        .init(question: "Serum nə vaxt istifadə edilməlidir?", answer: "Serumlar adətən axşamlar təmiz dəriyə tətbiq olunur, lakin bəzi serumlar səhər də istifadə edilə bilər (məsələn, vitamin C). Serumlar dəriyə xüsusi qayğı göstərmək üçün seçilən bir addımdır."),
        .init(question: "Serum istifadəsindən sonra dəridə nə müşahidə olunur?", answer: "Serumlar dərinin dərin qatlarına nüfuz edərək onu daha parlaq, hamar və gənc görünməyə kömək edir. Daimi istifadə ilə dəridə aydın fərqlər görünür, xüsusən də qırışların azalması və dərinin bərpası.")
    ]
    
    let moisturizerData: [AccordionCellModel] = [
        .init(question: "Nəmləndiricinin əsas funksiyası nədir?", answer: "Nəmləndiricilər dərinin nəm səviyyəsini qorumaq və onun elastikliyini artırmaq üçün istifadə olunur. Onlar dərinin quru, sərt və çatlamış görünməsinin qarşısını alaraq, onun daha sağlam görünməsini təmin edir. Müntəzəm istifadə ilə dəri daha hamar və parlaq görünür."),
        .init(question: "Hər dəri tipi üçün uyğun nəmləndiricilər varmı?", answer: " Bəli, müxtəlif dəri tipləri üçün uyğun nəmləndiricilər mövcuddur. Quru dərilər üçün zəngin, yağlı dərilər üçün isə yüngül gel əsaslı nəmləndiricilər daha uyğundur. Həssas dərilər üçün hipoallergen, spirtsiz və parfümsüz məhsullar seçilməlidir."),
        .init(question: "Nəmləndirici necə istifadə olunmalıdır?", answer: "Nəmləndirici, dərinin təmizlənməsindən sonra, gündə iki dəfə, səhər və axşam tətbiq edilməlidir. Kiçik miqdarda məhsulu üz və boyun sahəsinə yumşaq şəkildə masaj edərək tətbiq etmək, onun daha yaxşı hopmasına kömək edir. Tətbiqdən sonra, nəmləndiricinin dəriyə tam hopduğundan əmin olunmalıdır."),
        .init(question: "Nəmləndiricilər yağlı dəri üçün lazımdırmı?", answer: "Bəli, yağlı dərilər də nəmləndiriciyə ehtiyac duyur, çünki düzgün nəmləndirilməyən dəri daha çox yağ istehsal edir. Yüngül, gel əsaslı və neftsiz formulalar seçilməlidir ki, məsamələr bağlanmasın. Düzgün nəmləndirmə, yağlı dərinin daha az parlamasına və daha sağlam görünməsinə kömək edir.")
    ]
    
    let spfData: [AccordionCellModel] = [
        .init(question: "SPF nədir və nə üçün vacibdir?", answer: "SPF, günəşdən qoruyucu məhsulun UVB şüalarına qarşı effektivliyini ölçən bir göstəricidir. SPF istifadə etmək, dərinin günəşdə zədələnməsini önləyir və dəridəki yaşlanma əlamətlərinin yaranmasının qarşısını alır. Günəşin zərərli təsirlərinə qarşı mühafizə olunmaması, dəri xərçəngi riskini artırır."),
        .init(question: "Hər dəri tipi üçün SPF istifadə olunmalıdırmı?", answer: "Bəli, hər dəri tipi üçün SPF istifadə olunması tövsiyə olunur. Hətta qış aylarında və buludlu havalarda da günəşin UV şüaları dərini zədələyə bilər. Hər kəs, dərisinin tipindən asılı olmayaraq, günəşdən qoruyucu məhsuldan istifadə etməlidir."),
        .init(question: "SPF məhsulu necə istifadə olunmalıdır?", answer: "SPF məhsulu, günəşə çıxmadan 15-30 dəqiqə əvvəl dərinin tam təmizlənmiş sahəsinə tətbiq edilməlidir. Yetərli miqdarda məhsul istifadə etmək, bədənin bütün açıq sahələrini (üz, boyun, qulaq, əllər) əhatə etməlidir. SPF məhsulu, günəş altında hər 2-3 saatdan bir və ya üzmə və tərləmə halında daha tez-tez yenidən tətbiq olunmalıdır."),
        .init(question: "SPF dərəcəsi nə deməkdir?", answer: "SPF dərəcəsi, məhsulun UVB şüalarına qarşı qoruma səviyyəsini göstərir. Məsələn, SPF 30 olan bir məhsul, dərinin 30 dəfə daha uzun müddət günəşdə qala biləcəyini göstərir. Yüksək SPF dərəcələri daha güclü qoruma təmin etsə də, müntəzəm olaraq yenidən tətbiq edilməsi vacibdir.")
    ]
    
    let masksData: [AccordionCellModel] = [
        .init(question: "Maskaların əsas funksiyası nədir?", answer: "Maskalar, dərinin spesifik problemlərini hədəfləyərək ona intensiv müalicə edir. Onlar dərini qidalandırır, nəmləndirir və bərpa edir, bu da dərinin görünüşünü və sağlamlığını yaxşılaşdırır. Müntəzəm istifadə, dərinin daha parlaq və sağlam görünməsinə kömək edir."),
        .init(question: "Hər dəri tipi üçün uyğun maskalar varmı?", answer: "Bəli, müxtəlif dəri tipləri üçün uyğun maskalar mövcuddur. Yağlı dərilər üçün seboreya tənzimləyici, quru dərilər üçün isə dərin nəmləndirici maskalar tövsiyə olunur. Həssas dərilər üçün hipoallergen və sakitləşdirici tərkibli maskalar seçilməlidir ki, dərini qıcıqlandırmasın."),
        .init(question: "Maskalar necə istifadə olunmalıdır?", answer: "Maskalar, təmizlənmiş dəriyə tətbiq olunur və adətən 10-20 dəqiqə gözlənilir. Dəriyə bərabər şəkildə yayılmalı, sonra isə su ilə yuyulmalıdır. Tətbiqdən sonra, maskanın təsirini artırmaq üçün mütləq nəmləndirici istifadə olunmalıdır."),
        .init(question: "Maskaların istifadəsi ilə bağlı nə məsləhət verirsiniz?", answer: "Maskalar həftədə 1-3 dəfə istifadə edilməlidir, dərinin ehtiyaclarına görə dəyişir. Dəriyə uyğun maska seçmək və istifadədən sonra dərini nəmləndirmək vacibdir. Fərqli maskalar arasında dəyişərək, dərinin bütün ehtiyaclarını qarşılamaq mümkündür.")
    ]
    
    let oilsData: [AccordionCellModel] = [
        .init(question: "Baxım yağlarının əsas funksiyası nədir?", answer: "Baxım yağları dərini dərinləşdirərək qidalandırır, nəmləndirir və qoruyur. Onlar dərinin quruluğunu aradan qaldırır, elastikliyi artırır və daha parlaq görünməsinə kömək edir. Müntəzəm istifadə ilə dəri daha yumşaq və sağlam olur."),
        .init(question: "Hər dəri tipi üçün uyğun baxım yağları varmı?", answer: "Bəli, müxtəlif dəri tipləri üçün uyğun baxım yağları mövcuddur. Quru dərilər üçün zəngin və ağır formulalar, yağlı dərilər üçün isə yüngül, non-comedogenic (məsamələri bağlamayan) yağlar tövsiyə olunur. Həssas dərilər üçün isə hipoallergen tərkibli yağlar seçilməlidir."),
        .init(question: "Baxım yağları necə istifadə olunmalıdır?", answer: "Baxım yağları, təmizlənmiş dərinin üzərinə tətbiq olunur, adətən 2-3 damcı kifayətdir. Onu dərinizə yumşaq masaj edərək yaymaq, daha yaxşı nəticələr əldə etməyə kömək edir. Baxım yağını, nəmləndirici məhsuldan əvvəl və ya sonra istifadə edə bilərsiniz."),
        .init(question: "Baxım yağlarının istifadəsindən sonra nələr müşahidə olunur?", answer: "Baxım yağları istifadə edildikdən sonra dəridə daha yumşaq, nəmli və parlaq bir görünüş müşahidə olunur. Müntəzəm istifadə ilə dərinin quru və çətin görünüşü aradan qalxır, elastiklik artır. Bu yağlar həmçinin dəriyə qoruyucu bir təbəqə yaradır, bu da onu xarici təsirlərdən mühafizə edir.")
    ]
    
    private var problemDescriptionData: DescriptionModel?
    
    let cleansersDescription = DescriptionModel(
        imageName: "cleansers-cropped",
        description: "Təmizləyicilər dərini kir, yağ və makiyaj qalıqlarından təmizləyərək məsamələri açır və dərinin təmiz qalmasını təmin edir. Müntəzəm istifadə etdikdə, təmizləyicilər dərinin tonunu bərabərləşdirir və qara nöqtələrin qarşısını alır. Onlar dərini digər baxım məhsulları üçün hazırlayır, beləliklə də məhsullar daha dərin təsir edir."
    )
    
    let tonicsDescription = DescriptionModel(
        imageName: "tonikler",
        description: "Toniklər dərinin pH balansını bərpa edir, məsamələri sıxlaşdırır və dəridə qalan yağ və kir qalıqlarını təmizləyir. Təmizləyici məhsuldan sonra istifadə olunduqda, toniklər dərinin digər məhsulları daha yaxşı qəbul etməsinə kömək edir. Onlar həmçinin dərinin daha təzə və canlanmış görünməsini təmin edir."
    )
    
    let scrabsDescription = DescriptionModel(
        imageName: "skrablar",
        description: "Skrablar dərinin üst qatında yığılmış ölü hüceyrələri təmizləyərək dəriyə təzə və parlaq görünüş bəxş edir. Müntəzəm skrab istifadəsi dərinin toxumasını yaxşılaşdırır və məsamələri təmiz saxlayır. Həmçinin, digər məhsulların dəriyə daha dərin nüfuz etməsini asanlaşdırır."
    )
    
    let serumsDescription = DescriptionModel(
        imageName: "serumlar",
        description: "Serumlar, yüksək konsentrasiyalı aktiv maddələrlə zəngin, spesifik dəri problemlərini hədəfləmək üçün nəzərdə tutulmuş məhsullardır. Onlar dərinin dərin qatlarına nüfuz edərək, qırışlar, yaşlanma əlamətləri, piqmentasiya ləkələri və quruluq kimi məsələləri hədəfləyir. Serumlar dərinin görünüşünü və sağlamlığını sürətləndirmək üçün istifadə olunur."
    )
    
    let moisturizerDescription = DescriptionModel(
        imageName: "nemlendirici",
        description: "Nəmləndiricilər, dərinin nəm səviyyəsini qoruyaraq onu yumşaq, elastik və parlaq saxlayır. Onlar dərinin qurumasını önləmək və qorumaq üçün kritik bir addımdır, çünki düzgün nəmləndirilməyən dəri daha çox yağ ifraz etməyə başlayır. Nəmləndiricilər həm də digər məhsulların dəridə daha effektiv nüfuz etməsini təmin edir."
    )
    
    let spfDescription = DescriptionModel(
        imageName: "spf",
        description: "SPF (Sun Protection Factor), dərini günəşin zərərli UV şüalarından qorumaq üçün istifadə olunan məhsulun effektivliyini göstərir. SPF, dərinin günəşdə nə qədər müddət qala biləcəyini və UVB şüalarının yaratdığı zədələnmələri azaltma qabiliyyətini ölçür. Düzgün SPF istifadəsi, dəri xərçəngi riskini azaldır və yaşlanma əlamətlərinin qarşısını alır."
    )
    
    let masksDescription = DescriptionModel(
        imageName: "maskalar-cropped",
        description: "Maskalar, dərinin spesifik ehtiyaclarını qarşılamaq üçün intensiv müalicə edən məhsullardır. Onlar dərini dərinləşdirərək qidalandırır, nəmləndirir və bərpa edir. Müxtəlif tərkiblərə sahib olan maskalar, akne, quru dəri, ləkələr və yaşlanma əlamətləri kimi problemləri hədəfləyir."
    )
    
    let oilsDescription = DescriptionModel(
        imageName: "baxim-yaglari",
        description: "Baxım yağları, dərinin nəmlənməsi, qidalanması və qorunması üçün xüsusi olaraq hazırlanmış məhsullardır. Onlar dərinin üst qatını nəmləndirərək onu yumşaq və parlaq saxlayır, həmçinin antioksidantlar və vitaminlər ilə zəngindir. Baxım yağları, fərqli dəri tiplərinə uyğunlaşaraq, dərinin sağlam görünüşünü artırmağa kömək edir."
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
        case "Cleansers":
            datas = cleansersData
            problemDescriptionData = cleansersDescription
        case "Toniklər":
            datas = tonicsData
            problemDescriptionData = tonicsDescription
        case "Skrablar":
            datas = scrabsData
            problemDescriptionData = scrabsDescription
        case "Serumlar":
            datas = serumsData
            problemDescriptionData = serumsDescription
        case "Nəmləndirici":
            datas = moisturizerData
            problemDescriptionData = moisturizerDescription
        case "SPF":
            datas = spfData
            problemDescriptionData = spfDescription
        case "Maskalar":
            datas = masksData
            problemDescriptionData = masksDescription
        case "Baxım yağları":
            datas = oilsData
            problemDescriptionData = oilsDescription
        default:
            break
        }
    }
}
extension ProductDetailsViewController: UITableViewDataSource, UITableViewDelegate, AccordionTableViewCellDelegate{
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


