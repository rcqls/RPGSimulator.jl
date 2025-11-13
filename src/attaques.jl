# Fonction de calcul des dégâts
function degats(attaque_base::Int, defense::Int; frac_ecart_type=0.12, chance_critique=0.10, multiplicateur_critique=1.6)
    # attaque_base : puissance d'attaque du personnage attaquant
    # defense : valeur de défense du personnage défenseur
    # frac_ecart_type : fraction utilisée pour calculer la variabilité aléatoire
    # chance_critique : probabilité d'un coup critique
    # multiplicateur_critique : facteur appliqué aux dégâts en cas de coup critique

    # Calcul de la variabilité (écart-type de la distribution des dégâts)
    ecart_type = max(1.0, abs(attaque_base) * frac_ecart_type)

    # Tirage aléatoire des dégâts selon une loi normale centrée sur l'attaque de base
    degat_tire = rand(Normal(attaque_base, ecart_type))

    # Calcul du dégât brut en soustrayant la défense
    degat_brut = Int(round(degat_tire)) - defense

    # Les dégâts ne peuvent pas être négatifs
    degat_brut = max(degat_brut, 0)

    # Vérifie s'il y a un coup critique (tir aléatoire selon la probabilité)
    est_critique = (rand() < chance_critique) && degat_brut > 0

    # Si critique, on applique le multiplicateur
    degat_final = est_critique ? Int(round(degat_brut * multiplicateur_critique)) : degat_brut

    # Retourne les dégâts finaux et le booléen indiquant un critique
    return degat_final, est_critique
end


# Fonction d’attaque entre deux rôles
function attaquer(att::Role, def::Role; shield::Int=0, dmg_mat=Dict(), skill_usage=Dict())
    # Calcule les dégâts entre l’attaquant et le défenseur, en tenant compte du bouclier
    dmg, crit = degats(att.stats.ATK, def.stats.DEFENSE - shield)

    # Met à jour les PV du défenseur (ne peuvent pas descendre sous 0)
    def.stats.PV = max(def.stats.PV - dmg, 0)

    # Affiche un message décrivant l’action
    println("$(att.nom) attaque $(def.nom) et inflige $dmg dégâts" * (crit ? " (CRIT!)" : ""))

    # Met à jour une matrice de suivi des dégâts selon les classes d’attaquant et de défenseur
    acls, dcls = string(typeof(att)), string(typeof(def))
    dmg_mat[(acls, dcls)] = get(dmg_mat, (acls, dcls), 0) + dmg

    # Retourne les dégâts infligés
    return dmg
end

