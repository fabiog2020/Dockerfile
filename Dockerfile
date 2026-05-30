# Etapa 1: Um micro-container temporário para baixar e preparar os arquivos
FROM alpine:latest AS preparador
RUN apk add --no-cache wget tar xz

# Baixa a versão estática oficial do FFmpeg (feita para rodar em qualquer Linux)
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && tar -xJf ffmpeg-release-amd64-static.tar.xz \
    && mv ffmpeg-*-static/ffmpeg /ffmpeg \
    && mv ffmpeg-*-static/ffprobe /ffprobe \
    && chmod +x /ffmpeg /ffprobe

# Etapa 2: A imagem oficial, leve e atualizada do n8n
FROM n8nio/n8n:latest
USER root

# Injeta os binários já prontos e com permissão direta no sistema
COPY --from=preparador /ffmpeg /usr/local/bin/ffmpeg
COPY --from=preparador /ffprobe /usr/local/bin/ffprobe

# Volta para o usuário padrão por segurança
USER node
