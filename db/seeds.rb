# Garante que os registros antigos sejam limpos para evitar conflitos de ID e 'null: false'
TaskSession.destroy_all
Task.destroy_all
User.destroy_all # Limpa os usuários de teste (OPCIONAL, mas seguro para dev)

puts "Iniciando a criação de dados de teste..."

# --- 1. Criar Usuário de Teste ---
# É crucial que exista um User antes de criar Tasks
test_user = User.find_or_create_by!(email: 'tester@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts "Usuário de teste criado/encontrado: #{test_user.email}"

# --- 2. Criação de Tasks, ATRIBUINDO ao Usuário ---
# Agora, toda Task precisa do atributo 'user: test_user'

# --- 2.1. Tarefa Pendente (pending) ---
Task.find_or_create_by!(title: "Configurar o Projeto Rails e Stimulus", user: test_user) do |task|
  task.description = "Criar a aplicação, configurar Devise e instalar o StimulusJS."
  task.due_date = 1.day.from_now.to_date
  task.status = :pending
end

# --- 2.2. Tarefa Em Progresso (in_progress) ---
task_in_progress = Task.find_or_create_by!(title: "Desenvolver o Cronômetro com StimulusJS", user: test_user) do |task|
  task.description = "Implementar o Controller TaskTracker em Stimulus para iniciar, parar e salvar TaskSessions via AJAX."
  task.due_date = 3.days.from_now.to_date
  task.status = :in_progress
end

# --- 2.3. Tarefa Completa (completed) e Criação de TaskSession ---
task_completed = Task.find_or_create_by!(title: "Estruturar o Banco de Dados (Models e Migrações)", user: test_user) do |task|
  task.description = "Criar os models Task e TaskSession, rodar as migrações e configurar as associações."
  task.due_date = 5.days.ago.to_date
  task.status = :completed
end

# --- 2.4. Outra Tarefa Pendente (UX/UI) ---
Task.find_or_create_by!(title: "Estilizar o Layout Kanban com SCSS", user: test_user) do |task|
  task.description = "Definir as variáveis de cor (pending, progress, completed) e criar o layout de colunas."
  task.due_date = 7.days.from_now.to_date
  task.status = :pending
end

# --- 2.5. Tarefa de Diferencial (LLM) ---
Task.find_or_create_by!(title: "Integrar a API de LLM para Análise de Produtividade", user: test_user) do |task|
  task.description = "Instalar a gem, configurar a chave de API e criar o Service Object para análise semanal de tempo."
  task.due_date = 10.days.from_now.to_date
  task.status = :in_progress
end

# --- 3. Criação de TaskSession (Tempo Rastreado) ---
# Associando a TaskSession à Task COMPLETA
TaskSession.find_or_create_by!(task: task_completed, duration: 3600) do |session|
  session.start_time = 5.days.ago.beginning_of_day
  session.end_time = 5.days.ago.beginning_of_day + 1.hour
end


puts "Criação de Tasks finalizada! Total de #{Task.count} tasks."
puts "Total de #{TaskSession.count} TaskSessions criadas."
