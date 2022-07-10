//
//  PersonDetailViewController.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

final class PersonDetailViewController: BaseViewController {

    //MARK: - VIEW
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.cellBackgroundColor.cgColor
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var departmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        label.isHidden = true
        
        return label
    }()
    
    lazy var castTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.isHidden = true
        
        let cellId = String(describing: "CastCellViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return tableView
    }()
    
    lazy var infoContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(departmentLabel)
        stackView.addArrangedSubview(characterNameLabel)
        
        return stackView
    }()
    
    lazy var headerContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(infoContainerView)
        
        return stackView
    }()
    
    //MARK: - PROPERTIES
    var presenter: PersonDetailPresenterProtocol!
    private var personData: MovieCastPresentationModel?
    private var castList: [PersonCastPresentationModel]?
    
    //MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewConstraints()
        presenter.loadData()
    }
    
    
    private func setViewConstraints() {
        view.insertSubview(headerContainerView, belowSubview: indicator)
        view.insertSubview(castTableView, belowSubview: indicator)
        
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(190)
            make.width.equalTo(120)
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        castTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(headerContainerView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setPersonData() {
        setImageView()
        setInfoText()
        configureNavigationBar(title: Constants.Text.actorDetail)
    }
    
    private func setCastData() {
        castTableView.isHidden = (castList?.isEmpty ?? true) ? true : false
        castTableView.reloadData()
    }
    
    private func setImageView() {
        guard let data = personData else { return }
        let url = urlParameters.imageBase.rawValue + data.profileImage
        let id = NSString(string: String(data.id))
        
        profileImageView.downloaded(from: url, cacheId: id) { [weak self] image, cacheId in
            if cacheId == id {
                self?.profileImageView.image = image
            }
        }
    }
    
    private func setInfoText() {
        guard let data = personData else { return }
        nameLabel.text = data.name
        departmentLabel.text = String(format: Constants.Text.department, data.department)
        characterNameLabel.isHidden = data.character == nil ? true : false
        characterNameLabel.text = String(format: Constants.Text.character, data.character ?? "")
    }
}

//MARK: - DISPLAY LOGIC FUNCTIONS
extension PersonDetailViewController: PersonDetailViewProtocol {
    func handleOutput(_ output: PersonDetailPresenterOutput) {
        switch output {
        case .setLoading(let bool):
            DispatchQueue.main.async {
                self.showIndicator(bool)
            }
        case .showData(let data):
            personData = data
            setPersonData()
        case .showCreditData(let data):
            DispatchQueue.main.async {
                self.castList = data
                self.setCastData()
            }
        }
    }
}

//MARK: - TABLE VIEW FUNCTIONS
extension PersonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.Text.movies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = String(describing: "CastCellViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let actor = castList?[indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = actor?.title
        
        return cell
    }
}

extension PersonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectActor(at: indexPath.row)
    }
}
