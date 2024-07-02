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
    a.nome AS agencia
    , a.tipo_agencia
    , a.UF
    , c.cod_cliente
    , COUNT(t.cod_transacao) AS volume_transacoes
    , SUM(ABS(t.valor_transacao)) AS valor_total_transacoes
  FROM
    TRANSACOES t
  JOIN
    {{ ref('dim_agencias')}} a
    ON t.cod_agencia = a.cod_agencia
  JOIN
    {{ ref('dim_clientes')}} c
    ON t.cod_cliente = c.cod_cliente
  GROUP BY
    a.nome, c.cod_cliente, a.tipo_agencia, a.uf
  ORDER BY
    nome, volume_transacoes DESC
)

SELECT
  *
FROM
  source_data
