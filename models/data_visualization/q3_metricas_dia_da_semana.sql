WITH

transacoes AS (
    SELECT
        *
    FROM
        {{ ref('fct_transacoes')}}
)

, valid_dates AS (
    SELECT
        *
    FROM
        {{ ref('dim_dates')}}
    WHERE date_day >= (SELECT MIN(CAST(data_transacao AS DATE)) FROM transacoes)
)

, source_data AS (
    SELECT
        dates.date_day
        , dates.day_of_week
        , dates.day_of_week_name
        , dates.day_of_week_name_short
        , trans.cod_transacao
        , trans.num_conta
        , trans.tipo_conta
        , trans.cod_cliente
        , trans.cod_agencia
        , trans.tipo_agencia
        , trans.data_transacao
        , trans.nome_transacao
        , trans.valor_transacao
    FROM
        transacoes AS trans
    LEFT JOIN
        valid_dates AS dates
        ON
        dates.date_day = CAST(trans.data_transacao AS DATE)
)

, analysis as (
    SELECT
        day_of_week
        , day_of_week_name
        , count(*) as volume_transacoes
        , SUM(ABS(valor_transacao)) AS valor_total
        , AVG(ABS(valor_transacao)) AS valor_medio
        , MAX(ABS(valor_transacao)) AS valor_maximo
        , MIN(ABS(valor_transacao)) AS valor_minimo
        , COUNT(DISTINCT cod_cliente) AS num_clientes_distinto
    FROM
        source_data
    GROUP BY
        day_of_week_name, day_of_week
    ORDER BY
        day_of_week
)

-- outras análises que podem ser feitas
, analysis03 AS (
    SELECT
        tipo_agencia
        , COUNT(*) AS volume_transacoes_agencia
        , SUM(ABS(valor_transacao)) AS valor_total_agencia
        , AVG(ABS(valor_transacao)) AS valor_medio_agencia
        , COUNT(DISTINCT cod_agencia) AS num_agencias_distintas
    FROM
        source_data
    GROUP BY
        tipo_agencia
)

SELECT
    *
FROM
    analysis
