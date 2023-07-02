Este é um anticheat feito para servidores de FiveM. Ele foi iniciado em 2021 para meu servidor. Esse anticheat era integrado ao núcleo principal do meu framework, ou seja, para transforma-lo em uma resource eu tive que extrair. Portanto, alguns bugs podem ocorrer e algumas adaptações podem ser necessárias, mas nada muito grande.

Features:

- Detecção do menu na tela do usuário baseado em textos pré-definidos em tabelas. Utilizei o tesseract js para realizar essa leitura de tela.
- Detecção de menus com texturas comumentes utilizadas em mod menus.
- Detecção de stop-resource
- Detecção de modo espectador
- Detecção de dar armas via cheat
- Detecção de remover armas via cheat
- Detecção de botar fogo em player
- Detecção de explosão
- Detecção de retirar player do veículo
- Detecção de spam de particulas

Adicione isso com seus webhooks em seu cfg:

set YAC_clientBan ""
set YAC_removeAllWeapons ""
set YAC_removeWeapon ""
set YAC_giveWeapon ""
set YAC_fireActions ""
set YAC_removeFromVehicle ""
set YAC_spawnParticles ""
set YAC_spawnProp ""

Agradecimentos especiais ao Yume, que havia feito várias outras features que preferi deixar de fora, pois haveria varias dependencias necessárias para funcionar. Todas as features neste repositório, com exceção da engenharia de envio de client por parte do server (by Yume), foram de minha autoria.

![image](https://github.com/gabinfinity/g_anticheat/assets/59806981/ebb2fe4f-b516-4a18-a113-f3a51c6e5d24)

![image](https://github.com/gabinfinity/g_anticheat/assets/59806981/ff92f41b-72eb-436d-8844-e60ad3fd9927)

