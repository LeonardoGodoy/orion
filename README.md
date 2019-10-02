
# Instalação
- Ruby 2.6.1

Clone o projeto em seu workspace favorito.

> git clone https://github.com/LeonardoGodoy/orion.git

Instale a gem bundler para gerenciar os pacotes.
> gem install bundler

Dentro da pasta do projeto, Instale as dependências.
> bundle install

Inicialize o banco de dados com dados básicos de teste em desenvolvimento.

> rails db:create db:migrate db:seed

Inicialize o servidor.
> rails server 

Acesse o servidor em seu navegador preferido pela url.
> http://localhost:3000


# Funcionalidades

## Membro
É o usuário que usufrui das funcionalidades basicas de um grupo.

### Funcionalidades
- Pesquisar grupos
- Criar grupos
- Se desinscrever em grupos
- Se inscrever em grupos

### Variante: Grupo público
- Enviar convite

### Variante: Manager
É o usuário com poder administrativo no contexto de um grupo específico.

- Ao criar um grupo o usuário automáticamente é um manager
- Ao entrar em um grupo o usuário será automatiacamente um membro não manager

#### Funcionalidades adicionais
- Enviar convite
- Adicionar e Remove papel de manager de outros usuários
- Remover usuários do grupo
- Banir usuários do grupo

## Admin
É o usuário responsável pela administração do sistema como um todo. Capaz de banir definitivamente usuários e remover registros que vão contra as políticas de bom uso da plataforma.

- Gerenciar administradores
- Bloquear usuários
- Remover grupos
- Remover instituições
- Remover disciplinas
- Remover cursos

# Desenvolvimento

Para facilitar a utilização e testes da API consumida pelo aplicativo, utilizamos a documentação da ferramenta postman.

> https://documenter.getpostman.com/view/3349066/
