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

**O que é o UFS (Union File System) ?**
O Union File System (UFS) é o sistema de arquivos em camadas usado pelo Docker para gerenciar imagens e containeres. Ele permite combinar várias camadas de arquivos em um único sistema de arquivos.

* Imagens: São compostas por camadas de leitura
* Containeres: Adicionam uma camada de escrita no topo das camadas de imagem.

Exemplo: Visualizando as camadas de uma imagem.
```bash
docker image history nginx
```

**Volumes**
Os volumes no Docker são usados para armazenar dados persistentes fora do container. Isso é bastante útil porquê, por padrão, os dados dentro de um container são descartados quando ele é destruído.

Exemplo: Listando volumes:
```bash
docker volume ls
```
Exemplo: Criando um volume
```bash
docker volume create meu-volume
```
Exemplo: Usando um volume
```bash
docker run -d -v meu-volume:/dados --name meu-container nginx
```
* -v meu-volume:/dados: Monta o volume ***meu-volume*** no diretório /dados dentro do container.

**Network**
O Docker permite a criação e gerenciamento de redes para que os containeres se comuniquem entre si e com o mundo exterior.
* Tipos de redes:
    * Bridge: Rede padrão para containeres em um host.
    * host: Compartilha a interface de rede com o host.
    * none: Containeres completamente isolados da rede.

Exemplo: Listando as redes disponíveis.
```bash
docker network ls
```
Exemplo: Criando uma rede personalizada.
```bash
docker network create minha-rede
```
Exemplo: Conectando um container a uma rede
```bash
docker container run -d --network minha-rede --name app nginx
```
Exemplo: Conectando dois containeres.
```bash
docker run -d --network minha-rede --name app-backend redis
docker run -d --network minha-rede --name app-frontend nginx
```
Agora, os contêineres podem se comunicar usando seus nomes de host: app-backend e app-frontend.

**Dockerfile**
O Dockerfile é um arquivo de texto contendo instruções para construir uma imagem Docker personalizada. Ele permite definir o ambiente necessário para nossa aplicação.

Para exemplicar nosso Dockerfile vamos utilizar a aplicação Giropops-Senhas presente no diretório /app deste repositório, essa aplicação foi desenvolvida em python e utiliza o Redis.

Antes de criarmos o nosso Dockerfile, vamos subir nosso container Redis.

Exemplo: Criando um container com o Redis.
```bash
docker container run -d --name redis_server -p 6379:6379 redis
```

Exemplo: Criando o Dockerfile para rodar a aplicação Giropops-Senhas
```bash
FROM python
WORKDIR /app
COPY ./app .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
ENV REDIS_HOST=IP_DO_HOST
ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]
```
Salve o arquivo.

Exemplo: Construindo a imagem com o Dockerfile
```bash
docker image build -t giropops-senhas:1.0 .
```
Exemplo: Executando a imagem criada
```bash
docker container run -d --name giropops-senhas -p 5000:5000 giropops-senhas:1.0
```

Acesse em: http://localhost:5000

**Docker Compose**
O Docker compose é uma ferramenta para gerenciar múltiplos containeres em um aplicativo usando um arquivo YAMl para definir serviços, volumes e redes, podemos dizer então que ele é um orquestador de containeres.

Exemplo: Subir a aplicação Giropops com o redis
```bash
services:
# ==================================================
# APP: Giropops-senhas
# Version: 1.0
  giropops-senhas:
    container_name: giropops_app
    build:
      context: ./Build
      dockerfile: Dockerfile
    networks:
      rede_app:
        ipv4_address: 172.25.0.5
    ports:
      - '5000:5000'
    environment:
      - REDIS_HOST=redis_server
    volumes:
      - type: volume
        source: volume
        target: /volume
    deploy:
      labels:
        intranet.casa.description: 'Giropops APP'
        intranet.casa.version: '1.0'
      #replicas: 4
      update_config:
        parallelism: 2
        delay: 30s
      resources:
        reservations:
          cpus: '0.25'
          memory: 16m
        limits:
          cpus: '0.5'
          memory: 32m
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
    healthcheck:
      test: ["CMD", "python", "check.py"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 10s
    depends_on:
      - redis
#================================================
# APP: Redis
# Version:
#================================================
  redis:
    image: redis:latest
    container_name: redis_server
    networks:
      rede_app:
        ipv4_address: 172.25.0.6
    ports:
      - '6379:6379'
    volumes:
      - type: volume
        source: redis_data
        target: /data
    deploy:
      labels:
        intranet.casa.description: "Redis server, usado para salvar os dados da aplicação"
        intranet.casa.version: "1.0"
      #replicas: 4
      update_config:
        parallelism: 2
        delay: 30s
      resources:
        reservations:
          cpus: '0.25'
          memory: 16m
        limits:
          cpus: '0.50'
          memory: 32m
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
    healthcheck:
      test: ["CMD","redis-cli","ping"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 10s
#================================================
volumes:
  volume:
  redis_data:

networks:
  rede_app:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: "172.25.0.0/16"
          ip_range: "172.25.0.0/16"
          gateway: "172.25.0.1"
```

Exemplo: Subir os serviços
```bash
docker-compose up -d
```

Exemplo: Parar o serviços
```bash
docker-compose down
```

<hr>
**Perguntas e respostas**
<hr>

#### Contribuindo
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests para expandir este guia.

