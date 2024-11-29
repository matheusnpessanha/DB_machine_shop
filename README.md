# Oficina Database Project
## Descrição do Projeto
Este projeto consiste na modelagem e implementação de um banco de dados lógico para gerenciar as operações de uma oficina mecânica. Foi desenvolvido utilizando MySQL e aborda desde o cadastro de clientes, veículos, funcionários e serviços, até o controle de ordens de serviço, pagamentos e consultas detalhadas.

# Funcionalidades Principais
Cadastro de Clientes: Dados pessoais e de contato.
Gestão de Veículos: Registro de veículos vinculados a clientes.
Funcionários: Cadastro de mecânicos e outros profissionais, com cargos e salários.
Serviços: Catálogo de serviços oferecidos pela oficina, com preços.
Ordens de Serviço (OS): Registro de serviços realizados, vinculando clientes, veículos e funcionários.
Pagamentos: Controle das formas de pagamento e valores por OS.
Consultas Avançadas: Queries que respondem perguntas-chave sobre o funcionamento da oficina.

# Estrutura do Banco de Dados
A modelagem foi baseada no modelo relacional, com tabelas interligadas por chaves primárias e estrangeiras. As principais tabelas incluem:

Cliente
Veículo
Funcionário
Serviço
Ordem de Serviço (OS)
OS_Serviço
Pagamento

### Queries Implementadas
O projeto inclui consultas SQL para responder perguntas importantes, como:

Quantas ordens de serviço cada cliente possui?
Qual funcionário realizou o maior número de serviços?
Relação de serviços realizados por veículo.
Total arrecadado mensalmente.
Lista de clientes com veículos que necessitam revisão pendente.

### Tecnologias Utilizadas
MySQL: Para modelagem, criação e manipulação do banco de dados.
SQL: Para consultas e interações com os dados.

