FROM python:3.8

RUN pip install pipenv==v2020.8.13

WORKDIR /usr/src/app

COPY Pipfile Pipfile.lock ./

COPY index.py ./

RUN pipenv install

EXPOSE 3100

CMD ["pipenv", "run", "python", "index.py"]

