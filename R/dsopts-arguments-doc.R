#' Opciones disponibles dataprep
#'
#' @description
#' Este documento tiene la finalidad de explicar las opciones que
#' se tienen de la categoria dataprep. En donde se hablará respecto a cual es
#' la finalidad del argumento, que valores puede tomar y cúal es el valor esperado
#' que arroje este argumento.
#'
#' @section agg :
#' El argumento `agg` se refiere a "agregación", es decir, cómo los datos
#' se sumarizan o combinan como sumas, promedios, máximos o mínimos. Es necesario especificar
#' con el nombre de las funciones (mean, max, min, etc). Se encuentra únicamente en la categoría "dataprep"
#' y por defecto tiene el valor sum. Además, es de tipo Cat (categórico) y los posibles valores de este
#' argumento son: sum Cat, mean Cat, max Cat, min Cat, std Cat o growth Cat.
#'
#' @section agg_na_rm :
#' El argumento `agg_na_rm` indica si los valores no disponible (NA) deben ser removidos
#' antes de agregar datos. Su valor por defecto es TRUE, es de tipo Chk (Check) y los posibles valores de este es True o False.
#'
#' @section agg_text :
#' El argumento `agg_text` es una etiqueta que se coloca en el nombre de la columna
#' en donde se realiza alguna agregación específica. Se encuentra tambien en la categoría text, su valor por
#' defecto es NULL y este es de tipo Txt(Texto). Algunos de los posibles valores que puede tomar son: sum VAR, mean VAR, max VAR
#'
#' @section drop_na :
#' El argumento `drop_na` excluye datos faltantes(NA) de una visualización en caso de que sea TRUE.
#' Por defecto, su valor es FALSE. Hace parte del hdtype Chk (Check) y los posibles valores que puede tomar son TRUE or FALSE
#'
#' @section drop_na_var2 :
#' El argumento `drop_na_var2` elimina los datos faltantes (NA) de una segunda variable en la visualización.
#' Su valor por default es FALSE, su hdtype es Chk (Check) y sus posibles valores es TRUE o FALSE
#'
#' @section format_number_prefix :
#' El argumento `format_number_prefix` brinda una forma de usar los prefijos del Sistema Internacional de Unidades (SI) tales como
#' k (Miles), M (Millones) en los valores numéricos. Su valor predeterminado es FALSE y su hdtype es chk (Check)
#'
#' @section format_sample_cat :
#' El argumento `format_sample_cat` formato datos categoricos (mayuscula, minuscula, etc). su hdtype es Txt(texto.
#' se encuentra en theme, format, dataclean
#'
#' @section format_sample_dat :
#' El argumento `format_sample_dat` formato para datos de tipo fecha. categoría theme, format, dataprep. es hdtype Txt (texto)
#'
#' @section format_sample_num :
#' El argumento `format_sample_num` formato de los números de la viz, si no se especifica formato por ejes, todos quedan con el formato especificado
#' en este argumento. tambien en theme, format. valor por defecto es 1500 y su hdtype es Txt(texto)
#'
#' @section na_label :
#' El argumento `na_label` etiqueta para reemplazar NA. tambien en text. su hdtype Txt(texto)
#'
#' @section percentage :
#' El argumento `percentage` Si TRUE, se calcula el porcentaje por la variable numerica indicada.
#' se encuentra tambien en bar y pie. valor por defecto FALSE, su tipo hdtype es chk(check)
#'
#' @section percentage_col :
#' El argumento `percentage_col` nombre/s de variable categorica por la cual se desea el porcentaje
#' (solo se activa si percentage es TRUE), default Null, txt (texto)
#'
#' @section percentage_intra :
#' El argumento `percentage_intra` cálculo de porcentajes dentro de categorías individuales o grupos en una visualización
#' por defecto FALSE, su hdtype es Chk
#'
#' @section percentage_name :
#' El argumento `percentage_name` nombre personalizado de la columna si percentage es TRUE, su hdtype es Txt(texto)
#'
#' @section tooltip_agg_collapse_rows_template :
#' El argumento `tooltip_agg_collapse_rows_template` agregación de datos en los tooltips, *controla si filas similares o relacionadas se colapsan en una única entrada en el tooltip para evitar la repetición.
#' Se usa para recibir un dataframe y un template, y retorna una columna de strings con el template aplicado, el template puede aplicar diferentes agregaciones como mean, o max. Ejemplo:
#' "{mean(speed)} k/h con otra variable que es {max(cyl)} cilindros".
#' se encuentra en tooltip, su hdtype es Cat. sus posibles valores son one of funs: sum, mean, etc
#'
#' @section tooltip_include_all_vars :
#' El argumento `tooltip_include_all_vars` incluye todas las variables disponibles en el datafrema ingresado para realizar una visualización.
#' esta tambien en tooltip, por defecto es FALSE, su hdtype es Chk(Check)
#'
#' @section tooltip_sep_all_vars :
#' El argumento `tooltip_sep_all_vars` separador utilizado en los tooltips cuando se incluyen múltiples variables.
#' tambien en tooltip, su hdtype es Cat
#'
#' @section tooltip_template :
#' El argumento `tooltip_template` plantilla de personalizacion de tooltips, tambien en tooltip, su hdtype es Txt, valores posibles
#' Txt tpl_vars in names(df)
NULL
