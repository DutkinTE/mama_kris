// Функция для получения mock‑данных вакансий
Future<List<Map<String, dynamic>>> getMockJobs() async {
  await Future.delayed(const Duration(seconds: 1)); // имитация задержки
  return [
    {
      "jobID": 1001,
      "job": {
        "jobID": 1001,
        "userID": 5001,
        "description":
            "Описание вакансии 1. Здесь описаны обязанности, требования и условия работы для вакансии 1.",
        "dateTime": "2025-03-05T18:47:45.000Z",
        "salary": "1500.00",
        "status": "approved",
        "title": "Вакансия 1",
        "contactsID": 10001,
      },
    },
    {
      "jobID": 1002,
      "job": {
        "jobID": 1002,
        "userID": 5002,
        "description":
            "Описание вакансии 2. Здесь приведена информация о преимуществах и условиях работы вакансии 2.",
        "dateTime": "2025-03-06T12:30:00.000Z",
        "salary": "2000.00",
        "status": "checking",
        "title": "Вакансия 2",
        "contactsID": 10002,
      },
    },
    {
      "jobID": 1003,
      "job": {
        "jobID": 1003,
        "userID": 5003,
        "description":
            "Описание вакансии 3. Подробное описание обязанностей и требований для вакансии 3.",
        "dateTime": "2025-03-07T09:15:00.000Z",
        "salary": "1800.00",
        "status": "rejected",
        "title": "Вакансия 3",
        "contactsID": 10003,
      },
    },
    {
      "jobID": 1004,
      "job": {
        "jobID": 1004,
        "userID": 5004,
        "description":
            "Описание вакансии 4. Здесь указаны ключевые требования, обязанности и условия работы вакансии 4.",
        "dateTime": "2025-03-08T14:00:00.000Z",
        "salary": "0.00",
        "status": "archived",
        "title": "Вакансия 4",
        "contactsID": 10004,
      },
    },
    {
      "jobID": 1005,
      "job": {
        "jobID": 1005,
        "userID": 5005,
        "description":
            "Описание вакансии 5. Информация о вакансии 5, преимуществах и условиях работы.",
        "dateTime": "2025-03-09T11:45:00.000Z",
        "salary": "2500.00",
        "status": "approved",
        "title": "Вакансия 5",
        "contactsID": 10005,
      },
    },
  ];
}
