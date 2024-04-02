(defrule iniciar
=>
(focus DeducirPropiedades)
)

(defmodule PedirInformacion (export deftemplate respuesta))

(defrule preguntar_veggie
(respuesta 0)
=>
(printout t crlf "Buenas! Voy a recomendarte un plato para cocinar, para empezar veamos las particularidades alimentarias, ¿deseas que la receta sea vegetariana o vegana? (las opciones son: "vegetariana", "vegana" o "no")" crlf)
(assert (respuesta (read)))
(focus ObtenerRecetas)
)

(defrule preguntar_gluten
(respuesta 1 | 2 | 3)
=>
(printout t crlf "entiendo, ¿y deseas que el alimento sea sin gluten? (las opciones son: "si" o "no")" crlf)
(assert (respuesta (read)))
(focus ObtenerRecetas)
)

(defrule preguntarlactosa
(respuesta 4-1 | 4-2 | 4-3 | 5-1 | 5-2 | 5-3)
=>
(printout t crlf "apuntado, ¿y deseas que el alimento sea sin lactosa? (las opciones son: "si" o "no")" crlf)
(assert (respuesta (read)))
(focus ObtenerRecetas)
)



(defmodule DeducirPropiedades (import PedirInformacion deftemplate respuesta)(export deftemplate ?ALL))

(deftemplate requisitos
(multislot ingredientes)
(slot dificultad (allowed-symbols alta media baja muy_baja))
(slot duracion)
(slot tipo_plato (allowed-symbols entrante primer_plato plato_principal postre desayuno_merienda acompanamiento))
(slot coste)
)

(deftemplate posible_receta
(slot enlaces)
)

(deftemplate receta
(multislot nombre)   ; necesario
(slot introducido_por) ; necesario
(slot numero_personas)  ; necesario
(multislot ingredientes)   ; necesario
(slot dificultad (allowed-symbols alta media baja muy_baja))  ; necesario
(slot duracion)  ; necesario
(slot enlace)  ; necesario
(multislot tipo_plato (allowed-symbols entrante primer_plato plato_principal postre desayuno_merienda acompanamiento)) ; necesario, introducido o deducido en este ejercicio
(slot coste)  ; opcional relevante
(slot tipo_copcion (allowed-symbols crudo cocido a_la_plancha frito al_horno al_vapor))   ; opcional
(multislot tipo_cocina)   ;opcional
(slot temporada)  ; opcional
;;;; Estos slot se calculan, se haria mediante un algoritmo que no vamos a implementar para este prototipo, lo usamos con la herramienta indicada y lo introducimos
(slot Calorias) ; calculado necesario
(slot Proteinas) ; calculado necesario
(slot Grasa) ; calculado necesario
(slot Carbohidratos) ; calculado necesario
(slot Fibra) ; calculado necesario
(slot Colesterol) ; calculado necesario
)

(defrule carga_recetas
(declare (salience 1000))
=>
(load-facts "recetas.txt")
)

(defrule guarda_recetas
(declare (salience -1000))
=>
(save-facts "recetas.txt")
(assert (respuesta 0))
(focus PedirInformacion)
)

(deftemplate es_condimento
(slot nombre)
)

(deftemplate es_carne
(slot nombre)
)

(deftemplate es_pescado
(slot nombre)
)

(deftemplate es_fruta
(slot nombre)
)

(deftemplate propiedad_receta
(slot propiedad (allowed-symbols ingrediente_relevante es_vegetariana es_vegana es_sin_gluten es_sin_lactosa es_picante es_de_dieta))
(multislot receta)
(slot ingrediente)
)

(deftemplate recetas
(slot nombre)
(slot ingrediente)
(slot enlace)
)

(deftemplate ingrediente_picante
(slot nombre)
)

(deftemplate gluten
(slot nombre)
)

(deftemplate lacteos
(slot nombre)
)

(deftemplate derivados_animales
(slot nombre)
)

