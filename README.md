# 🛒 Ecommerce App
Aplicação de e-commerce desenvolvida com Ruby on Rails, simulando uma loja virtual com funcionalidades de cadastro de produtos, categorias, carrinho de compras, pedidos, usuários e controle de endereços.

# 📋 Funcionalidades
* Cadastro de usuários (com autenticação Devise)

* Gestão de produtos e categorias

* Carrinho de compras

* Processo de checkout

* Gerenciamento de pedidos

* Endereço associado ao usuário

* Diferentes perfis de usuário (admin / vendedor / usuário padrão)

# 🛠️ Tecnologias Utilizadas
* Ruby on Rails

* PostgreSQL

* Docker e Docker Compose

* RSpec para testes

* Devise para autenticação

* CanCanCan

* FactoryBot

* API Stripe (integração de pagamentos)

* API CEP

# 🚀 Como rodar o projeto localmente
Pré-requisitos:
*Docker instalado

*Docker Compose instalado

# 🐳 Rodando com Docker
Clone o repositório:

```git clone https://github.com/seu-usuario/seu-repo.git
cd ecommerce_app

Crie os containers e suba a aplicação:
docker-compose up --build

Crie o banco de dados, rode as migrations e seeds:
docker-compose exec web rails db:create db:migrate db:seed

# 🔥 Comandos úteis no ambiente Docker
docker-compose exec web rspec

# 📜 Licença
Este projeto é de uso livre para fins de estudo e demonstração profissional.

# ✨ Observação Final
Projeto desenvolvido com o objetivo de consolidar conhecimentos em backend Ruby on Rails, seguindo boas práticas de desenvolvimento e configuração com Docker.


