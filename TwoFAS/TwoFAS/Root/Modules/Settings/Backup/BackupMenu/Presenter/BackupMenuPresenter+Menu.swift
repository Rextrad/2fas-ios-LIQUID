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

import Foundation

extension BackupMenuPresenter {
    func buildMenu() -> [BackupMenuSection] {
        let cloudBackup = BackupMenuSection(
            title: T.Backup.cloudBackup,
            cells: [
                .init(
                    icon: nil,
                    title: T.Backup.icloudSync,
                    accessory: .init(
                        kind: .backup,
                        isOn: interactor.isBackupOn,
                        isActive: interactor.isBackupAvailable
                    )
                )
            ],
            footer: T.Backup.sectionDescription
        )
        
        let exportEnabled = interactor.exportEnabled
        let fileBackup = BackupMenuSection(
            title: T.Backup.fileBackup,
            cells: [
                .init(
                    title: T.Backup.import,
                    action: .importFile
                ),
                .init(
                    title: T.Backup.export,
                    action: .exportFile,
                    isEnabled: exportEnabled
                )
            ],
            footer: T.Backup.fileBackupOfflineTitle
        )
        
        let cloudBackupDeletition = BackupMenuSection(
            title: T.Backup.backupRemoval,
            cells: [
                .init(
                    title: T.Backup.delete2fasBackup,
                    action: .deleteCloudBackup
                )
            ],
            footer: T.Backup.warningIntroduction
        )
        
        var menu: [BackupMenuSection] = [
            cloudBackup,
            fileBackup
        ]
        
        if interactor.isCloudBackupConnected {
            menu.append(cloudBackupDeletition)
        }

        return menu
    }
}
