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

, mes_ano AS (
  SELECT
    DATE_TRUNC(d.date_day, MONTH) AS date_month_year
    , COUNT(t.cod_transacao) AS volume_transacoes
    , SUM(ABS(t.valor_transacao)) AS valor_total_transacoes
    , AVG(ABS(t.valor_transacao)) AS valor_medio_transacoes
    , APPROX_QUANTILES(ABS(t.valor_transacao), 100)[OFFSET(50)] AS mediana_valor_transacoes
    , t.cod_cliente
    , t.cod_agencia
    , t.tipo_agencia
  FROM
    transacoes t
  JOIN
    valid_dates d
    ON CAST(t.data_transacao AS DATE) = d.date_day
  GROUP BY
    date_month_year, cod_cliente, cod_agencia, tipo_agencia
  ORDER BY
    date_month_year
)

, source_data AS (
  SELECT
    d.month_name
    , d.year_number
    , m.volume_transacoes
    , m.valor_total_transacoes
    , m.valor_medio_transacoes
    , m.mediana_valor_transacoes
    , m.cod_cliente
    , m.cod_agencia
    , a.nome
    , a.UF
    , m.tipo_agencia
  FROM
    mes_ano m
  LEFT JOIN
    {{ ref('dim_agencias')}} a
    ON m.cod_agencia = a.cod_agencia
  LEFT JOIN
    {{ ref('dim_dates')}} d
    ON m.date_month_year = d.date_day
  ORDER BY
    year_number, month_of_year
)

SELECT
  *
FROM
  source_data
