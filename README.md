# 🛒 Ecommerce App

Aplicação de e-commerce desenvolvida com **Ruby on Rails**, simulando uma loja virtual com funcionalidades como cadastro de produtos, categorias, carrinho de compras, pedidos, usuários e controle de endereços.

---

## 📋 Funcionalidades

- Cadastro de usuários (com autenticação via **Devise**)
- Gestão de produtos e categorias
- Carrinho de compras
- Processo de checkout
- Gerenciamento de pedidos
- Endereços associados aos usuários
- Diferentes perfis de usuário: **Admin**, **Vendedor** e **Usuário padrão**

---

## 🛠️ Tecnologias Utilizadas

- Ruby on Rails
- PostgreSQL
- Docker & Docker Compose
- RSpec (para testes automatizados)
- Devise (autenticação)
- CanCanCan (autorização)
- FactoryBot (fabricação de dados de teste)
- API Stripe (integração de pagamentos)
- API CEP (busca automática de endereço por CEP)

---

## 🚀 Como Rodar o Projeto Localmente

### ✅ Pré-requisitos

- [Docker](https://www.docker.com/) instalado
- [Docker Compose](https://docs.docker.com/compose/) instalado

---

## 🐳 Rodando com Docker

1. Clone o repositório:

   ```bash
   git clone https://github.com/gvicencotti/ecommerce_app.git
   cd ecommerce_app


2. Crie os containers e suba a aplicação:
   ```bash
   docker-compose up --build

3. Crie o banco de dados, rode as migrations e os seeds:
    ```bash
    docker-compose exec web rails db:create db:migrate db:seed

## 🔥 Comandos Úteis no Ambiente Docker
 - Rodar os testes com RSpec:
    ```bash
    docker-compose exec web bundle exec rspec

## 📜 Licença
Este projeto é de uso livre para fins de estudo e demonstração profissional.

## ✨ Observação Final
Projeto desenvolvido com o objetivo de consolidar conhecimentos em backend com Ruby on Rails, seguindo boas práticas de desenvolvimento e utilizando Docker para facilitar a configuração e portabilidade do ambiente.