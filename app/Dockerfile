FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY hello.py .

EXPOSE 5000

CMD [ "flask", "--app", "hello", "run", "--host=0.0.0.0" ]




