import Vapor

// MARK: - SwitchResourceSource

public enum SwitchResouceSource {
    case github(owner: String, repo: String, assetPrefix: String)
    case forgejo(owner: String, repo: String, assetPrefix: String)
    case link(URL, version: String?)

    public var releasesUrl: URL {
        switch self {
        case .github(let owner, let repo, _):
            URL(string: "https://api.github.com/repos/\(owner)/\(repo)/releases")!
        case .forgejo(let owner, let repo, _):
            URL(string: "https://vps.suchmeme.nl/git/api/v1/repos/\(owner)/\(repo)/releases")!
        case .link:
            fatalError("Direct linked resources don't have releases endpoint")
        }
    }
}

// MARK: - SwitchResource

enum SwitchResource: String, CaseIterable {
    case hekate
    case hekateIPL
    case atmosphere
    case fusee
    case sigpatches
    case tinfoil
    case bootLogos
    case emummc
    case lockpickRCM
    case hbAppStore
    case jksv
    case ftpd
    case nxThemesInstaller
    case nxShell
    case goldleaf
    case awooInstaller
    case tinwooInstaller
    case missionControl
    case nxGallery
    case nxActivityLog
    case nxOvlloader
    case teslaMenu
    case ovlSysmodules
    case sysClk
    case linkalho
}

extension SwitchResource {
    public var displayName: String {
        switch self {
        case .hekate:               "Hekate"
        case .hekateIPL:            "hekate_ipl.ini"
        case .atmosphere:           "Atmosphère"
        case .fusee:                "Fusée"
        case .sigpatches:           "Sigpatches"
        case .tinfoil:              "Tinfoil"
        case .bootLogos:            "Boot logos"
        case .emummc:               "emummc.txt"
        case .lockpickRCM:          "Lockpick RCM"
        case .hbAppStore:           "HB App Store"
        case .jksv:                 "JKSV"
        case .ftpd:                 "ftpd"
        case .nxThemesInstaller:    "NXThemesInstaller"
        case .nxShell:              "NX-Shell"
        case .goldleaf:             "Goldleaf"
        case .awooInstaller:        "Awoo Installer"
        case .tinwooInstaller:      "TinWoo Installer"
        case .missionControl:       "MissionControl"
        case .nxGallery:            "NXGallery"
        case .nxActivityLog:        "NX Activity Log"
        case .nxOvlloader:          "nx-ovlloader"
        case .teslaMenu:            "Tesla-Menu"
        case .ovlSysmodules:        "ovlSysmodules"
        case .sysClk:               "sys-clk"
        case .linkalho:             "Linkalho"
        }
    }

    public var source: SwitchResouceSource {
        switch self {
        case .hekate:
            .github(
                owner: "CTCaer",
                repo: "hekate",
                assetPrefix: "hekate_ctcaer_"
            )
        case .hekateIPL:
            .link(
                URL(string: "https://nh-server.github.io/switch-guide/files/emu/hekate_ipl.ini")!,
                version: nil
            )
        case .atmosphere:
            .github(
                owner: "Atmosphere-NX",
                repo: "Atmosphere",
                assetPrefix: "atmosphere-"
            )
        case .fusee:
            .github(
                owner: "Atmosphere-NX",
                repo: "Atmosphere",
                assetPrefix: "fusee.bin"
            )
        case .sigpatches:
            .link(
                URL(string: "https://sigmapatches.coomer.party/sigpatches.zip?10.24.2023")!,
                version: "17.0.0"
            )
        case .tinfoil:
            .github(
                owner: "kkkkyue",
                repo: "Tinfoil",
                assetPrefix: "Tinfoil.Self.Installer"
            )
        case .bootLogos:
            .link(
                URL(string: "https://nh-server.github.io/switch-guide/files/bootlogos.zip")!,
                version: nil
            )
        case .emummc:
            .link(
                URL(string: "https://nh-server.github.io/switch-guide/files/emummc.txt")!,
                version: nil
            )
        case .lockpickRCM:
            .forgejo(
                owner: "mudkip",
                repo: "Lockpick_RCM",
                assetPrefix: "Lockpick_RCM.bin"
            )
        case .hbAppStore:
            .github(
                owner: "fortheusers",
                repo: "hb-appstore",
                assetPrefix: "appstore.nro"
            )
        case .jksv:
            .github(
                owner: "J-D-K",
                repo: "JKSV",
                assetPrefix: "JKSV.nro"
            )
        case .ftpd:
            .github(
                owner: "mtheall",
                repo: "ftpd",
                assetPrefix: "ftpd.nro"
            )
        case .nxThemesInstaller:
            .github(
                owner: "exelix11",
                repo:  "SwitchThemeInjector",
                assetPrefix: "NXThemesInstaller.nro"
            )
        case .nxShell:
            .github(
                owner: "joel16",
                repo: "NX-Shell",
                assetPrefix: "NX-Shell.nro"
            )
        case .goldleaf:
            .github(
                owner: "XorTroll",
                repo: "Goldleaf",
                assetPrefix: "Goldleaf.nro"
            )
        case .awooInstaller:
            .github(
                owner: "Huntereb",
                repo: "Awoo-Installer",
                assetPrefix: "Awoo-Installer.zip"
            )
        case .tinwooInstaller:
            .github(
                owner: "hax4dazy",
                repo: "TinWoo",
                assetPrefix: "TinWoo-Installer.zip"
            )
        case .missionControl:
            .github(
                owner: "ndeadly",
                repo: "MissionControl",
                assetPrefix: "MissionControl-"
            )
        case .nxGallery:
            .github(
                owner: "iUltimateLP",
                repo: "NXGallery",
                assetPrefix: "NXGallery_"
            )
        case .nxActivityLog:
            .github(
                owner: "tallbl0nde",
                repo: "NX-Activity-Log",
                assetPrefix: "NX-Activity-Log.nro"
            )
        case .nxOvlloader:
            .github(
                owner: "WerWolv",
                repo: "nx-ovlloader",
                assetPrefix: "nx-ovlloader.zip"
            )
        case .teslaMenu:
            .github(
                owner: "WerWolv",
                repo: "Tesla-Menu",
                assetPrefix: "ovlmenu.zip"
            )
        case .ovlSysmodules:
            .github(
                owner: "WerWolv",
                repo: "ovl-sysmodules",
                assetPrefix: "ovlSysmodules.ovl"
            )
        case .sysClk:
            .github(
                owner: "retronx-team",
                repo: "sys-clk",
                assetPrefix: "sys-clk-"
            )
        case .linkalho:
            .github(
                owner: "rdmrocha",
                repo: "linkalho",
                assetPrefix: "linkalho-"
            )
        }
    }