(defrule mostrar_relevantes
(declare (salience -2))
(propiedad_receta (propiedad ingrediente_relevante) (receta ?r) (ingrediente ?a))
=>
)

(deffacts tiene_gluten
(gluten (nombre trigo))
(gluten (nombre pan))
(gluten (nombre harina))
(gluten (nombre harina_de_trigo))
(gluten (nombre cebada))
(gluten (nombre centeno))
(gluten (nombre pan_de_molde))
(gluten (nombre pan_integral))
(gluten (nombre pan_de_cebada))
(gluten (nombre pan_de_centeno))
(gluten (nombre obleas))
(gluten (nombre galletas))
(gluten (nombre pan_rallado))
(gluten (nombre pan_de_pueblo))
(gluten (nombre pan_de_pita))
(gluten (nombre espaguetis))
(gluten (nombre macarrones))
(gluten (nombre pasta))
)

(deffacts condimentos
  (es_condimento (nombre sal))
  (es_condimento (nombre pimienta))
  (es_condimento (nombre azúcar))
  (es_condimento (nombre azucar))
  (es_condimento (nombre canela))
  (es_condimento (nombre aceite_de_oliva))
  (es_condimento (nombre aceite_oliva))
  (es_condimento (nombre vinagre))
  (es_condimento (nombre orégano))
  (es_condimento (nombre romero))
  (es_condimento (nombre tomillo))
  (es_condimento (nombre perejil))
  (es_condimento (nombre albahaca))
  (es_condimento (nombre laurel))
  (es_condimento (nombre nuez_moscada))
  (es_condimento (nombre mantequilla))
  (es_condimento (nombre aceite_de_girasol))
  (es_condimento (nombre ajo))
  (es_condimento (nombre cebolla))
  (es_condimento (nombre diente_de_ajo))
  (es_condimento (nombre harina))
  (es_condimento (nombre huevo))
  (es_condimento (nombre leche))
  (es_condimento (nombre aceite))
  (es_condimento (nombre maicena))
  (es_condimento (nombre azúcar_glas))
  (es_condimento (nombre azucar_glas))
  (es_condimento (nombre mezcla_especias))
)

(deffacts carne
  (es_carne (nombre pollo))
  (es_carne (nombre ternera))
  (es_carne (nombre cerdo))
  (es_carne (nombre cordero))
  (es_carne (nombre pavo))
  (es_carne (nombre conejo))
  (es_carne (nombre carne))
  (es_carne (nombre jamón))
  (es_carne (nombre bacon))
  (es_carne (nombre chorizo))
  (es_carne (nombre salchicha))
  (es_carne (nombre salchichón))
  (es_carne (nombre morcilla))
  (es_carne (nombre jamon))
  (es_carne (nombre panceta))
  (es_carne (nombre lomo))
  (es_carne (nombre lomo_fino))
  (es_carne (nombre chuleta))
  (es_carne (nombre filete))
  (es_carne (nombre hamburguesa))
  (es_carne (nombre carne_picada))
  (es_carne (nombre carne_mechada))
  (es_carne (nombre carne_vacuno))
  (es_carne (nombre carne_de_cerdo))
  (es_carne (nombre carne_de_ternera))
  (es_carne (nombre pechuga_de_pollo))
  (es_carne (nombre pechugas_pollo))
  (es_carne (nombre carne_molida))
  (es_carne (nombre jamon_serrano))
  (es_carne (nombre carne_picada_ternera))
  (es_carne (nombre carne_picada_cerdo))
  (es_carne (nombre carre_de_cerdo))
  (es_carne (nombre solomillo))
  (es_carne (nombre solomillo_de_cerdo))
  (es_carne (nombre solomillo_de_pollo))
  (es_carne (nombre solomillo_de_ternera))
  (es_carne (nombre matambre))
  (es_carne (nombre chuleta_de_cerdo))
  (es_carne (nombre pato))
  (es_carne (nombre bistec))
  (es_carne (nombre huesos_de_pollo))
  (es_carne (nombre chistorra))
  (es_carne (nombre longaniza))
  (es_carne (nombre manteca_cerdo))
  (es_carne (nombre manteca))
  (es_carne (nombre tocino))
  (es_carne (nombre tocino_de_cerdo))
  (es_carne (nombre caldo_de_pollo))
  (es_carne (nombre callos))
  (es_carne (nombre callos_de_ternera))
  (es_carne (nombre caldo_de_res))
)

