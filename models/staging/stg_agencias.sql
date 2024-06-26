WITH

source_data AS (
    SELECT
        cod_agencia
        , nome
        , endereco
        , cidade
        , uf
        , data_abertura
        , tipo_agencia
    FROM
        {{ source('raw-data', 'agencias')}}
)

SELECT
    *
FROM
    source_data
