Тут по сути один ГенСервер просто он бывает в разных состояниях,  
в которые переходит последовательно.  
И в каждом почти состоянии вызывает другие попутные процессы,  
типа как Процесс выполнения задачи на работе и одновременно пьет кофе.  
  
#### диаграмма процессов рабочего дня

Главный Supervisor
    │
Один день GenServer
    │
Состояние процесса:
    ├── Завтрак ──> :start ──> :working ──> :ready
    │
    ├── Прием Душа ──> :start ──> :working ──> :ready
    │
    ├── Поездка на работу ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer Прогрев машины ──> :start ──> :working ──> :ready
    │                     └── GenServer Слушает музыку... ──> :start ──> :working ──> :ready
    │
    ├── Процесс работы ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer Выполнение какой-то задачи ──> :start ──> :working ──> :ready
    │                     └── GenServer И одновременно пьет кофе ──> :start ──> :working ──> :ready
    │
    ├── Обеденный перерыв ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer Поглащает бургер ──> :start ──> :working ──> :ready
    │                     └── GenServer И одновременно мыслит о смысле жизни ──> :start ──> :working ──> :ready
    │
    ├── Процесс работы ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer Выполнение какой-то задачи ──> :start ──> :working ──> :ready
    │                     └── GenServer Кофе уже не хочет пить, хотя мысль такая была ──> :ready
    │
    ├── Поездка домой ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer Загляделся и проехал на красный ──> :start ──> :working ──> :ready
    │                     └── GenServer Одновременно наорал на соседнюю машину о том что он не прав  ──> :start ──> :working ──> :ready
    │
    ├── Прием Душа ──> :start ──> :working ──> :ready
    │          │
    │          └──── Supervisor(запускает два процесса)
    │                     ├── GenServer .... ──> :start ──> :working ──> :ready
    │                     └── GenServer ....  ──> :start ──> :working ──> :ready
    │
    ├── Ужин ──> :start ──> :working ──> :ready
    │ 
    └── Сон ──> :start ──> :working ──> :ready

