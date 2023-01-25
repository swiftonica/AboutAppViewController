import UIKit
import SnapKit

public class AboutViewController: UIViewController {
//    override func viewWillTransition(
//        to size: CGSize,
//        with coordinator: UIViewControllerTransitionCoordinator
//    ) {
//        super.viewWillTransition(to: size, with: coordinator)
//        if UIDevice.current.orientation.isLandscape {
//
//        } else {
//
//        }
//    }
    
    public init(preferences: AboutViewControllerPreferences) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        
        configureStackView1()
        configureCopyrightLabel()
        configureStackView2()
        
        fillStackView1Data(preferences: preferences)
        fillStackView2Data(preferences: preferences)
        
        configureStackView1Subviews()
        copyrightLabel.text = preferences.copyrightText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stackView1 = UIStackView()
    private let appImageView = UIImageView()
    private let appNameLabel = UILabel()
    private let versionLabel = UILabel()
    
    private let copyrightLabel = UILabel()
    
    private let stackView2 = UIStackView()
    
    private var veritcalConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
}

//MARK - helper functions
private extension AboutViewController {
    func deleteAllConstraints() {
        self.view.constraints.forEach {
            self.view.removeConstraint($0)
        }
    }
    
    func makeLandscapeConstraints() {}
    func makeVerticalConstraints() {}
}

private extension AboutViewController {
    func configureStackView1() {
        view.addSubview(stackView1)
        stackView1.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().dividedBy(2)
            $0.centerX.equalToSuperview()
        }
        stackView1.spacing = 8
        stackView1.alignment = .center
        stackView1.axis = .vertical
        
        stackView1.addArrangedSubview(appImageView)
        stackView1.addArrangedSubview(appNameLabel)
        stackView1.addArrangedSubview(versionLabel)
    }
    
    func fillStackView1Data(preferences: AboutViewControllerPreferences) {
        appImageView.image = preferences.appIcon
        appNameLabel.attributedText = preferences.appNameAttributedString
        versionLabel.text = preferences.versionNumber
    }
    
    func fillStackView2Data(preferences: AboutViewControllerPreferences) {
        guard let buttons = preferences.buttons else { return }
        buttons.forEach {
            self.addButtonToStackView2($0)
        }
    }
    
    func buttonAction(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    func addButtonToStackView2(_ aboutButton: AboutViewControllerPreferences.AboutButton) {
        let button = UIButton(configuration: .gray())
        button.setTitle(aboutButton.title, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.snp.makeConstraints {
            $0.height.equalTo(55)
        }
        button.tintColor = .label
        button.addAction(
            .init(handler: { _ in
                self.buttonAction(aboutButton.url)
            }),
            for: .touchUpInside
        )
        stackView2.addArrangedSubview(button)
    }
    
    func configureCopyrightLabel() {
        view.addSubview(copyrightLabel)
        copyrightLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.65)
        }
        copyrightLabel.numberOfLines = 0
        copyrightLabel.textAlignment = .center
        copyrightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        copyrightLabel.textColor = .secondaryLabel
    }
    
    func configureStackView2() {
        view.addSubview(stackView2)
        stackView2.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        stackView2.axis = .vertical
        stackView2.spacing = 12
    }
    
    func configureStackView1Subviews() {
        appImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
        
        appImageView.layer.cornerRadius = 20
        appImageView.layer.masksToBounds = true
        versionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        versionLabel.textColor = .secondaryLabel
    }
}

