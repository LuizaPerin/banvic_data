# Projeto de Análise de Dados do BanVic

## Estrutura do Projeto
O projeto está dividido nas seguintes etapas principais:
1. **Extração, Carga e Transformação (ELT) dos Dados**
2. **Limpeza e Normalização dos Dados**
3. **Modelagem das Tabelas de Dimensão e Fato**
4. **Preparação dos Dados para Visualizações**
5. **Desenvolvimento de Dashboards Interativos**

## Ferramentas Utilizadas
- **dbt (data build tool)**: Utilizado para gerenciar o processo de ELT e a transformação dos dados.
- **BigQuery**: Armazenamento e processamento de dados.
- **Tableau**: Criação de dashboards interativos para visualização dos dados.

## Processos de Transformação e Tratamento de Dados
1. **Extração, Carga e Transformação (ELT) dos Dados**: Os dados fornecidos foram inseridos no BigQuery através da função seed do dbt e, em seguida, transformados.
2. **Limpeza e Normalização dos Dados**: O processo de limpeza de dados envolveu a criação de modelos de staging em SQL usando dbt para garantir que os dados estivessem limpos e padronizados.
3. **Modelagem das Tabelas de Dimensão e Fato**: Foram criados modelos para tabelas de dimensão (Clientes, Colaboradores, Agências, Contas, Datas) e tabelas de fato (Transações, Propostas de Crédito).
4. **Preparação dos Dados para Visualizações**: Modelos adicionais foram criados para consolidar e transformar os dados para visualizações no Tableau.

## Análises Realizadas
- **Perfil dos Clientes**: Número de clientes ativos por mês e novos clientes por mês.
- **Desempenho das Agências**: Volume das transações por agência e volume de transações por região.
- **Atividade Mensal**: Volume das transações por mês.
- **Eficiência dos Colaboradores**: Taxa de aprovação das propostas de crédito.

## Acesso ao Dashboard
O dashboard de KPIs desenvolvido para o BanVic oferece uma visão detalhada e intuitiva do desempenho operacional e financeiro do banco. Ele pode ser acessado através do seguinte link: [Dashboard de KPIs BanVic](https://public.tableau.com/shared/HX92R5TDD?:display_count=n&:origin=viz_share_link).
