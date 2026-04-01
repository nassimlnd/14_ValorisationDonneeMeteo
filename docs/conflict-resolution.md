# Conflit de merge : `docs/edit-readme` vs `main`

**Date** : 2 mars 2026  
**Auteur du constat** : Nassim LOUNADI  
**Fichier en conflit** : `README.md`

---

## Contexte

Les branches `docs/edit-readme` et `main` ont divergé depuis le commit commun `1f17a74` (_chore: docker: format_).

Chacune des deux branches a ensuite apporté des modifications au fichier `README.md` dans un commit séparé, avec le même message de commit (`docs: update readme`), ce qui provoque un conflit lors du merge.

```
         1f17a74 (ancêtre commun)
            |
     ┌──────┴──────┐
     |              |
  e1de462        f0f0a6a
  (docs/edit-readme)  (main)
```

---

## Modifications par branche

### Branche `docs/edit-readme` (commit `e1de462`)

**28 lignes modifiées** — deux types de changements :

1. **Titre du projet** (ligne 1) :

   ```diff
   - # Valorisation Donnée Météo
   + # Valorisation Donnée Météo - Fork
   ```

2. **Reformatage des listes Markdown** (27 lignes) :  
   Remplacement systématique des puces `*` par des tirets `-` dans tout le fichier.
   ```diff
   - * `feat/scope/nom-feature` : nouvelle fonctionnalité
   + - `feat/scope/nom-feature` : nouvelle fonctionnalité
   ```
   Ce changement concerne les sections :
   - Convention de nommage des branches
   - Commits atomiques
   - Format des messages de commit
   - Création de Pull Request
   - Review de code
   - Bonnes pratiques

### Branche `main` (commit `f0f0a6a`)

**1 ligne modifiée** — un seul changement :

1. **Titre du projet** (ligne 1) :
   ```diff
   - # Valorisation Donnée Météo
   + # Valorisation Donnée Météo - Conflict
   ```

---

## Zone de conflit

Le conflit se situe uniquement sur la **ligne 1** du fichier `README.md`. Les deux branches modifient la même ligne avec des valeurs différentes.

Lors d'un `git merge main` depuis `docs/edit-readme`, Git produira les marqueurs suivants :

```
<<<<<<< HEAD
# Valorisation Donnée Météo - Fork
=======
# Valorisation Donnée Météo - Conflict
>>>>>>> main
```

Les 27 autres modifications de `docs/edit-readme` (reformatage des listes) ne sont **pas en conflit** avec `main` et seront appliquées automatiquement par Git.

---

## Options de résolution

### Option A : Garder la version de `docs/edit-readme`

Conserver le titre `# Valorisation Donnée Météo - Fork`.

```bash
# Depuis la branche docs/edit-readme
git merge main

# Éditer README.md : supprimer les marqueurs de conflit et garder la ligne de docs/edit-readme
# Le fichier doit contenir :
# # Valorisation Donnée Météo - Fork

git add README.md
git commit
```

**Résultat** : Le titre sera `- Fork`, et les 27 changements de formatage des listes seront inclus.

### Option B : Garder la version de `main`

Conserver le titre `# Valorisation Donnée Météo - Conflict`.

```bash
# Depuis la branche docs/edit-readme
git merge main

# Éditer README.md : supprimer les marqueurs de conflit et garder la ligne de main
# Le fichier doit contenir :
# # Valorisation Donnée Météo - Conflict

git add README.md
git commit
```

**Résultat** : Le titre sera `- Conflict`, et les 27 changements de formatage des listes seront également inclus.

### Option C : Revenir au titre original

Remettre le titre d'origine `# Valorisation Donnée Météo` (sans suffixe) tout en conservant les améliorations de formatage.

```bash
# Depuis la branche docs/edit-readme
git merge main

# Éditer README.md : supprimer les marqueurs de conflit et remettre le titre original
# Le fichier doit contenir :
# # Valorisation Donnée Météo

git add README.md
git commit
```

**Résultat** : Le titre revient à l'original, et les 27 changements de formatage des listes sont conservés.

---

## Procédure complète de résolution

Quelle que soit l'option choisie, voici les étapes :

```bash
# 1. Se placer sur la branche docs/edit-readme
git checkout docs/edit-readme

# 2. Lancer le merge
git merge main

# 3. Git signale le conflit :
#    CONFLICT (content): Merge conflict in README.md
#    Automatic merge failed; fix conflicts and then commit the result.

# 4. Ouvrir README.md et résoudre le conflit sur la ligne 1
#    (supprimer les marqueurs <<<<<<< ======= >>>>>>> et garder le titre voulu)

# 5. Marquer le conflit comme résolu
git add README.md

# 6. Finaliser le merge
git commit -m "docs: resolve merge conflict in README.md"
```

### Alternative avec rebase

```bash
# 1. Se placer sur la branche docs/edit-readme
git checkout docs/edit-readme

# 2. Lancer le rebase
git rebase main

# 3. Résoudre le conflit sur la ligne 1 de README.md

# 4. Continuer le rebase
git add README.md
git rebase --continue
```

> **Note** : Le rebase réécrit l'historique. Utilisez-le uniquement si la branche n'a pas été partagée ou si vous êtes prêt à faire un `git push --force`.

---

## Résumé

| Aspect                               | Détail                                                    |
| ------------------------------------ | --------------------------------------------------------- |
| **Fichier en conflit**               | `README.md`                                               |
| **Zone de conflit**                  | Ligne 1 (titre du projet)                                 |
| **Branche `docs/edit-readme`**       | `# Valorisation Donnée Météo - Fork` + reformatage listes |
| **Branche `main`**                   | `# Valorisation Donnée Météo - Conflict`                  |
| **Modifications non conflictuelles** | 27 lignes de reformatage `*` vers `-` (merge automatique) |
| **Complexité**                       | Faible (1 seule ligne en conflit)                         |
