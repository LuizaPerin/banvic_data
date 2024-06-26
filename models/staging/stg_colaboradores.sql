WITH

source_data AS (
    SELECT
        cod_colaborador
        , primeiro_nome
        , ultimo_nome
        , email
        , cpf
        , data_nascimento
        , endereco
        , REPLACE(cep, '-', '') AS cep
    FROM
        {{ source('raw-data', 'colaboradores')}}
)

SELECT
    *
FROM
    source_data
