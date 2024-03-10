FROM python:3.11.8-alpine3.19

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install --upgrade -r requirements.txt

COPY ./scripts ./scripts

CMD ["python", "-u", "./scripts/main.py"]
