import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
from os import getenv
 
class Database:
    def __init__(self):
        load_dotenv() 
        self.host = getenv('BD_HOST')
        self.user = getenv('BD_USER')
        self.password = getenv('BD_PSWD')
        self.database = getenv('BD_DATABASE')
        self.connection = None
 
    def connect(self):
        if self.connection and self.connection.is_connected():
            print('Já existe uma conexão ativa.')
            return
        try:
            self.connection = mysql.connector.connect(
                host = self.host,
                user = self.user,
                password = self.password,
                database = self.database
            )
            self.cursor = self.connection.cursor(dictionary=True)
            print('Conexão com o banco de dados realizadas com sucesso')
        except Error as e:
            print(f'Erro: {e}')

    def disconnect(self):
        if self.connection:
            self.connection.close()
            print('Conexão com o banco de dados encerrada com sucesso')

    def execute_query(self, query, values = None):
        try:
            self.cursor.execute(query, values)
            self.connection.commit()
            print(f'Query executada com sucesso: {query}')
            return self.cursor
        except Error as e:
            print(f'Erro: {e}')
            return None
 
    def select(self, query):
        try:
            self.cursor.execute(query)
            return self.cursor.fetchall()
        except Error as e:
            print(f'Erro: {e}')
            return None
