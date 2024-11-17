# Étape de base commune
FROM python:3.8 AS base
WORKDIR /usr/src/app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000

# Première image : application Flask pour démo (environnement = production)
FROM base AS prod
CMD ["python", "./app.py"]

# Deuxième image : application Flask avec nodemon pour mises à jour automatiques (environnement = developpement)
FROM base AS dev
RUN apt-get update && apt-get install -y npm
RUN npm install -g nodemon
CMD ["nodemon", "-L", "-e", "html", "--exec", "python app.py"]
