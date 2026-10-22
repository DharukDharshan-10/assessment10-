FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
# ⚠️ Intentionally broken command to trigger container crash loop
CMD ["nginx", "-g", "invalid_config_directive_to_fail_rollout;"]
