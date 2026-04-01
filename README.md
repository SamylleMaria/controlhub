# ControlHub

Sistema web de gestão de assinaturas e controle de uso de serviços recorrentes, desenvolvido em PHP puro com arquitetura MVC.

Criado para substituir uma planilha Google que era utilizada para o mesmo fim — funcional, mas com risco de perda de dados e sem controle de acesso adequado.

---

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Tecnologias](#tecnologias)
- [Como Executar](#como-executar)
- [Regras de Negócio](#regras-de-negócio)
- [Tipos de Usuário](#tipos-de-usuário)
- [Estrutura do Projeto](#estrutura-do-projeto)

---

## Sobre o Projeto

O ControlHub permite:

- Cadastro de clientes via página pública
- Validação manual de assinaturas por administradores
- Controle de uso de lavagens por ciclo mensal
- Gestão de parceiros e planos com preços independentes
- Comunicação via WhatsApp
- Redirecionamento para pagamento externo via Mercado Pago

---

## Tecnologias

- PHP (procedural + orientação a objetos)
- MySQL 8
- HTML5, CSS3, JavaScript, jQuery
- Docker + Docker Compose
- Apache

---

## Como Executar

### Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Passo a passo

**1. Clone o repositório**
```bash
git clone https://github.com/SamylleMaria/controlhub.git
cd controlhub
```

**2. Configure o ambiente**
```bash
cp .env.example .env
```
Edite o `.env` com suas configurações de banco de dados.

**3. Suba os containers**
```bash
docker compose up -d
```
O banco de dados será criado automaticamente com as tabelas e dados iniciais.


### Recriar o banco do zero

```bash
docker compose down -v
docker compose up -d
```

> ⚠️ O `-v` destrói o volume do banco. Todos os dados serão perdidos.

---


## Regras de Negócio

### Parceiros e Planos

- O sistema suporta múltiplos parceiros (ex: Shopping, MaxWash)
- Cada parceiro tem seus próprios planos com preços independentes
- Um cliente pertence a um único parceiro, mas pode ser realocado
- Se um parceiro for desativado, todos os clientes vinculados são afetados

### Clientes e Veículos

- Um cliente pode ter mais de um veículo (carro e/ou moto)
- Cada veículo possui uma credencial (foto) que valida o vínculo com o parceiro
- A credencial é validada manualmente pelo administrador

### Assinaturas

- Cada veículo pode ter uma assinatura ativa
- A assinatura é vinculada a um plano do parceiro do cliente
- Status possíveis: `PENDENTE`, `ATIVA`, `INATIVA`
- Uma assinatura começa como `PENDENTE` até o pagamento ser confirmado manualmente

### Ciclo Mensal

- O ciclo é baseado na data de ativação da assinatura
- A renovação ocorre mensalmente no mesmo dia
- Exemplo: ativação em 05/03 → próximo ciclo em 05/04

### Controle de Lavagens

- Cada assinatura tem limite de **2 lavagens simples** e **2 lavagens completas** por ciclo
- Os contadores são resetados a cada novo ciclo
- O uso não é acumulativo — lavagens não utilizadas não passam para o próximo ciclo
- O sistema bloqueia o registro de lavagem ao atingir o limite

### Pagamento

- O cliente é redirecionado para um link externo do Mercado Pago
- Não há integração via API — o pagamento é confirmado manualmente pelo administrador no painel
- Após confirmação, a assinatura muda de `PENDENTE` para `ATIVA`

### Upload de Credencial

- Apenas 1 imagem por veículo
- Armazenada localmente em `/uploads`
- Nome de arquivo único gerado automaticamente
- Validação de tipo e tamanho no upload

---

## Tipos de Usuário

### Administrador
- Editar clientes
- Alterar status de assinatura
- Confirmar pagamento
- Arquivar cliente
- Resetar lavagens manualmente
- Enviar mensagem via WhatsApp

### Funcionário
- Visualizar clientes
- Buscar por nome ou placa
- Registrar lavagens

---

## Estrutura do Projeto

```
controlhub/
├── public/          # entry point e assets
├── app/
│   ├── controllers/
│   ├── models/
│   └── views/
├── routes/
├── config/
├── database/
│   └── init/        # migrations e seeds
└── uploads/
```

---

## Possíveis Evoluções

- Migração para Laravel
- Integração automática com API de pagamento
- Dashboard com métricas
- Sistema multi-empresa (white-label)
- Armazenamento de arquivos em cloud (S3)