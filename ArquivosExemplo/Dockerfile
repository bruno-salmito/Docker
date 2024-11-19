FROM debian:11
LABEL description="Desafio pratico do dia 02"
LABEL author="Bruno Salmito"
ADD https://github.com/badtuxx/giropops-senhas.git /app
WORKDIR /app
ENV REDIS_HOST="localhost"
#RUN apt-get update && apt-get install python3 -y && apt-get install pip -y
RUN apt-get update && apt-get install -y pip redis-server
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get install redis -y 
EXPOSE 5000
ENTRYPOINT service redis-server start && python3 -m flask run --host=0.0.0.0
