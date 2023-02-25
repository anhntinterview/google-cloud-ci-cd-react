FROM node:19-bullseye-slim
WORKDIR /google-cloud-ci-cd-react
COPY . /google-cloud-ci-cd-react
RUN yarn && yarn build

FROM nginx:latest
COPY --from=build /google-cloud-ci-cd-react/build /data/server3