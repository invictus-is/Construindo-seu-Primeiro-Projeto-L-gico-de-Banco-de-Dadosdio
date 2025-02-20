# Construindo-seu-Primeiro-Projeto-L-gico-de-Banco-de-Dadosdio

Projeto de Banco de Dados para E-commerce

Este projeto consiste na modelagem e implementação de um banco de dados para um cenário de e-commerce. O objetivo é gerenciar informações relacionadas a clientes, pedidos, produtos, fornecedores, pagamentos e entregas, além de fornecer consultas SQL para análise e manipulação dos dados.
Descrição do Projeto
Contexto

O banco de dados foi projetado para atender às necessidades de um sistema de e-commerce, onde:

    Clientes podem ser pessoas físicas (PF) ou jurídicas (PJ).

    Pedidos são realizados pelos clientes e podem ter múltiplas formas de pagamento.

    Produtos são fornecidos por fornecedores e gerenciados em estoque.

    Entregas possuem status e código de rastreio para acompanhamento.

    Vendedores podem atuar também como fornecedores.

Modelagem Lógica

O esquema do banco de dados foi projetado com as seguintes entidades e relacionamentos:

    Cliente: Armazena informações de clientes (PF ou PJ).

    Pedido: Registra os pedidos feitos pelos clientes.

    Pagamento: Gerencia as formas de pagamento associadas a cada pedido.

    Entrega: Controla o status e o código de rastreio das entregas.

    Produto: Contém detalhes dos produtos disponíveis.

    Fornecedor: Armazena informações dos fornecedores.

    Estoque: Gerencia a quantidade de produtos fornecidos por cada fornecedor.

    Vendedor: Registra informações dos vendedores.

    Produto_Pedido: Tabela associativa que relaciona produtos a pedidos.
