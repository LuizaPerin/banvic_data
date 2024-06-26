WITH

source_data AS (
    SELECT
        cod_proposta
        , cod_cliente
        , cod_colaborador
        , CAST(data_entrada_proposta AS TIMESTAMP) AS data_entrada_proposta
        , taxa_juros_mensal
        , valor_proposta
        , valor_entrada
        , valor_prestacao
        , quantidade_parcelas
        , carencia
        , status_proposta
    FROM
        {{ source('raw-data', 'propostas_credito')}}
)

SELECT
    *
FROM
    source_data