(deffacts pescado
  (es_pescado (nombre atún))
  (es_pescado (nombre atun))
  (es_pescado (nombre salmón))
  (es_pescado (nombre salmon))
  (es_pescado (nombre merluza))
  (es_pescado (nombre bacalao))
  (es_pescado (nombre pescado))
  (es_pescado (nombre sardina))
  (es_pescado (nombre boquerón))
  (es_pescado (nombre anchoa))
  (es_pescado (nombre trucha))
  (es_pescado (nombre lubina))
  (es_pescado (nombre dorada))
  (es_pescado (nombre pez_espada))
  (es_pescado (nombre salmon_ahumado))
  (es_pescado (nombre surimi))
  (es_pescado (nombre caldo_de_pescado))
  (es_pescado (nombre caldo_pescado))
  (es_pescado (nombre caldo_de_marisco))
  (es_pescado (nombre caldo_marisco))
  (es_pescado (nombre langostino))
  (es_pescado (nombre gambas))
  (es_pescado (nombre mejillones))
  (es_pescado (nombre pulpo))
  (es_pescado (nombre sepia))
  (es_pescado (nombre calamares))
  (es_pescado (nombre chipirones))
  (es_pescado (nombre camarones))
  (es_pescado (nombre bacalao_desalado))
  (es_pescado (nombre rodajas_merluza))
  (es_pescado (nombre filetes_merluza))
  (es_pescado (nombre filetes_de_pescado))
)

(deffacts derivados
  (derivados_animales (nombre huevo))
  (derivados_animales (nombre mayonesa))
  (derivados_animales (nombre mayonesa_ligera))
  (derivados_animales (nombre yema_de_huevo))
  (derivados_animales (nombre clara_de_huevo))
  (derivados_animales (nombre claras_de_huevo))
  (derivados_animales (nombre claras))
  (derivados_animales (nombre yema))
  (derivados_animales (nombre yemas))
  (derivados_animales (nombre yemas_de_huevo))
  (derivados_animales (nombre huevo_duro))
  (derivados_animales (nombre huevo_cocido))
  (derivados_animales (nombre huevo_frito))
  (derivados_animales (nombre huevo_escalfado))
  (derivados_animales (nombre huevos))
  
)

(deffacts con_lactosa
  (lacteos (nombre queso_crema))
  (lacteos (nombre queso_rallado))
  (lacteos (nombre queso_mozzarella))
  (lacteos (nombre queso_gouda))
  (lacteos (nombre queso_emmental))
  (lacteos (nombre nata_montada))
  (lacteos (nombre nata_para_montar))
  (lacteos (nombre nata_para_cocinar))
  (lacteos (nombre parmesano))
  (lacteos (nombre bechamel))
  (lacteos (nombre mantequilla_sin_sal))
  (lacteos (nombre mantequilla_con_sal))
  (lacteos (nombre mozzarella))
  (lacteos (nombre queso_fresco))
  (lacteos (nombre crema_de_leche))
  (lacteos (nombre dulce_de_leche))
  (lacteos (nombre leche_condensada))
  (lacteos (nombre leche_evaporada))
  (lacteos (nombre leche_en_polvo))
  (lacteos (nombre chocolate_con_leche))
  (lacteos (nombre chocolate_blanco))
  (lacteos (nombre queso_parmesano))
  (lacteos (nombre queso_azul))
  (lacteos (nombre queso_de_cabra))
  (lacteos (nombre queso_de_bola))
  (lacteos (nombre leche))
  (lacteos (nombre mantequilla))
  (lacteos (nombre queso))
  (lacteos (nombre nata))
  (lacteos (nombre yogur))
  (lacteos (nombre helado))
)

