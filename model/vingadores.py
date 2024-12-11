import os
from model.database import Database


class Vingadores:

    lista_de_vingadores = []
    categorias_permitidas = ["Humano", "Meta-Humano", "Androide", "Deidade", "Alienígena"]

    def __init__(self, id, nome_heroi, nome_real, categoria, poderes, poder_principal, fraquezas, nivel_forca):
        if categoria not in Vingadores.categorias_permitidas:
            raise ValueError(f"Categoria inválida, as categorias permitidas são: {', '.join(Vingadores.categorias_permitidas)}")
        
        if not (0 <= nivel_forca <= 10000):
            raise ValueError("O nível de força deve estar entre 0 e 10000.")
        
        if Vingadores.buscar_vingador(nome_heroi = nome_heroi):
            raise ValueError(f'{nome_heroi} já está cadastrado')
        
        if not all(isinstance(poder, str) for poder in poderes):
            raise ValueError('Todos os poderes devem ser strings.')
        if not all(isinstance(fraqueza, str) for fraqueza in fraquezas):
            raise ValueError('Todas as fraquezas devem ser strings.')

        self.id = id
        self.nome_heroi = nome_heroi
        self.nome_real = nome_real
        self.categoria = categoria
        self.poderes = poderes
        self.poder_principal = poder_principal
        self.fraquezas = fraquezas
        self.nivel_forca = nivel_forca
        self.convocado = False
        self.tornozeleira = False
        self.chip = False

        Vingadores.lista_de_vingadores.append(self)

    @classmethod
    def listar_vingadores(cls):
        os.system('cls')
        print(f"{'Nome de Herói':<20}{'Nome Real':<20}{'Categoria':<15}{'Convocado':<10}{'Tornozeleira':<15}{'Chip GPS':<10}")
        print("-" * 100)
        for vingador in cls.lista_de_vingadores:
            print(f"{vingador.nome_heroi:<20}{vingador.nome_real:<20}{vingador.categoria:<15}"
                  f"{'Sim' if vingador.convocado else 'Não':<10}"
                  f"{'Sim' if vingador.tornozeleira else 'Não':<15}"
                  f"{'Sim' if vingador.chip else 'Não':<10}")

    @classmethod
    def listar_detalhes_vingador(cls, nome):
        vingador = cls.buscar_vingador(nome_heroi = nome) or cls.buscar_vingador(nome_real = nome)
        if vingador:
            print(f'Nome de Herói: {vingador.nome_heroi}')
            print(f'Nome Real: {vingador.nome_real}')
            print(f'Categoria: {vingador.categoria}')
            print(f"Poderes: {', '.join(vingador.poderes)}")
            print(f'Poder Principal: {vingador.poder_principal}')
            print(f"Fraquezas: {', '.join(vingador.fraquezas)}")
            print(f'Nível de Força: {vingador.nivel_forca}')
            print(f"Convocado: {'Sim' if vingador.convocado else 'Não'}")
            print(f"Tornozeleira: {'Sim' if vingador.tornozeleira else 'Não'}")
            print(f"Chip GPS: {'Sim' if vingador.chip else 'Não'}")
        else:
            print('Vingador não encontrado.')

             
    @classmethod
    def buscar_vingador(cls, nome_heroi = None, nome_real = None):
        for vingador in cls.lista_de_vingadores:
            if (nome_heroi and vingador.nome_heroi.lower() == nome_heroi.lower()) or (nome_real and vingador.nome_real.lower() == nome_real.lower()):
                return vingador
        return None
    
    def convocar(self):
        if self.convocado:
            print(f'{self.nome_heroi} já foi convocado')
        else:
            self.convocado = True
            self.atualizar_banco('convocado', 1)
            print(f'{self.nome_heroi} foi convocado!')

    def atualizar_banco(self, campo, valor):
        try:
            db = Database()
            db.connect()
            query = f'UPDATE heroi SET {campo} = %s WHERE id = %s'
            db.execute_query(query, (valor, self.id))
        except Exception as e:
            print(f'Erro ao atualizar o banco de dados: {e}')
        finally:
            db.disconnect()
    
    def aplicar_tornozeleira(self):
        if not self.convocado:
            print('O vingador precisa ser convocado antes de aplicar a tornozeleira!')
            return
        
        if self.tornozeleira:
            print('A tornozeleira já está aplicada')
            return
        
        if self.nome_heroi.lower() == 'hulk' or self.nome_heroi.lower() == 'thor':
            print(f'{self.nome_heroi} resiste à tornozeleira!')
            return  

        self.tornozeleira = True
        print(f"{self.nome_heroi} teve a tornozeleira aplicada com sucesso!")

        try:
            db = Database()
            db.connect()
            query = 'UPDATE heroi SET tornozeleira = %s WHERE id = %s'
            db.execute_query(query, (self.tornozeleira, self.id))
            print('Estado da tornozeleira atualizado no banco de dados.')
        except Exception as e:
            print(f'Erro ao atualizar a tornozeleira: {e}')
        finally:
            db.disconnect()

    def aplicar_chip(self):
        if not self.tornozeleira:
            print('O chip GPS só pode ser aplicado após a tornozeleira!')
            return
        
        if self.chip:
            print('O chip GPS já está apliacado')
            return

        self.chip = True
        print(f'{self.nome_heroi} teve o chip GPS aplicado com sucesso!')

        try:
            db = Database()
            db.connect()
            query ='UPDATE heroi SET chip = %s WHERE id = %s'
            db.execute_query(query, (self.chip, self.id))
            print('Estado do Chip GPS foi atualizado no banco de dados.')
        except Exception as e:
            print(f'Erro ao atualizar o chip GPS no banco de dados: {e}')
        finally:
            db.disconnect()

    @staticmethod
    def carregar_herois():
            try:
                db = Database()
                db.connect()

                query = 'SELECT nome_heroi, nome_real, categoria, poderes, poder_principal, fraquezas, nivel_forca * FROM heroi'
                herois = db.select(query)
                for heroi in herois:
                    poderes = heroi['poderes'].split(',') if heroi['poderes'] else []
                    fraquezas = heroi['fraquezas'].split(',') if heroi['fraquezas'] else []
                    Vingadores(
                        heroi['id'], heroi['nome_heroi'], heroi['nome_real'], heroi['categoria'] , poderes, heroi['poder_principal'], fraquezas, heroi['nivel_forca']
                        )
            except Exception as e:
                print(f'Erro: {e}')
            finally:
                db.disconnect()
                