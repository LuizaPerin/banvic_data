WITH

source_data AS (
    SELECT
        cod_cliente
        , primeiro_nome
        , ultimo_nome
        , email
        , tipo_cliente
        , CAST(data_inclusao AS TIMESTAMP) AS data_inclusao
        , REPLACE(REPLACE(cpfcnpj, '.', ''), '-', '') AS cpf_ou_cnpj
        , data_nascimento
        , endereco
        , REPLACE(cep, '-', '') AS cep
    FROM
        {{ source('raw-data', 'clientes')}}
)

SELECT
    *
FROM
    source_data
