(defmodule PedirInformacion)

(defrule preguntar_alimento
=>
(printout t crlf "Buenas! Voy a recomendarte un plato para cocinar, ¿para cuándo te gustaría hacer la comida? (las opciones son: ninguno entrante primer_plato plato_principal postre desayuno_merienda acompanamiento): " )
(assert (alimento (read)))
)



(defmodule DeducirPropiedades)

(defmodule ObtenerRecetas)

(defmodule ProponerReceta)