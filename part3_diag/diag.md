Один день(Supervisor)  
│  
├── Утро(Supervisor)  
│   ├── Утренние приготовления(Supervisor)  
│   │   └── Сборка на работу(GenServer)  
│   └── Завтрак(Supervisor)  
│       └── Процесс завтрака(GenServer)  
│  
├── Транспорт(Supervisor)  
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
├── Возвращение домой(Supervisor)  
│   └── Транспорт(Supervisor)  
│       ├── Подготовка транспорта(Supervisor)  
│       │   └── Прогрев(GenServer)  
│       └── Поездка(Supervisor)  
│           └── Процесс поездки домой(GenServer)  
│  
└── Дом(Supervisor)  
    ├── Вечерние приготовления(Supervisor)  
    │   └── Прием душа(GenServer)  
    └── Ужин(Supervisor)  
        └── Процесс ужина(GenServer)  
