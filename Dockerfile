FROM python
WORKDIR /app
COPY ./app .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
ENV REDIS_HOST=192.168.15.40
ENTRYPOINT [ "flask", "run", "--host=0.0.0.0" ]
