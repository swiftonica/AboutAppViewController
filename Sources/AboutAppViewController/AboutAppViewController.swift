import UIKit
import SnapKit

public class AboutViewController: UIViewController {
    public override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        switch UIDevice.current.orientation.isLandscape {
        case true:
            self.makeVerticalLayout()
        
        case false:
            self.makeVerticalLayout()
        }
    }
    
    public init(preferences: AboutViewControllerPreferences) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        
        configureStackView1()
        
        configureCopyrightLabel()
        configureVersionLabel()
        configureIconImageView()
        
        addStatelessViews()
        
        if UIDevice.current.orientation.isLandscape {
            makeLandscapeLayout()
        }
        else {
            makeVerticalLayout()
        }

        configureStackView2()
        
        fillStackView1Data(preferences: preferences)
        fillStackView2Data(preferences: preferences)
        
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
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
}

//MARK - helper functions
private extension AboutViewController {
    func toogleConstraints(isLanscape: Bool) {
        self.landscapeConstraints.forEach {
            $0.isActive = isLanscape
        }
        self.verticalConstraints.forEach {
            $0.isActive = !isLanscape
        }
    }
    
    func makeLandscapeLayout() {
        self.versionLabel.removeFromSuperview()
        self.view.addSubview(versionLabel)
        self.toogleConstraints(isLanscape: true)
    }
    
    func makeVerticalLayout() {
        self.versionLabel.removeFromSuperview()
        self.stackView1.addArrangedSubview(versionLabel)
        self.toogleConstraints(isLanscape: false)
    }
    
    func addStatelessViews() {
        self.view.addSubview(appImageView)
        self.view.addSubview(copyrightLabel)
    }
}

//MARK: - layoutable views
private extension AboutViewController {
    func configureIconImageView() {
        let vHeight = appImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        let vWidth = appImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
            
        let hHeight = appImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        let hWidth = appImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        
        verticalConstraints.append(contentsOf: [vHeight, vWidth])
        landscapeConstraints.append(contentsOf: [hHeight, hWidth])
        
        appImageView.layer.cornerRadius = 20
        appImageView.layer.masksToBounds = true
    }
    
    func configureVersionLabel() {
        versionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        versionLabel.textColor = .secondaryLabel
        versionLabel.numberOfLines = 0
        let hLeft = versionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10)
        let hRight = versionLabel.rightAnchor.constraint(equalTo: self.copyrightLabel.leftAnchor, constant: -10)
        let hTop = versionLabel.topAnchor.constraint(equalTo: self.stackView1.bottomAnchor, constant: 10)
        self.landscapeConstraints.append(contentsOf: [hLeft, hRight, hTop])
    }
    
    func configureCopyrightLabel() {
        let vCopyrightLabelCenterXAnchor = copyrightLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let vCopyrightLabelCenterYAnchor = copyrightLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let vCopytightLabelWidthAnchor = copyrightLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.65)
        
        let hRight = copyrightLabel.leftAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10)
        let hTop = copyrightLabel.topAnchor.constraint(equalTo: self.stackView1.bottomAnchor, constant: 10)
        
        copyrightLabel.numberOfLines = 0
        copyrightLabel.textAlignment = .center
        copyrightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        copyrightLabel.textColor = .secondaryLabel
        
        self.verticalConstraints.append(
            contentsOf: [vCopyrightLabelCenterXAnchor, vCopyrightLabelCenterYAnchor, vCopytightLabelWidthAnchor]
        )
        self.landscapeConstraints.append(contentsOf: [hRight, hTop])
    }
}

private extension AboutViewController {
    func configureStackView1() {
        view.addSubview(stackView1)
        stackView1.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
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
}

