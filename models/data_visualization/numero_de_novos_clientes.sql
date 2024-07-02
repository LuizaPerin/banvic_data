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
    , COUNT(*) AS novos_clientes
    , cod_cliente
  FROM
    {{ ref('dim_clientes')}} c
  JOIN
    valid_dates d
    ON  CAST(c.data_inclusao AS DATE) = d.date_day
  GROUP BY
    date_month_year, cod_cliente
  ORDER BY
    date_month_year
)

, source_data AS (
  SELECT
    d.month_name
    , d.year_number
    , m.novos_clientes
    , m.cod_cliente
    , c.cod_agencia
    , a.nome
    , a.tipo_agencia
  FROM
    mes_ano m
  LEFT JOIN
    {{ ref('dim_contas')}} c
    ON m.cod_cliente = c.cod_cliente
  LEFT JOIN
    {{ ref('dim_agencias')}} a
    ON a.cod_agencia = c.cod_agencia
  LEFT JOIN
    {{ ref('dim_dates')}} d
    ON m.date_month_year = d.date_day
  ORDER BY
    d.year_number, d.month_of_year
 )

SELECT
  *
FROM
  source_data
