import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const JogoTela(),
    );
  }
}

class JogoTela extends StatefulWidget {
  const JogoTela({super.key});

  @override
  State<JogoTela> createState() => _JogoTelaState();
}

class _JogoTelaState extends State<JogoTela> {
  // O app começa mostrando a imagem padrao.png
  String escolhaApp = 'padrao';
  String escolhaUsuario = '';
  String resultadoImagem = '';
  bool jogoFinalizado = false;

  void jogar(String escolhaDoUsuario) {
    List<String> opcoes = ['pedra', 'papel', 'tesoura'];
    String sorteio = opcoes[Random().nextInt(3)];

    String imagemFinal;
    if (escolhaDoUsuario == sorteio) {
      imagemFinal = 'empate';
    } else if ((escolhaDoUsuario == 'pedra' && sorteio == 'tesoura') ||
        (escolhaDoUsuario == 'papel' && sorteio == 'pedra') ||
        (escolhaDoUsuario == 'tesoura' && sorteio == 'papel')) {
      imagemFinal = 'vitoria';
    } else {
      imagemFinal = 'derrota';
    }

    setState(() {
      escolhaApp = sorteio;
      escolhaUsuario = escolhaDoUsuario;
      resultadoImagem = imagemFinal;
      jogoFinalizado = true;
    });
  }

  void resetarJogo() {
    setState(() {
      escolhaApp = 'padrao';
      escolhaUsuario = '';
      resultadoImagem = '';
      jogoFinalizado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedra, Papel, Tesoura', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Escolha do APP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // IMAGEM DO APP
            Image.asset('assets/images/$escolhaApp.png', height: 120),

            const SizedBox(height: 50),

            if (!jogoFinalizado) ...[
              // TELA 1: FAZER A ESCOLHA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () => jogar('pedra'),
                      child: Image.asset('assets/images/pedra.png', height: 100)
                  ),
                  GestureDetector(
                      onTap: () => jogar('papel'),
                      child: Image.asset('assets/images/papel.png', height: 100)
                  ),
                  GestureDetector(
                      onTap: () => jogar('tesoura'),
                      child: Image.asset('assets/images/tesoura.png', height: 100)
                  ),
                ],
              ),
            ] else ...[
              // TELA 2: RESULTADO
              const Text('Sua Escolha', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Imagem da escolha do usuário
              Image.asset('assets/images/$escolhaUsuario.png', height: 120),

              const SizedBox(height: 30),

              // Imagem do troféu, derrota ou aperto de mãos
              Image.asset('assets/images/$resultadoImagem.png', height: 100),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: resetarJogo,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Jogar novamente', style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ]
          ],
        ),
      ),
    );
  }
}