FROM node:19-bullseye-slim
WORKDIR /app
COPY . /app
RUN yarn && yarn build

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html