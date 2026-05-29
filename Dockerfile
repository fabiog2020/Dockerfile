# Etapa 1: Puxa o FFmpeg
FROM mwader/static-ffmpeg:latest AS ffmpeg

# Etapa 2: Prepara o n8n
FROM n8nio/n8n:latest
USER root

# Copia definindo o nome exato do arquivo no destino
COPY --from=ffmpeg /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /ffprobe /usr/local/bin/ffprobe

# Garante a permissão máxima de execução para os dois arquivos
RUN chmod +x /usr/local/bin/ffmpeg && chmod +x /usr/local/bin/ffprobe

# Volta para o usuário padrão por segurança
USER node
