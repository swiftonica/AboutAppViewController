import UIKit

/// This Library is full opensource and free to use
///
///     version: 1.0
///
///     License: MIT License
///
/// [!] iPad is unsupported. Only iPhone in horizontal and portrait
///
/// Created by Jeytery for iOS community with love


public class AboutAppViewController: UIViewController {
    public override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        switch self.isLandscape {
        case true:
            self.makeLandscapeLayout()

        case false:
            self.makeVerticalLayout()
        }
    }

    public init(preferences: AboutAppViewControllerPreferences) {
        self.preferences = preferences
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .systemBackground
        addStatelessViews()
        
        // add constraints for both layouts
        configureStackView1()
        configureIconImageView()
        configureVersionLabel()
        configureCopyrightLabel()
        
        configureStackView2()

        // fill data
        fillStackView1Data(preferences: preferences)
        fillStackView2Data(preferences: preferences)
        copyrightLabel.text = preferences.copyrightText
        
        // add statefull views and activete constraints
        if UIDevice.current.orientation.isLandscape {
            makeLandscapeLayout()
        }
        else {
            makeVerticalLayout()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let preferences: AboutAppViewControllerPreferences

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
private extension AboutAppViewController {
    var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    func toogleConstraints(isLanscape: Bool) {
        self.landscapeConstraints.forEach {
            $0.isActive = isLanscape
        }
        self.verticalConstraints.forEach {
            $0.isActive = !isLanscape
        }
    }

    func makeLandscapeLayout() {
        self.appImageView.removeFromSuperview()
        self.view.addSubview(appImageView)

        self.stackView2.axis = .horizontal
        self.toogleConstraints(isLanscape: true)
        stackView1.alignment = .fill
        stackView1.distribution = .fillProportionally
        copyrightLabel.textAlignment = .left
        appNameLabel.attributedText = self.preferences.appNameAttributedString(fontSize: 50)
        stackView1.spacing = 0
    }

    func makeVerticalLayout() {
        self.appImageView.removeFromSuperview()
        self.stackView1.insertArrangedSubview(appImageView, at: 0)

        self.stackView2.axis = .vertical
        self.toogleConstraints(isLanscape: false)
        stackView1.alignment = .center
        copyrightLabel.textAlignment = .center

        appNameLabel.attributedText = self.preferences.appNameAttributedString
        stackView1.spacing = 8
    }

    func addStatelessViews() {
        self.view.addSubview(stackView1)
        self.stackView1.addArrangedSubview(appNameLabel)
        self.stackView1.addArrangedSubview(versionLabel)
        self.view.addSubview(copyrightLabel)
    }
}

//MARK: - layoutable views
private extension AboutAppViewController {
    func configureIconImageView() {
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let value: CGFloat
        
        if self.isLandscape {
            value = UIScreen.main.bounds.height
        }
        else {
            value = UIScreen.main.bounds.width
        }
        
        let vHeight = appImageView.heightAnchor.constraint(equalToConstant: value / 4)
        let vWidth = appImageView.widthAnchor.constraint(equalToConstant: value / 4)
        
        let hHeight = appImageView.heightAnchor.constraint(equalToConstant: value / 3)
        let hWidth = appImageView.widthAnchor.constraint(equalToConstant: value / 3)
        let hTop = appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        let hLeft = appImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)

        verticalConstraints.append(contentsOf: [vHeight, vWidth])
        landscapeConstraints.append(contentsOf: [hHeight, hWidth, hTop, hLeft])

        appImageView.layer.cornerRadius = 20
        appImageView.layer.masksToBounds = true

        appImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        appImageView.layer.borderWidth = 1.5
    }

    func configureVersionLabel() {
        versionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        versionLabel.textColor = .secondaryLabel
        versionLabel.numberOfLines = 0
    }

    func configureCopyrightLabel() {
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        let vCopyrightLabelCenterXAnchor = copyrightLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let vCopyrightLabelCenterYAnchor = copyrightLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let vCopytightLabelWidthAnchor = copyrightLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.65)
        self.verticalConstraints.append(
            contentsOf: [vCopyrightLabelCenterXAnchor, vCopyrightLabelCenterYAnchor, vCopytightLabelWidthAnchor]
        )

        let hLeft = copyrightLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)
        let hTop = copyrightLabel.topAnchor.constraint(equalTo: self.appImageView.bottomAnchor)
        let hBottom = copyrightLabel.bottomAnchor.constraint(equalTo: self.stackView2.topAnchor)
        let hWidth = copyrightLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        self.landscapeConstraints.append(contentsOf: [hLeft, hBottom, hWidth, hTop])

        copyrightLabel.numberOfLines = 0
        copyrightLabel.textAlignment = .center
        copyrightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        copyrightLabel.textColor = .secondaryLabel
    }

    func configureStackView1() {
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        let vTop = stackView1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        let vLeft = stackView1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10)
        let vRight = stackView1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10)
        self.verticalConstraints.append(contentsOf: [vTop, vLeft, vRight])

        let hTop = stackView1.topAnchor.constraint(equalTo: self.appImageView.topAnchor)
        let hLeft = stackView1.leftAnchor.constraint(equalTo: self.appImageView.rightAnchor, constant: 10)
        self.landscapeConstraints.append(contentsOf: [hTop, hLeft])

        stackView1.spacing = 8
        stackView1.axis = .vertical
    }
}

private extension AboutAppViewController {
    func fillStackView1Data(preferences: AboutAppViewControllerPreferences) {
        appImageView.image = preferences.appIcon
        appNameLabel.attributedText = preferences.appNameAttributedString
        versionLabel.text = preferences.versionNumber
    }

    func fillStackView2Data(preferences: AboutAppViewControllerPreferences) {
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

    func addButtonToStackView2(_ aboutButton: AboutAppViewControllerPreferences.AboutButton) {
        let button = UIButton(configuration: .gray())
        button.setTitle(aboutButton.title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
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
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        stackView2.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        stackView2.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        stackView2.axis = .vertical
        stackView2.spacing = 12
    }
}
