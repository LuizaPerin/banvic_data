WITH

source_data AS (
    SELECT
        col.cod_colaborador
        , colag.cod_agencia
        , col.primeiro_nome
        , col.ultimo_nome
        , col.email
        , col.cpf
        , col.data_nascimento
        , col.endereco
        , col.cep
    FROM
        {{ ref('stg_colaboradores') }} AS col
    LEFT JOIN
        {{ ref ('stg_colaborador_agencia')}} AS colag
        ON
        col.cod_colaborador = colag.cod_colaborador
)

SELECT
    *
FROM
    source_data
