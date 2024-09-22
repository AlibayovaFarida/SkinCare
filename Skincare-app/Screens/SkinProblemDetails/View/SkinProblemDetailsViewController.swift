//
//  SkinProblemDetailsViewController.swift
//  Skincare-app
//
//  Created by Apple on 19.09.24.
//

import UIKit

class SkinProblemDetailsViewController: UIViewController {
    private var problemName: String? = ""
    let datas: [AccordionCellModel] = [
        .init(question: "Akne nədir?", answer: "Sızanaq əri məsamələrinin tıxantığı ümumi bir dəri xəstəliyidir. Məsamələrin tıxanması qara nöqtələr, ağ nöqtələr və digər növ sızanaqlar yaradır. Sızanaqlar dərinizdə irinlə dolu, bəzən ağrılı,\nqabardır.\nSızanaq üçün tibbi termin acne\nvulgarisdir."),
        .init(question: "Aknenin növləri hansılardır?", answer: "Sızanaqların bir neçə növü var, o cümlədən:\n\n\u{2022} Göbələk sızanaqları (pityrosporum folliculitis): Göbələk sızanaqları saç follikullarınızda maya yığıldıqda meydana gəlir. Bunlar qaşınma və iltihab ola bilər.\n\u{2022} Kistik sızanaq: Kistik sızanaq dərin, irinli sızanaq və düyünlərə səbəb olur. Bunlar çapıqlara səbəb ola bilər.\n\u{2022} Hormonal sızanaqlar: Hormonal sızanaqlar məsamələrini tıxayan sebum həddindən artıq istehsalı olan yetkinləri təsir edir.\n\u{2022} Düyünlü sızanaq: Düyünlü sızanaq dərinin səthində sızanaqlara və dəriniz altında həssas, düyünlü topaqlara səbəb olan sızanaqların ağır formasıdır.\nSızanaqların bütün bu formaları özünə hörmətinizə təsir edə bilər və həm kistik, həm də düyünlü sızanaqlar çapıq şəklində qalıcı dəri zədələnməsinə səbəb ola bilər. Ən yaxşısı sizin üçün ən yaxşı müalicə variantını müəyyən edə bilməsi üçün bir tibb işçisindən erkən kömək istəməkdir."),
        .init(question: "Aknenin yaranma səbəbləri", answer: "Tıxanmış saç kökləri və ya məsamələri sızanaqlara səbəb olur. Saç follikullarınız saçınızın bir telini saxlayan kiçik borulardır. Saç follikullarınıza boşaldılan bir neçə vəzi var. Saç follikulunun içərisində çoxlu material olduqda, bir tıxanma meydana gəlir. Məsamələriniz tıxaya bilər:\n\n\u{2022} Sebum: Dəriniz üçün qoruyucu bir maneə təmin edən yağlı bir maddə.\n\u{2022} Bakteriyalar: Dərinizdə təbii olaraq az miqdarda bakteriya yaşayır. Əgər çox bakteriya varsa, məsamələrinizi bağlaya bilər.\n\u{2022} Ölü dəri hüceyrələri: Dəri hüceyrələriniz daha çox hüceyrənin böyüməsi üçün yer açmaq üçün tez-tez tökülür. Dəriniz ölü dəri hüceyrələrini buraxdıqda, onlar saç follikullarınızda ilişib qala bilər.\nMəsamələriniz tıxandıqda, maddələr saç folikülünüzü bağlayır və sızanaq yaradır. Bu, ağrı və şişkinlik kimi hiss etdiyiniz iltihabı tetikler. Siz həmçinin sızanaq ətrafındakı qızartı kimi dərinin rəngsizləşməsi ilə iltihabı görə bilərsiniz."),
        .init(question: "Aknenin əlamətləri hansılardır?", answer: "Dərinizdə sızanaqların əlamətlərinə aşağıdakılar daxildir:\n\n\u{2022} Sızanaqlar (püstüllər): İrinlə dolu qabarlar (papüllər).\n\u{2022} Papüllər: Kiçik, rəngi dəyişmiş qabar, tez-tez qırmızıdan bənövşəyi və ya təbii dəri tonunuzdan daha tünd.\n\u{2022} Qara nöqtələr: Tıxanmış məsamələr qara üstü ilə.\n\u{2022} Ağ başlıqlar: Üstü ağ olan tıxanmış məsamələr.\n\u{2022} Düyünlər: Dərinizin altında ağrılı olan böyük topaklar.\n\u{2022} Kistlər: Dərinizin altında maye ilə dolu ağrılı (irinli) topaklar.\nSızanaqlar yüngül ola bilər və bir neçə arabir sızanaqlara səbəb ola bilər və ya orta dərəcədə iltihablı papüllərə səbəb ola bilər. Şiddətli sızanaqlar düyünlərə və kistlərə səbəb olur."),
        .init(question: "Akne necə müalicə olunur?", answer: "Aknə müalicəsi üçün:\n\n1. Dəriyə qulluq məhsulları: Salitsil turşusu, benzoyl peroksid, retinoidlər.\n2. Dərmanlar: Antibiotiklər, hormon tənzimləyici dərmanlar, izotretinoin.\n3. Həkim prosedurları: Kimyəvi pilinq, lazer terapiyası, steroid inyeksiyaları.\n4. Qidalanma və həyat tərzi: Sağlam qida, çox su içmək, dərini nəmləndirmək.\n5. Təbii vasitələr: Çay ağacı yağı, aloe vera, yaşıl çay ekstraktları.\n5. Təbii vasitələr: Çay ağacı yağı, aloe vera, yaşıl çay ekstraktları.\n7. Məsamələrin təmizlənməsi: Skrab və maskalar."),
        .init(question: "Aknenin yaranmasının qarşısını almaq", answer: "Aknenin yaranmasının qarşısını almaq üçün:\n\n\u{2022} Dəri təmizliyinə diqqət edin, gün ərzində iki dəfə yumşaq təmizləyici ilə yuyun.\n\u{2022} Yağsız, komedogenik olmayan (məsamələri tıxamayan) nəmləndiricilər və günəşdən qoruyucu kremlər istifadə edin.\n\u{2022} Üzə tez-tez toxunmaqdan çəkinin və əl təmizliyinə diqqət edin.\n\u{2022} Sağlam qidalanmaya önəm verin, şəkərli və yağlı qidalardan uzaq durun.\n\u{2022} Çox su için və dərini nəmli saxlayın.\n\u{2022} Stressi idarə edin, çünki stres aknəni pisləşdirə bilər.\n\u{2022} Tez-tez yastıq üzlərini və dəsmalları dəyişin.\n\u{2022} Dərman vasitələrini və ya kosmetik məhsulları istifadə etməzdən əvvəl dermatoloqla məsləhətləşin.")
    ]
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
}
extension SkinProblemDetailsViewController: UITableViewDataSource, UITableViewDelegate, AccordionTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainProblemCardTableViewCell.identifier) as! MainProblemCardTableViewCell
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


