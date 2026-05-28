# Etapa 1: Puxa uma imagem oficial e leve que contém apenas o FFmpeg
FROM mwader/static-ffmpeg:latest AS ffmpeg

# Etapa 2: Inicia o seu n8n
FROM n8nio/n8n:latest
USER root

# Injeta o ffmpeg e o ffprobe diretamente nas pastas de sistema do n8n
COPY --from=ffmpeg /ffmpeg /usr/local/bin/
COPY --from=ffmpeg /ffprobe /usr/local/bin/

# Volta para o usuário padrão por segurança
USER node
