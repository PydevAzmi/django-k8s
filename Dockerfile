FROM python:3.12-slim-bullseye

# ENV: Show Logs
ENV PYTHONDONTWRITEBYTECODE=1s
ENV PYTHONUNBUFFERED=1

# Create Project Folder 
WORKDIR /code

# Copy Requirements
COPY requirements.txt /code/requirements.txt

# Install Requirements
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y netcat-openbsd

# Copy Project Code > Docker
COPY . /code/

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "project.wsgi:application"]