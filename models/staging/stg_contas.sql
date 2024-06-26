WITH

source_data AS (
    SELECT
        num_conta
        , cod_cliente
        , cod_agencia
        , cod_colaborador
        , tipo_conta
        , CAST(data_abertura as TIMESTAMP) AS data_abertura
        , saldo_total
        , saldo_disponivel
        , CAST(data_ultimo_lancamento AS TIMESTAMP) AS data_ultimo_lancamento
    FROM
        {{ source('raw-data', 'contas')}}
)

SELECT
    *
FROM
    source_data