;si es carne o es pescado o es lacteo, entonces es derivado de animales
(defrule derivado_animales
  (declare (salience 10))
  (or (es_carne (nombre ?nombre))
      (es_pescado (nombre ?nombre))
      (lacteos (nombre ?nombre)))
  =>
  (assert (derivados_animales (nombre ?nombre)))
)


(deffacts frutas
  (es_fruta (nombre manzana))
  (es_fruta (nombre pera))
  (es_fruta (nombre plátano))
  (es_fruta (nombre platano))
  (es_fruta (nombre fresa))
  (es_fruta (nombre frambuesa))
  (es_fruta (nombre arándano))
  (es_fruta (nombre arandano))
  (es_fruta (nombre naranja))
  (es_fruta (nombre limón))
  (es_fruta (nombre limon))
  (es_fruta (nombre mandarina))
  (es_fruta (nombre uva))
  (es_fruta (nombre melocotón))
  (es_fruta (nombre melocoton))
  (es_fruta (nombre albaricoque))
  (es_fruta (nombre albaricoque_seco))
  (es_fruta (nombre ciruela))
  (es_fruta (nombre ciruela_seca))
  (es_fruta (nombre cereza))
  (es_fruta (nombre kiwi))
  (es_fruta (nombre mango))
  (es_fruta (nombre piña))
  (es_fruta (nombre pinia))
  (es_fruta (nombre sandía))
  (es_fruta (nombre sandia))
  (es_fruta (nombre papaya))
  (es_fruta (nombre aguacate))
  (es_fruta (nombre coco))
  (es_fruta (nombre granada))
  (es_fruta (nombre higo))
  (es_fruta (nombre chirimoya))
  (es_fruta (nombre guayaba))
  (es_fruta (nombre maracuyá))
  (es_fruta (nombre maracuya))
  (es_fruta (nombre níspero))
  (es_fruta (nombre nispero))
  (es_fruta (nombre pera_conferencia))
  (es_fruta (nombre pera_conferencia))
  (es_fruta (nombre pera_de_agua))
  (es_fruta (nombre pera_de_agua))
  (es_fruta (nombre pera_de_san_juan))
  (es_fruta (nombre pera_de_san_juan))
  (es_fruta (nombre pera_de_jumilla))
)

(deffacts picantes
  (ingrediente_picante (nombre guindilla))
  (ingrediente_picante (nombre chile))
  (ingrediente_picante (nombre tabasco))
  (ingrediente_picante (nombre jalapeño))
  (ingrediente_picante (nombre cayena))
  (ingrediente_picante (nombre pimienta_de_cayena))
  (ingrediente_picante (nombre pimenton))
  (ingrediente_picante (nombre pimentón))
  (ingrediente_picante (nombre pimenton_picante))
  (ingrediente_picante (nombre pimentón_picante))
  (ingrediente_picante (nombre pimenton_de_la_vera))
  (ingrediente_picante (nombre pimentón_de_la_vera))
  (ingrediente_picante (nombre chile_morron))
  (ingrediente_picante (nombre chile_morrón))
  (ingrediente_picante (nombre chile_aguero))
  (ingrediente_picante (nombre chiles_chipotles))
  (ingrediente_picante (nombre chile_jalapeño))
  (ingrediente_picante (nombre chile_jalapeno))
  (ingrediente_picante (nombre chiles_jalapeños))
  (ingrediente_picante (nombre chile_poblano))
  (ingrediente_picante (nombre chile_piquin))
)

(defrule separar_nombre
  (declare (salience 7))
  (receta (nombre ?nombre)(ingredientes $?ingredientes)(enlace ?enlace))
  =>
  (bind $?nombres (explode$ (lowcase ?nombre)))
  (foreach ?nombre_ $?nombres
    (foreach ?ingrediente $?ingredientes
      (assert (recetas (nombre ?nombre_) (ingrediente ?ingrediente)(enlace ?enlace)))))
)