    var assetFileName: String {
        switch self {
        case .hekate:               "hekate.zip"
        case .hekateIPL:            "hekate_ipl.ini"
        case .atmosphere:           "atmosphere.zip"
        case .fusee:                "fusee.bin"
        case .sigpatches:           "sigpatches.zip"
        case .tinfoil:              "tinfoil.zip"
        case .bootLogos:            "bootlogos.zip"
        case .emummc:               "emummc.txt"
        case .lockpickRCM:          "Lockpick_RCM.bin"
        case .hbAppStore:           "appstore.nro"
        case .jksv:                 "JKSV.nro"
        case .ftpd:                 "ftpd.nro"
        case .nxThemesInstaller:    "NXThemesInstaller.nro"
        case .nxShell:              "NX-Shell.nro"
        case .goldleaf:             "Goldleaf.nro"
        case .awooInstaller:        "Awoo-Installer.zip"
        case .tinwooInstaller:      "TinWoo-Installer.zip"
        case .missionControl:       "MissionControl.zip"
        case .nxGallery:            "NXGallery.zip"
        case .nxActivityLog:        "NX-Activity-Log.nro"
        case .nxOvlloader:          "nx-ovlloader.zip"
        case .teslaMenu:            "ovlmenu.zip"
        case .ovlSysmodules:        "ovlSysmodules.ovl"
        case .sysClk:               "sys-clk.zip"
        case .linkalho:             "linkalho.zip"
        }
    }

    var additionalDescription: String? {
        switch self {
        case .hekateIPL, .bootLogos, .emummc:
            "(from NH Switch Guide)"
        default:
            nil
        }
    }

    var isAssetZipped: Bool {
        switch self {
        case .hekateIPL, .emummc, .lockpickRCM, .hbAppStore,
             .fusee, .jksv, .ftpd, .nxThemesInstaller,
             .nxShell, .goldleaf, .nxActivityLog,
             .ovlSysmodules:
            false
        default:
            true
        }
    }

    var installSteps: [InstallStep] {
        switch self {
        case .hekate, .bootLogos:
            [
                .merge(from: "bootloader", to: "bootloader")
            ]

        case .emummc:
            [
                .move(from: "emummc.txt", to: "atmosphere/hosts/")
            ]

        case .atmosphere, .sigpatches, .tinfoil,
             .awooInstaller, .tinwooInstaller, .missionControl,
             .nxGallery, .nxOvlloader, .teslaMenu:
            [
                .merge(from: "", to: "")
            ]

        case .hekateIPL:
            [
                .move(from: "", to: "bootloader")
            ]

        case .lockpickRCM, .fusee:
            [
                .move(from: "", to: "bootloader/payloads")
            ]

        case .hbAppStore, .jksv, .ftpd,
              .nxThemesInstaller, .nxShell, .goldleaf,
              .nxActivityLog:
            [
                .move(from: "", to: "switch")
            ]

        case .ovlSysmodules:
            [
                .move(from: "ovlSysmodules.ovl", to: "switch/.overlays")
            ]

        case .sysClk:
            [
                .merge(from: "atmosphere", to: "atmosphere"),
                .merge(from: "switch", to: "switch"),
                .merge(from: "config", to: "config"),
            ]

        case .linkalho:
            [
                .move(from: "linkalho.nro", to: "switch")
            ]
        }
    }
}
