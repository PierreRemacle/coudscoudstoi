module PatronsHelper
  def difficulte_css(patron)
    case patron.difficulte
    when "facile"    then "is-easy"
    when "moyenne"   then "is-med"
    when "difficile" then "is-hard"
    end
  end

  def difficulte_label(patron)
    case patron.difficulte
    when "facile"    then "Facile"
    when "moyenne"   then "Moyenne"
    when "difficile" then "Difficile"
    end
  end
end
