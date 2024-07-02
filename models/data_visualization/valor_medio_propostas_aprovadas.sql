WITH

propostas AS (
  SELECT
    *
  FROM
    {{ ref('fct_propostas_credito')}}
)

, valid_dates AS (
  SELECT
    *
  FROM
    {{ ref('dim_dates')}}
)


, mes_ano AS (
  SELECT
    DATE_TRUNC(d.date_day, MONTH) AS date_month_year
    , a.nome AS agencia
    , a.tipo_agencia
    , CONCAT(col.primeiro_nome, ' ', col.ultimo_nome) AS nome_colaborador
    , AVG(p.valor_proposta) AS valor_medio_propostas_aprovadas
  FROM
    propostas p
  JOIN
    {{ ref('dim_agencias')}} a
    ON p.cod_agencia_colaborador = a.cod_agencia
  JOIN
    {{ ref('dim_colaboradores')}} col
    ON p.cod_colaborador = col.cod_colaborador
  JOIN
    valid_dates d
    ON CAST(p.data_entrada_proposta AS DATE) = d.date_day
  WHERE
    p.status_proposta = 'Aprovada'
  GROUP BY
    d.date_day, a.nome, nome_colaborador, a.tipo_agencia
  ORDER BY
    date_day, nome, valor_medio_propostas_aprovadas DESC
)

, source_data AS (
  SELECT
    d.month_name
    , d.year_number
    , m.agencia
    , m.tipo_agencia
    , m.nome_colaborador
    , m.valor_medio_propostas_aprovadas
  FROM
    mes_ano as m
  JOIN
    valid_dates d
    ON m.date_month_year = d.date_day
  ORDER BY
    year_number, month_of_year
)

SELECT
  *
FROM
  source_data
