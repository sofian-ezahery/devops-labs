FROM python:3.13-slim AS base
WORKDIR /app
COPY requirements.txt /app
RUN pip install --prefix=/install -r requirements.txt

FROM python:3.13-slim
WORKDIR /app
COPY --from=base /install /usr/local
COPY /app/ /app/app
RUN useradd python

USER python
EXPOSE 8000
CMD ["uvicorn","--host", "0.0.0.0", "app.main:app"]
