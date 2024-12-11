import os
from model.vingadores import Vingadores
from model.database import Database

class Interface:

    def __init__(self):
        Vingadores.carregar_herois()
        self.apresentar_menu_principal()

    @staticmethod
    def imprimir_titulo_app():
        print(''' 
░█▀▀█ ▀█░█▀ █▀▀ █▀▀▄ █▀▀▀ █▀▀ █▀▀█ █▀▀ 　 ▒█▀▀█ █▀▀█ █▀▀▄ ▀▀█▀▀ █▀▀█ █▀▀█ █░░ 
▒█▄▄█ ░█▄█░ █▀▀ █░░█ █░▀█ █▀▀ █▄▄▀ ▀▀█ 　 ▒█░░░ █░░█ █░░█ ░░█░░ █▄▄▀ █░░█ █░░ 
▒█░▒█ ░░▀░░ ▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ ▀░▀▀ ▀▀▀ 　 ▒█▄▄█ ▀▀▀▀ ▀░░▀ ░░▀░░ ▀░▀▀ ▀▀▀▀ ▀▀▀''')
    
    @staticmethod
    def apresentar_menu_principal():
        while True:
            os.system('cls')
            Interface.imprimir_titulo_app()
            print('\nMenu Principal')
            print('1. Cadastrar Vingador')
            print('2. Listar Vingadores')
            print('3. Convocar Vingador')
            print('4. Aplicar Tornozeleira')
            print('5. Aplicar Chip GPS')
            print('6. Listar Detalhes do Vingador')
            print('7. Emitir Mandado de Prisão')
            print('8. Sair')
            print()
            Interface.ler_opcao_usuario()

    @staticmethod
    def ler_opcao_usuario():
        try:
            opcao = int(input('Digite sua opção: '))
            if opcao == 1:
                Interface.cadastrar_vingador()
            elif opcao == 2:
                Vingadores.listar_vingadores()
            elif opcao == 3:
                Interface.convocar_vingador()
            elif opcao == 4:
                Interface.aplicar_tornozeleira()
            elif opcao == 5:
                Interface.aplicar_chip()
            elif opcao == 6:
                Interface.listar_detalhes_vingador()
            elif opcao == 7:
                Interface.emitir_mandado()
            elif opcao == 8:
                print('Encerrando o programa...')
                exit()
            else:
                print('Opção inválida!')
        except ValueError:
            print('Por favor, insira um número válido.')
        input('Pressione ENTER para continuar.')

    @staticmethod
    def cadastrar_vingador():
        os.system('cls')
        Interface.imprimir_titulo_app()
        print('Cadastrando Novo Vingador\n')
        try:
            nome_heroi = input('Nome de Herói: ')
            if Vingadores.buscar_vingador(nome_heroi = nome_heroi):
                print(f'O herói {nome_heroi} já foi cadastrado')
                return
            
            nome_real = input('Nome Real: ')

            categoria = input('Categoria (Humano, Meta-Humano, Androide, Deidade, Alienígena): ')
            if categoria not in Vingadores.categorias_permitidas:
                print('Categoria inválida! EScolha uma das opções permitidas.')
                return


            try:
                nivel_forca=int(input('Nível de Força (0 a 10000): '))
                if not (0 <= nivel_forca <= 10000):
                    raise ValueError('O nível de força deve estar entre 0 e 10000.')
            except ValueError as e:
                print(f'Erro: {e}')
                return

            poderes = input('Poderes (separados por vírgula): ').split(', ') 
            poder_principal = input('Poder Principal: ')
            fraquezas = input('Fraquezas: ').split(', ')

            try:
                db = Database()
                db.connect()

                query = "INSERT INTO heroi (nome_heroi, nome_real, categoria, poderes, poder_principal, fraquezas, nivel_forca) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                values = (nome_heroi, nome_real, categoria, ','.join(poderes), poder_principal, ','.join(fraquezas), nivel_forca)

                cursor = db.execute_query(query, values)

                Vingadores(cursor.lastrowid, nome_heroi, nome_real, categoria, poderes, poder_principal, fraquezas, nivel_forca)
            except Exception as e:
                print(f"Erro ao salvar vingador no banco de dados: {e}")
            finally:
                db.disconnect()

            print(f'{nome_heroi} foi cadstrado com sucesso!')
        except ValueError as e:
            print(f'{e}')

    @staticmethod
    def convocar_vingador():
        os.system('cls')
        Interface.imprimir_titulo_app()
        nome = input('Digite o nome do herói, ou seu nome real, para convocá-lo: ')
        vingador = Vingadores.buscar_vingador(nome_heroi = nome) or Vingadores.buscar_vingador(nome_real = nome)
        if vingador:
            vingador.convocar()
        else:
            print('Vingador não encontrado')

    @staticmethod
    def aplicar_tornozeleira(self):
        os.system('cls')
        Interface.imprimir_titulo_app()
        nome = input('Digite o nome do herói, ou seu nome real, para aplicar a tornozeleira: ')

        vingador = Vingadores.buscar_vingador(nome_heroi = nome) or Vingadores.buscar_vingador(nome_real = nome)

        if vingador:
            vingador.aplicar_tornozeleira()
        else:
            print('Vingador não encontrado')

    @staticmethod
    def aplicar_chip():
        os.system('cls')
        Interface.imprimir_titulo_app()
        nome = input ('Digite o nome do herói, ou seu nome real, para aplicar o chip GPS: ')
        vingador = Vingadores.buscar_vingador(nome_heroi = nome) or Vingadores.buscar_vingador(nome_real = nome)
        if vingador:
            vingador.aplicar_chip()
        else:
            print('Vingador não encontrado')

    @staticmethod
    def listar_detalhes_vingador():
        os.system('cls')
        Interface.imprimir_titulo_app()
        nome = input('Digite o nome do herói, ou seu nome real, para listar detalhes do Vingador: ')
        Vingadores.listar_detalhes_vingador(nome)

    @staticmethod
    def emitir_mandado():
        os.system('cls')
        Interface.imprimir_titulo_app()
        nome = input('Digite o nome do herói, ou seu nome real, para emitir um mandado de prisão: ')
        vingador = Vingadores.buscar_vingador(nome_heroi = nome) or Vingadores.buscar_vingador(nome_real = nome)
        if vingador:
            print(f'Mandado de prisão emitido com sucesso para {vingador.nome_heroi}!')
        else:
            print('Vingador não encontrado')



