Main Supervisor
  |
  |---> Coordinator GenServer (отвечает за последовательность процессов)
  |         |
  |         |---> Supervisor (Утренние приготовления)
  |         |         |---> GenServer (логика состояния: start -> working -> ready)
  |         |
  |         |---> Supervisor (Поездка)
  |         |         |---> GenServer (логика состояния: start -> working -> ready)
  |         |
  |         |---> Supervisor (Работа)
  |         |         |---> GenServer (логика состояния: start -> working -> ready)
  |         |
  |         |---> Supervisor (Дом)
  |                   |---> GenServer (логика состояния: start -> working -> ready)
