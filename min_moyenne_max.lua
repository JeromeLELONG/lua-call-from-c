function min_moyenne_max(...)
    -- définir les valeurs de début pour `min` et `max` sur le premier argument
    local min = select(1, ...)
    local max = select(1, ...)
    -- Définir la valeur médiane sur zéro au début
    local moyenne = 0
    -- itérer sur les chiffres
    -- nous n’avons pas besoin de la variable index
    -- nous utilisons `_` en tant que balise
    for _, nombre in ipairs({...}) do
      -- définir un nouveau minimum le cas échéant
      if min > nombre then
        min = nombre
      end
      -- définir un nouveau maximum le cas échéant
      if max < nombre then
        max = nombre
      end
      -- additionner des chiffres pour la moyenne
      moyenne = moyenne + nombre
    end
    -- diviser la somme des nombres par leur nombre
    moyenne = moyenne / #{...}
    return min, moyenne, max
  end
  -- ici, nous n’avons pas besoin de la valeur `moyenne`
  -- nous utilisons `_` en tant que balise
  min, _, max = min_moyenne_max(78, 34, 91, 7, 28)
  print("Le minimum et le maximum des nombres sont", min, max)
  print("--I am using Lua from within C--")