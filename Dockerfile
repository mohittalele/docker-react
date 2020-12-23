# Dockerfile for multistep container creation for production enviormmenr
# step : builder - build phase
FROM node:alpine

WORKDIR "/app"

COPY package.json .

RUN npm install 

COPY . .
RUN npm run build # build will be create in ./build folder

# step : runner - run phase

FROM nginx 
# we use nginx as web server because it is made for production use.
EXPOSE 80 
# Now just copy the build directory required. This essentially discards all the other infomation from the previous step     
COPY --from=0 /app/build /usr/share/nginx/html
