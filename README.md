# Weather

Приложение Погоды

Основу приложения формирует TabBar:
- Модуль главного экрана TabBar’а (CurrentWeather) реализован по архитектуре MVP
- Модуль второго экрана TabBar’а (WeatherDiary) реализован по архитектуре VIPER

Для загрузки данных с API, используется NetworkService, реализованный с применением Dependency Injection

