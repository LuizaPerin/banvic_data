WITH

source_data AS (
    SELECT
        cod_colaborador
        , cod_agencia
    FROM
        {{ source('raw-data', 'colaborador_agencia')}}
)

SELECT
    *
FROM
    source_data
