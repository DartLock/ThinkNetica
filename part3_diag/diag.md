Один день(Supervisor)  
│  
├── Утро(Supervisor)  
│   ├── Завтрак(GenServer)  
│   └── Сборка на работу(GenServer)  
│  
├── Поездка на работу(Supervisor)  
│   ├── Подготовка транспорта(GenServer)  
│   └── Поездка в транспорте(GenServer)  
│  
├── Работа(Supervisor)  
│   ├── Выполнение работы(GenServer)  
│   ├── Обед(GenServer)  
│   └── Выполнение работы(GenServer)  
│  
├── Возвращение домой(GenServer)  
│   ├── Подготовка транспорта(GenServer)  
│   └── Поездка в транспорте(GenServer)  
│  
└── Дом(Supervisor)  
    ├── Подготовка ко сну(GenServer)  
    └── Сон(GenServer)  