FROM nginx:alpine

# Remove default nginx site
RUN rm -rf /usr/share/nginx/html/*

# Copy production build files
COPY dist/ /usr/share/nginx/html/

# Expose nginx port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
