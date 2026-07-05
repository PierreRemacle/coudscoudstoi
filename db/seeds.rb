Profile.find_or_create_by!(nom: "Stéphanie")

%w[Robe Blouse Jupe Manteau Pantalon Haut Short Veste Combinaison Accessoire Autre].each do |v|
  Liste.find_or_create_by!(kind: "vetement", valeur: v)
end

%w[Viscose Coton Lin Lainage Jersey Satin Denim Velours Mousseline Autre].each do |m|
  Liste.find_or_create_by!(kind: "matiere", valeur: m)
end
