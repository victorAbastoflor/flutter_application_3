FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app

COPY . /app

RUN flutter pub get

RUN flutter build apk --release  # o 'flutter build ios' para iOS
