# Gunakan Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy semua file
COPY package*.json ./

# Install dependencies
RUN npm install -g expo-cli
RUN npm install

# Copy semua source code
COPY . .

# Expose port Expo web
EXPOSE 8081

# Jalankan Expo web (bisa diakses lewat browser)
CMD ["npx", "expo", "start", "--web"]