(defrule coincide_nombre
  (recetas (nombre ?nombre) (ingrediente ?nombre)(enlace ?enlace))
  (receta (nombre ?nombre1) (enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente ?nombre)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente ?nombre)))
)

(defrule ajillo_ajo
  (recetas (nombre ajillo) (ingrediente ajo)(enlace ?enlace))
  (receta (nombre ?nombre1) (enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente ajo)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente ajo)))
)

(defrule ajillo_perejil
  (recetas (nombre ajillo) (ingrediente perejil)(enlace ?enlace))
  (receta (nombre ?nombre1) (enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente perejil)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente perejil)))
)

(defrule huevo_huevo_duro
  (recetas (nombre huevo) (ingrediente huevo_duro)(enlace ?enlace))
  (receta (nombre ?nombre1) (enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente huevo_duro)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre1) (ingrediente huevo_duro)))
)

(defrule hacer_importante_aceite_desayuno
  (receta (nombre ?nombre) (tipo_plato desayuno_merienda)(enlace ?enlace))
  (recetas (ingrediente aceite)(enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente aceite)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente aceite)))
)

(defrule hacer_importante_pan_desayuno
  (receta (nombre ?nombre) (tipo_plato desayuno_merienda)(enlace ?enlace))
  (recetas (ingrediente pan)(enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente pan)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente pan)))
)

(defrule fruta_relevante
  (receta (nombre ?nombre)(enlace ?enlace))
  (recetas (ingrediente ?ingrediente)(enlace ?enlace))
  (es_fruta (nombre ?ingrediente))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
)

(defrule carne_pescado_relevante
  (receta (nombre ?nombre)(enlace ?enlace))
  (recetas (ingrediente ?ingrediente)(enlace ?enlace))
  (or (es_pescado (nombre ?ingrediente)) (es_carne (nombre ?ingrediente)))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
)

(defrule comida_china_soja
  (receta (nombre ?nombre) (tipo_cocina china | asiatica)(enlace ?enlace))
  (recetas (ingrediente salsa_de_soja)(enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente salsa_de_soja)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente salsa_de_soja)))
)

(defrule hacer_importante_levadura
  (receta (nombre ?nombre) (tipo_copcion al_horno)(enlace ?enlace))
  (recetas (ingrediente levadura)(enlace ?enlace))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente levadura)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente levadura)))
)


