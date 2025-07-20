# GUFI
PowerSwitcherByGUFI4332

# 🎮 SwitchPowerModeTray

Un script PowerShell simple et discret qui **bascule automatiquement le mode d’alimentation de Windows** en "Haute performance" quand un jeu est lancé, et revient en "Utilisation normale" quand le jeu est fermé.

---

## ⚙️ Fonctionnement

Le script tourne en tâche de fond via la barre système (icônes cachées) et détecte automatiquement le lancement ou la fermeture des jeux suivants :

- CS2
- Valorant
- Apex Legends
- Aim Lab
- PUBG
- Fragpunk
- Rainbow Six Siege

Quand un de ces jeux est lancé :

- 🔋 Le mode d’alimentation passe en **"Haute performance"** (`GUID personnalisé`)

Quand le jeu est fermé :

- 💡 Le mode repasse en **"Utilisation normale"**

---

## 🧠 Points forts

- Icône personnalisée dans la barre système
- Zéro interface : aucun CMD ou PowerShell visible
- Consomme très peu de ressources
- Automatisé dès le démarrage de Windows

---

## 🛠️ Installation

### 1. Déplacer le dossier script dans "C:\"
```

### 2. Lancer au démarrage

- Appuie sur `Win + R`, tape `shell:startup` et valide  
- Colle le raccourci "SwitchPowerHidden" dans ce dossier pour qu’il démarre automatiquement à l’ouverture de Windows

---

## 🔒 Prérequis

- Windows 10 ou 11  
- Exécution des scripts PowerShell autorisée (via ExecutionPolicy)  
- Le mode d'alimentation "Haute performance" doit exister (tu peux le créer avec `powercfg`)

---

## 👨‍💻 Auteur

Script créé par un jeune gamer qui aime que son PC s’adapte tout seul ⚡  
Optimisation silencieuse, sans bloat, pour les vrais 🧠

---

## 📄 Licence

Ce projet est open-source. Fais-en ce que tu veux (ou améliore-le 😎) Contacter moi pour plus d'information
