import requests
import json
from typing import Dict, Any

class FirebaseDatabase:
    def __init__(self, database_url: str):
        self.database_url = database_url
        self.tasks_ref = f"{self.database_url}/tasks.json"

    def write_new_task(self, user_id: str, title: str, description: str) -> Dict[str, Any]:
        task_data = {
            "user_id": user_id,
            "title": title,
            "description": description,
            "completed": False
        }
        response = requests.post(self.tasks_ref, json=task_data)
        if response.status_code == 200:
            task_id = response.json()['name']
            return {"id": task_id, **task_data}
        else:
            raise Exception("Data could not be saved.")

    def update_task(self, task_id: str, data: Dict[str, Any]) -> None:
        task_ref = f"{self.database_url}/tasks/{task_id}.json"
        response = requests.patch(task_ref, json=data)
        if response.status_code != 200:
            raise Exception("Data could not be updated.")

    def get_task(self, task_id: str) -> Dict[str, Any]:
        task_ref = f"{self.database_url}/tasks/{task_id}.json"
        response = requests.get(task_ref)
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception("Failed to retrieve the task.")

    def get_tasks_once(self) -> Dict[str, Any]:
        response = requests.get(self.tasks_ref)
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception("Failed to retrieve tasks.")

    def get_tasks_by_user(self, user_id: str) -> Dict[str, Any]:
        query_params = {
            "orderBy": '"user_id"',
            "equalTo": f'"{user_id}"'
        }
        response = requests.get(self.tasks_ref, params=query_params)
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception("Failed to retrieve tasks for the user.")

    def delete_task(self, task_id: str) -> None:
        task_ref = f"{self.database_url}/tasks/{task_id}.json"
        response = requests.delete(task_ref)
        if response.status_code != 200:
            raise Exception("Failed to delete the task.")

# Exemplo de uso
if __name__ == "__main__":
    firebase_url = "https://groundon-citta-cardapio-default-rtdb.firebaseio.com"
    database = FirebaseDatabase(firebase_url)

    # Escrever uma nova tarefa
    new_task = database.write_new_task("user123", "Aprender Python", "Estudar POO e requests")
    #print("Nova tarefa criada:", new_task)

    # Atualizar uma tarefa
    database.update_task(new_task['id'], {"completed": True})
    #print("Tarefa atualizada")

    # Ler uma tarefa específica
    task = database.get_task(new_task['id'])
    #print("Tarefa lida:", task)

    # Ler todas as tarefas
    all_tasks = database.get_tasks_once()
    print("Todas as tarefas:", all_tasks)

    # Ler tarefas de um usuário específico
    #user_tasks = database.get_tasks_by_user("user123")
    #print("Tarefas do usuário:", user_tasks)

    # Deletar uma tarefa
    #database.delete_task(new_task['id'])
    #print("Tarefa deletada")