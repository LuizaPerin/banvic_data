WITH

source_data AS (
    SELECT
        cod_transacao
        , num_conta
        , CAST(data_transacao AS TIMESTAMP) AS data_transacao
        , nome_transacao
        , valor_transacao
    FROM
        {{ source('raw-data', 'transacoes')}}
)

SELECT
    *
FROM
    source_data
