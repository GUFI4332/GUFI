Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Tes GUID mode perf et mode normal
$GUID_HIGH = "bb3963e4-6151-49d3-8e61-bf234d3716f3"
$GUID_NORMAL = "381b4222-f694-41f0-9685-ff5bb260df2e"

# Liste des jeux à surveiller
$games = @("cs2.exe", "r5apex.exe", "valorant.exe", "aimlab_tb.exe", "TslGame.exe", "fragpunk.exe", "rainbowsix.exe")



# Menu clic droit
$menu = New-Object System.Windows.Forms.ContextMenu
$exit = New-Object System.Windows.Forms.MenuItem "Quitter"
$exit.Add_Click({
    $notify.Visible = $false
    [System.Windows.Forms.Application]::Exit()
})
$menu.MenuItems.Add($exit)
$notify.ContextMenu = $menu

function IsGameRunning {
    param([string[]]$processNames)
    foreach ($procName in $processNames) {
        $process = Get-Process -Name ($procName -replace ".exe","") -ErrorAction SilentlyContinue
        if ($process) {
            return $true
        }
    }
    return $false
}

function SetPowerPlan($guid) {
    # Appelle powercfg uniquement si changement de mode
    if ($global:current_mode -ne $guid) {
        Start-Process -FilePath "powercfg.exe" -ArgumentList "/setactive $guid" -NoNewWindow -Wait
        $global:current_mode = $guid
        if ($guid -eq $GUID_HIGH) {
            $notify.BalloonTipTitle = "Mode Haute Performance activé"
            $notify.BalloonTipText = "Un jeu est détecté."
        } else {
            $notify.BalloonTipTitle = "Mode Équilibré activé"
            $notify.BalloonTipText = "Aucun jeu détecté."
        }
        $notify.ShowBalloonTip(3000)
    }
}

# Boucle principale dans un job parallèle
$job = Start-Job -ScriptBlock {
    param($games, $GUID_HIGH, $GUID_NORMAL)
    $current_mode = ""

    function IsGameRunning {
        param([string[]]$processNames)
        foreach ($procName in $processNames) {
            $process = Get-Process -Name ($procName -replace ".exe","") -ErrorAction SilentlyContinue
            if ($process) {
                return $true
            }
        }
        return $false
    }

    function SetPowerPlan($guid) {
        if ($global:current_mode -ne $guid) {
            Start-Process -FilePath "powercfg.exe" -ArgumentList "/setactive $guid" -NoNewWindow -Wait
            $global:current_mode = $guid
        }
    }

    while ($true) {
        if (IsGameRunning $games) {
            SetPowerPlan $GUID_HIGH
        } else {
            SetPowerPlan $GUID_NORMAL
        }
        Start-Sleep -Seconds 5
    }
} -ArgumentList $games, $GUID_HIGH, $GUID_NORMAL

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Chemin vers le fichier .ico
$iconPath = "C:\Scripts\favicon.ico"

# Créer une icône à partir d'un stream
$iconStream = [System.IO.File]::OpenRead($iconPath)
$icon = New-Object System.Drawing.Icon $iconStream

# Créer l’icône de notification
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = $icon
$notifyIcon.Visible = $true
$notifyIcon.Text = "PowerSwitcherByGUFI"


# (Optionnel) Menu clic droit : Quitter
$menu = New-Object System.Windows.Forms.ContextMenu
$exitItem = New-Object System.Windows.Forms.MenuItem "Quitter"
$exitItem.add_Click({
    $notifyIcon.Visible = $false
    [System.Windows.Forms.Application]::Exit()
})
$menu.MenuItems.Add($exitItem)
$notifyIcon.ContextMenu = $menu

# Fermer le stream
$iconStream.Close()

# Garde le script ouvert
[System.Windows.Forms.Application]::Run()
