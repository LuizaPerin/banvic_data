WITH

source_data AS (
    SELECT
        trans.cod_transacao
        , trans.num_conta
        , cont.tipo_conta
        , cont.cod_cliente
        , cont.cod_agencia
        , cont.tipo_agencia
        , trans.data_transacao
        , trans.nome_transacao
        , trans.valor_transacao
    FROM
        {{ ref('stg_transacoes')}} AS trans
    LEFT JOIN
        {{ ref('dim_contas')}} AS cont
        ON
        trans.num_conta = cont.num_conta
)

SELECT
    *
FROM
    source_data
