Один день(Supervisor):one_for_one  
│  
├── Утро(Supervisor):one_for_one  
│   ├── Утренние приготовления(Supervisor)  
│   │   └── Сборка на работу(GenServer)  
│   └── Завтрак(Supervisor)  
│       └── Процесс завтрака(GenServer)  
│  
├── Транспорт(Supervisor):one_for_one  
│   ├── Подготовка транспорта(Supervisor)  
│   │   └── Прогрев(GenServer)  
│   └── Поездка(Supervisor)  
│       └── Процесс поездки на работу(GenServer)  
│  
├── Работа(Supervisor)  
│   └── Выполнение работы(GenServer)─┐  
│       └── Перерыв(Supervisor)      │  
│           └── Обед(GenServer)──────┘  
│  
├── Возвращение домой(Supervisor):one_for_one  
│   └── Транспорт(Supervisor):one_for_one  
│       ├── Подготовка транспорта(Supervisor)  
│       │   └── Прогрев(GenServer)  
│       └── Поездка(Supervisor)  
│           └── Процесс поездки домой(GenServer)  
│  
└── Дом(Supervisor):one_for_one  
    ├── Вечерние приготовления(Supervisor)  
    │   └── Прием душа(GenServer)  
    └── Ужин(Supervisor)  
        └── Процесс ужина(GenServer)  
