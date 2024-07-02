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

, periodo AS (
    SELECT
        data_transacao
        , valor_transacao
        , CASE
            WHEN EXTRACT(DAY FROM(data_transacao)) BETWEEN 1 AND 15 THEN 'Inicio do Mes'
            ELSE 'Final do Mes'
        END AS periodo_mes
    FROM
    source_data
)

, analysis AS (
    SELECT
        periodo_mes
       ,  AVG(ABS(valor_transacao)) AS valor_medio
    FROM
        periodo
    GROUP BY
        periodo_mes
)

SELECT
    *
FROM
    analysis
