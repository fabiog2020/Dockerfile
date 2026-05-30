# Usa a versão oficial do n8n baseada em Debian
FROM n8nio/n8n:latest-debian

# Entra como administrador
USER root

# Instala o FFmpeg nativo do Debian
RUN apt-get update && apt-get install -y ffmpeg

# Volta para o usuário padrão de segurança
USER node
