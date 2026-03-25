FROM python:3.11

ENV PYTHONUNBUFFERED=1

WORKDIR /app


RUN pip install --upgrade pip -i https://pypi.org/simple --default-timeout=100
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple poetry
RUN poetry config virtualenvs.create false --local

COPY pyproject.toml poetry.lock ./
RUN poetry install

COPY mysite .

CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]