FROM alpine:latest
 
RUN apk add --no-cache \
    git \
    go \
    nodejs \
    npm \
    curl \
    python3 \
    make \
    g++
 
# Устанавливаем Hugo
RUN go install github.com/gohugoio/hugo@latest
 
WORKDIR /src
 
# Копируем package.json если есть, и устанавливаем зависимости
COPY package.json package-lock.json* ./
RUN if [ -f package.json ]; then npm install; fi
 
# Устанавливаем TailwindCSS локально в проект
RUN npm install -D tailwindcss
 
EXPOSE 1313
 
CMD ["/root/go/bin/hugo", "server", "--bind", "0.0.0.0"]