(defrule hacer_importantes_pocos_ingredientes
  "Hacer importantes todos los ingredientes si la receta tiene tres o menos ingredientes"
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (recetas (ingrediente ?ingrediente) (enlace ?enlace))
  (test (<= (length$ $?ingredientes) 3))
  (not (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
  =>
  (assert (propiedad_receta (propiedad ingrediente_relevante) (receta ?nombre) (ingrediente ?ingrediente)))
)

(defrule hacer_vegetariana
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (forall (recetas (ingrediente ?ingrediente) (enlace ?enlace))
          (and (not (es_carne (nombre ?ingrediente)))
               (not (es_pescado (nombre ?ingrediente)))
  ))
  =>
  (assert (propiedad_receta (propiedad es_vegetariana) (receta ?nombre)))
)

(defrule hacer_vegana
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (forall (recetas (ingrediente ?ingrediente) (enlace ?enlace))
          (not (derivados_animales (nombre ?ingrediente))
  ))
  =>
  (assert (propiedad_receta (propiedad es_vegana) (receta ?nombre)))
)

(defrule hacer_picante
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (exists (recetas (ingrediente ?ingrediente) (enlace ?enlace))
          (ingrediente_picante (nombre ?ingrediente))
  )
  =>
  (assert (propiedad_receta (propiedad es_picante) (receta ?nombre)))
)

(defrule hacer_sin_lactosa
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (forall (recetas (ingrediente ?ingrediente) (enlace ?enlace))
          (not (lacteos (nombre ?ingrediente))
  ))
  =>
  (assert (propiedad_receta (propiedad es_sin_lactosa) (receta ?nombre)))
)

(defrule hacer_sin_gluten
  (receta (nombre ?nombre) (ingredientes $?ingredientes) (enlace ?enlace))
  (forall (recetas (ingrediente ?ingrediente) (enlace ?enlace))
          (not (gluten (nombre ?ingrediente))
  ))
  =>
  (assert (propiedad_receta (propiedad es_sin_gluten) (receta ?nombre)))
)

(defrule hacer_de_dieta
  (receta (nombre ?nombre) 
          (Calorias ?calorias) 
          (Grasa ?grasa) 
          (Carbohidratos ?carbohidratos) 
          (numero_personas ?numero_personas))
  (test (or (<= (/ ?calorias ?numero_personas) 500)
            (<= (/ ?grasa ?numero_personas) 22)
            (<= (/ ?carbohidratos ?numero_personas) 55)))
  =>
  (assert (propiedad_receta (propiedad es_de_dieta) (receta ?nombre)))
)

(deftemplate sin_tipo
  (slot nombre)
)

(defrule verificar_sin_tipo
  (receta (nombre ?nombre) (tipo_plato ?tipo))
  (test (not (member$ ?tipo (create$ entrante primer_plato plato_principal postre desayuno_merienda acompanamiento))))
  =>
  (assert (sin_tipo (nombre ?nombre)))
)

(defrule tipo_cocina_tipo_copcion
  (receta (nombre ?nombre)(tipo_copcion a_la_plancha | frito | al_horno))
  ?receta <- (receta (nombre ?nombre))
  (sin_tipo (nombre ?nombre))
  =>
  (modify ?receta (tipo_plato plato_principal))
)

(defrule tipo_cocina_tipo_copcion1
  (receta (nombre ?nombre)(tipo_copcion crudo)(ingredientes $?ingredientes))
  ?receta <- (receta (nombre ?nombre))
  (sin_tipo (nombre ?nombre))
  (test (<= (length$ $?ingredientes) 3))
  =>
  (modify ?receta (tipo_plato desayuno_merienda))
)

(defrule tipo_cocina_tipo_copcion_desayuno
  (receta (nombre ?nombre)(tipo_copcion al_vapor))
  ?receta <- (receta (nombre ?nombre))
  (sin_tipo (nombre ?nombre))
  =>
  (modify ?receta (tipo_plato acompanamiento))
)

(defmodule ObtenerRecetas (import DeducirPropiedades deftemplate receta propiedad_receta posible_receta)(import PedirInformacion deftemplate respuesta))

(defrule usuario_vegetariano
    (respuesta vegetariana)
    (receta (nombre ?nombre)(enlace ?enlace))
    (propiedad_receta (propiedad es_vegetariana) (receta ?nombre))
    =>
    (assert (posible_receta (enlaces ?enlace)))    
)

(defrule vegetariano_terminado
    (declare (salience -10))
    ?f1 <- (respuesta vegetariana)
    ?f2 <- (respuesta 0)
    (not (respuesta 1))
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 1))
)

(defrule usuario_vegano
    (respuesta vegana)
    (receta (nombre ?nombre)(enlace ?enlace))
    (propiedad_receta (propiedad es_vegana) (receta ?nombre))
    =>
    (assert (posible_receta (enlaces ?enlace)))
)

(defrule vegano_terminado
    (declare (salience -10))
    ?f1 <- (respuesta vegana)
    ?f2 <- (respuesta 0)
    (not (respuesta 2))
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 2))
)

(defrule usuario_no_veggie
    (respuesta no)
    (respuesta 0)
    (receta (nombre ?nombre)(enlace ?enlace))
    =>
    (assert (posible_receta (enlaces ?enlace)))
)

