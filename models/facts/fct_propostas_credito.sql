WITH

source_data AS (
    SELECT
        prop.cod_proposta
        , prop.cod_cliente
        , prop.cod_colaborador
        , cont.cod_agencia
        , prop.data_entrada_proposta
        , prop.taxa_juros_mensal
        , prop.valor_proposta
        , prop.valor_entrada
        , prop.valor_prestacao
        , prop.quantidade_parcelas
        , prop.carencia
        , prop.status_proposta
    FROM
        {{ ref('stg_propostas_credito')}} as prop
    LEFT JOIN
        {{ ref('dim_contas')}} cont
        ON
        prop.cod_cliente = cont.cod_cliente
)

SELECT
    *
FROM
    source_data
