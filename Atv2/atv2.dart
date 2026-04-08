import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppCadastro());
}

class MeuAppCadastro extends StatelessWidget {
  const MeuAppCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CadastroScreen(),
    );
  }
}

// ==========================================
// TELA 1: CADASTRO DE USUÁRIO (Questões 1, 2, 5, 6, 7 e 8)
// ==========================================
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  // Questão 1 e 5: Controllers e variáveis de estado (mantêm os dados ao voltar)
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _emailController = TextEditingController();
  
  String? _sexoSelecionado;
  bool _termosAceitos = false;

  final List<String> _opcoesSexo = ['Masculino', 'Feminino', 'Outro'];

  // Questão 2: Validação de Campos
  void _validarECadastrar() {
    final nome = _nomeController.text.trim();
    final idadeTexto = _idadeController.text.trim();
    final email = _emailController.text.trim();

    // Validação do Nome
    if (nome.isEmpty) {
      _mostrarErro('O campo Nome não pode ser vazio.');
      return;
    }

    // Validação da Idade com try/catch
    if (idadeTexto.isEmpty) {
      _mostrarErro('O campo Idade não pode ser vazio.');
      return;
    }
    try {
      final idade = int.parse(idadeTexto);
      if (idade < 18) {
        _mostrarErro('A idade deve ser maior ou igual a 18 anos.');
        return;
      }
    } catch (e) {
      _mostrarErro('A idade deve ser um número inteiro válido.');
      return;
    }

    // Validação do Email
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _mostrarErro('Insira um email válido (deve conter "@" e ".").');
      return;
    }

    // Validação do Sexo
    if (_sexoSelecionado == null) {
      _mostrarErro('Por favor, selecione o sexo.');
      return;
    }

    // Validação dos Termos
    if (!_termosAceitos) {
      _mostrarErro('Você deve aceitar os termos de uso para continuar.');
      return;
    }

    // Questão 3: Navegação entre Telas (se tudo for válido)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacaoScreen(
          nome: nome,
          idade: idadeTexto,
          email: email,
          sexo: _sexoSelecionado!,
          termosAceitos: _termosAceitos,
        ),
      ),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Descarte dos controllers quando a tela for destruída (Boas práticas)
  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Questão 7: Cor de fundo suave
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Questão 1: Centralizar o conteúdo e usar Column
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Questão 7: Fonte maior e em negrito
              const Text(
                'Preencha os campos abaixo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // Campo Nome
              TextField(
                controller: _nomeController,
                textInputAction: TextInputAction.next, // Questão 6: Enter para o próximo
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  hintText: 'Ex: Maria Silva',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), // Questão 7: Bordas
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Idade
              TextField(
                controller: _idadeController,
                keyboardType: TextInputType.number, // Questão 6: Teclado numérico
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Idade',
                  hintText: 'Ex: 25',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Questão 6: Teclado de email
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Ex: maria@email.com',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Dropdown (Sexo)
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                decoration: InputDecoration(
                  labelText: 'Sexo', // Questão 7: Dropdown com label
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                hint: const Text('Selecione uma opção'),
                items: _opcoesSexo.map((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                onChanged: (String? novoValor) {
                  setState(() {
                    _sexoSelecionado = novoValor;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Checkbox Termos de Uso (Questão 7: Texto explicativo claro)
              Row(
                children: [
                  Checkbox(
                    value: _termosAceitos,
                    onChanged: (bool? valor) {
                      setState(() {
                        _termosAceitos = valor ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Aceito os termos de uso e as políticas de privacidade.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Botão Cadastrar
              ElevatedButton(
                onPressed: _validarECadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Questão 7: Botão azul
                  foregroundColor: Colors.white, // Questão 7: Texto branco
                  padding: const EdgeInsets.symmetric(vertical: 16), // Questão 7: Espaçamento
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TELA 2: CONFIRMAÇÃO (Questões 3, 4 e 8)
// ==========================================
class ConfirmacaoScreen extends StatelessWidget {
  final String nome;
  final String idade;
  final String email;
  final String sexo;
  final bool termosAceitos;

  const ConfirmacaoScreen({
    super.key,
    required this.nome,
    required this.idade,
    required this.email,
    required this.sexo,
    required this.termosAceitos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Confirmação'),
        backgroundColor: Colors.green, // Cor diferente para destacar o sucesso
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Confira seus dados:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Cards de exibição de dados
            _buildDataRow('Nome', nome),
            _buildDataRow('Idade', '$idade anos'),
            _buildDataRow('Email', email),
            _buildDataRow('Sexo', sexo),
            _buildDataRow('Termos Aceitos', termosAceitos ? 'Sim' : 'Não'),
            
            const Spacer(),

            // Questão 4: Botões Voltar e Editar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Text('Editar', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Voltar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para deixar o código limpo (Questão 8)
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}