(defrule no_vegetariano_terminado
    (declare (salience -10))
    ?f1 <- (respuesta no)
    ?f2 <- (respuesta 0)
    (not (respuesta 3))
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 3))
)

(defrule respuesta_sin_gluten
  ?f1 <- (respuesta si)
  (respuesta 1 | 2 | 3)
  =>
  (assert (respuesta sin_gluten))
  (retract ?f1)
)

(defrule gluten_vege_terminado
    ?f1 <- (respuesta no)
    ?f2 <- (respuesta 1)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 5-1))
)

(defrule gluten_vega_terminado
    (declare (salience -10))
    ?f1 <- (respuesta no)
    ?f2 <- (respuesta 2)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 5-2))
)

(defrule gluten_terminado
    (declare (salience -10))
    ?f1 <- (respuesta no)
    ?f2 <- (respuesta 3)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 5-3))
)

(defrule usuario_sin_gluten
    (respuesta sin_gluten)

    ?f1 <- (posible_receta (enlaces ?enlace))

    (receta (nombre ?nombre)(enlace ?enlace))
    (not (propiedad_receta (propiedad es_sin_gluten) (receta ?nombre)))
    =>
    (retract ?f1)
)

(defrule sin_gluten_vege_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_gluten)
    ?f2 <- (respuesta 1)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 4-1))

)

(defrule sin_gluten_vega_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_gluten)
    ?f2 <- (respuesta 2)
    (not (respuesta 4-2))
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 4-2))

)

(defrule sin_gluten_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_gluten)
    ?f2 <- (respuesta 3)
    (not (respuesta 4-3))
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 4-3))
)

(defrule respuesta_sin_lactosa
  ?f1 <- (respuesta si)
  (respuesta 4-1 | 4-2 | 4-3 | 5-1 | 5-2 | 5-3)
  =>
  (assert (respuesta sin_lactosa))
  (retract ?f1)
)

(defrule respuesta_lactosa
  ?f1 <- (respuesta no)
  (respuesta 4-1 | 4-2 | 4-3 | 5-1 | 5-2 | 5-3)
  =>
  (assert (respuesta 10))
  (retract ?f1)
)

(defrule usuario_sin_lactosa
    (respuesta sin_lactosa)

    ?f1 <- (posible_receta (enlaces ?enlace))

    (receta (nombre ?nombre)(enlace ?enlace))
    (not (propiedad_receta (propiedad es_sin_lactosa) (receta ?nombre)))
    =>
    (retract ?f1)
)

(defrule sin_lactosa_sin_gluten_vege_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 4-1)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-4-1))
    (assert (respuesta 10))
)

(defrule sin_lactosa_sin_gluten_vega_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 4-2)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-4-2))
    (assert (respuesta 10))
)

(defrule sin_lactosa_sin_gluten_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 4-3)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-4-3))
    (assert (respuesta 10))
)

(defrule sin_lactosa_vege_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 5-1)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-5-1))
    (assert (respuesta 10))
)

(defrule sin_lactosa_vega_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 5-2)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-5-2))
    (assert (respuesta 10))
)

(defrule sin_lactosa_terminado
    (declare (salience -10))
    ?f1 <- (respuesta sin_lactosa)
    ?f2 <- (respuesta 5-3)
    =>
    (retract ?f1)
    (retract ?f2)
    (assert (respuesta 6-5-3))
    (assert (respuesta 10))

)


(defrule proponer 
 (respuesta 10)
 =>
 (focus ProponerReceta)
)


(defmodule ProponerReceta (import DeducirPropiedades deftemplate receta posible_receta)(import PedirInformacion deftemplate respuesta))

(defrule proponer_receta
    (posible_receta (enlaces ?enlace))
    =>
    (printout t "Puede que te interese esta receta: " (length$ (find-all-facts ((?f posible_receta)) TRUE)) crlf)
    (printout t "Puede que te interese esta receta: " ?enlace crlf)
)
;;AÑADIR SI QUIERE ALGO MÁS TIPO PICANTE O DE dieta