FROM python:3.12-rc-alpine

WORKDIR /app

# Define so the script knows not to download a new driver version, as
# this Docker image already downloads a compatible chromedriver
ENV AUTO_SOUTHWEST_CHECK_IN_DOCKER=1

RUN apk add --update --no-cache chromium chromium-chromedriver xvfb xauth

RUN adduser -D auto-southwest-check-in -h /app
RUN chown -R auto-southwest-check-in:auto-southwest-check-in /app
USER auto-southwest-check-in

COPY requirements.txt ./
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && rm -r /app/.cache

COPY . .

ENTRYPOINT ["python3", "-u", "southwest.py"]
