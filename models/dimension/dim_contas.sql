WITH

source_data AS (
    SELECT
        con.num_conta
        , con.cod_cliente
        , con.cod_agencia
        , ag.tipo_agencia
        , con.cod_colaborador
        , con.tipo_conta
        , con.data_abertura
        , con.saldo_total
        , con.saldo_disponivel
        , con.data_ultimo_lancamento
    FROM
        {{ ref('stg_contas')}} AS con
    LEFT JOIN
        {{ ref('stg_agencias')}} AS ag
        ON
        con.cod_agencia = ag.cod_agencia
)

SELECT
    *
FROM
    source_data
