FROM python:3.9-slim

WORKDIR /app

COPY . /app

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade Flask
RUN echo "Hello Jenkins"
EXPOSE 5000

# command to run the app
CMD ["python", "app.py"]