//
//  This file is part of the 2FAS iOS app (https://github.com/twofas/2fas-ios)
//  Copyright © 2023 Two Factor Authentication Service, Inc.
//  Contributed by Zbigniew Cisiński. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program. If not, see <https://www.gnu.org/licenses/>
//

import UIKit

protocol ImporterPreimportSummaryViewControlling: AnyObject {
    func showImporting()
}

final class ImporterPreimportSummaryViewController: UIViewController {
    var presenter: ImporterPreimportSummaryPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = generate()
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.pinToParent()
        vc.didMove(toParent: self)
    }
    
    private func generate() -> UIViewController {
        let barConfiguration = MainContainerBarConfiguration(
            title: nil,
            left: nil,
            right: nil,
            hideTabBar: true,
            hideNavigationBar: true,
            statusBar: nil
        )
        let count = presenter.count
        
        let contentMiddle = MainContainerMiddleContentGenerator(placement: .centerHorizontallyLimitWidth, elements: [
            .image(name: "importBackup", size: CGSize(width: 116, height: 94)),
            .extraSpacing,
            .text(text: T.Backup.importBackupFile, style: MainContainerTextStyling.title),
            .extraSpacing,
            .text(text: T.Backup.importOtherDevices, style: MainContainerTextStyling.content),
            .text(text: T.Backup.newServices(count), style: MainContainerTextStyling.boldContent),
            .text(text: T.Backup.servicesMergeTitle, style: MainContainerTextStyling.content)
        ])
        
        let contentBottom = MainContainerBottomContentGenerator(elements: [
            .filledButton(text: T.Backup.importFile, callback: { [weak self] in self?.presenter.handleImport() }),
            .textButton(
                text: T.Commons.cancel,
                callback: { [weak self] in self?.presenter.handleCancel() },
                created: nil
            )
        ])
        
        let config = MainContainerViewController.Configuration(
            barConfiguration: barConfiguration,
            contentTop: nil,
            contentMiddle: contentMiddle,
            contentBottom: contentBottom
        )
        
        let vc = MainContainerViewController()
        vc.configure(with: config)
        
        return vc
    }
}

extension ImporterPreimportSummaryViewController: ImporterPreimportSummaryViewControlling {
    func showImporting() {
        view.isUserInteractionEnabled = false
        let spinner = UIActivityIndicatorView(style: .medium)
        view.addSubview(spinner, with: [
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        spinner.startAnimating()
    }
}
