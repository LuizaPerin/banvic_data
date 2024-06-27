WITH

source_data AS (
    SELECT
        cod_cliente
        , primeiro_nome
        , ultimo_nome
        , email
        , tipo_cliente
        , data_inclusao
        , cpf_ou_cnpj
        , data_nascimento
        , endereco
        , cep
    FROM
        {{ ref('stg_clientes')}}
)

SELECT
    *
FROM
    source_data
