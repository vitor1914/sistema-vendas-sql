# Sistema de Vendas — SQL e SQLite

## Sobre o projeto

Projeto de banco de dados relacional para gerenciamento de vendas de uma loja, desenvolvido com SQL e SQLite.

O objetivo é organizar informações de clientes, produtos, pedidos, pagamentos e estoque, permitindo consultas para análise e acompanhamento das operações comerciais.

## Estrutura do banco de dados

O banco é composto por sete tabelas:

- `clientes`: cadastro de clientes.
- `categorias`: classificação dos produtos.
- `produtos`: informações dos produtos e estoque.
- `pedidos`: registro dos pedidos de venda.
- `itens_pedido`: produtos e quantidades de cada pedido.
- `pagamentos`: informações e situação dos pagamentos.
- `movimentacoes_estoque`: registro das movimentações de estoque.

## Tecnologias utilizadas

- SQL
- SQLite
- DB Browser for SQLite

## Arquivos do projeto

- `Sistema_vendas.db`: banco de dados SQLite.
- `sistema_vendas.sql`: script SQL exportado do banco.
- `README.md`: documentação do projeto.

## Como executar

1. Instale o SQLite ou o DB Browser for SQLite.
2. Abra o arquivo `Sistema_vendas.db` no DB Browser.
3. Para executar o script SQL em um banco de teste, utilize uma cópia do banco ou crie um banco novo e execute `sistema_vendas.sql` na aba de execução SQL.

## Objetivo profissional

Projeto de portfólio para demonstrar conhecimentos em modelagem de dados relacionais, organização de informações comerciais e utilização de SQL para gerenciamento de dados.
