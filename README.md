# Docker - Guia introdutório
Este repositório contém informações e exemplos para ajudar a entender conceitos fundamentais do Docker, incluindo contêineres, o que é o Docker, UFS (Union File System), volumes, networks, Dockerfile e Docker Compose.
<hr>
<!--Antes de iniciar o estudo sobre Docker é necessário conhecer alguns conceitos. -->

#### Container
Container é uma tecnologia de virtualização leve usada principalmente para empacotar e isolar aplicativos e suas dependências em um ambiente separado, ou seja, container é uma instância isolada de software que inclui tudo o que é necessário para executá-lo: código, bibliotecas, dependências e arquivos de configuração.

Diferentemente de uma máquina virtual, os contêineres compartilham o mesmo kernel do sistema operacional do host, tornando-se mais leves e rápidos.

Exemplo: Criando e executando um container com a imagem oficial do Nginx usando o docker.

```bash
docker run -d -p 8080:80 --name meu-nginx nginx
```
* -d: Executa o container em segundo plano, como um daemon.
* -p 8080:80: Mapeia a porta 80 do container para a porta 8080 do host.
* --name: Nomeia o container como meu-nginx.

Acesse em: http://localhost:8080

Containeres são muito populares porque oferecem várias vantagens, entre elas vale destacar:
* Portabilidade: Como cada container inclui todas as dependências que ele precisa para a aplicação rodar perfeitamente, da mesma maneira em diversos ambientes sem problemas de compatibilidade.
* Leveza: or não precisarem de um sistema operacional completo consumem menos recursos.
* Escalabilidade: São fáceis de replicar e escalar em diversos ambientes.
* Rapidez:  Se comparado a uma VM comum, a inicialização de um container é extremente rápida.


#### Docker
Docker é uma plataforma de virtualização leve que permite criar, gerenciar e executar aplicativos em containeres, simplificando o desenvolvimento, o envio e a execução de aplicações em qualquer ambiente, independentemente de onde estejam sendo executadas.

* Site oficial: [Docker](https://docker.com/)

Para nosso estudo vamos instalar o docker engine.
```bash
curl -fsSl https://get.docker.com | bash
```
O comando acima instala o Docker em um sistema Linux de forma automatizada, utilizando um script oficial do Docker

**Imagem Docker**
**O que é o UFS (Union File System) ?**
**Volumes**
**Network**
**Dockerfile**
Usar o giropops senhas no diretório /app
**Docker Compose**
**Perguntas e respostas**
<hr>

#### Contribuindo
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests para expandir este guia.

