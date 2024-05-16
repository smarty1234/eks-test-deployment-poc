1.Go to https://home.openweathermap.org/api_keys and get the API key `xxxxx229xxxx06044xxxfb` 
2. Go to spring.starters.io and create a spring boot project
3. coding is available weatherapp
4. `mvn clean install`
5. `mvn spring-boot:run`
6. `http://localhost:8080/forecast?city=dallas&lat=32.7767&lon=96.7970`
7. `weatherapp/Dockerfile` was built and image is available at `manojpadhi/my-weather-app`
8. manually the solution can be tested at `docker run -p 8080:8080 manojpadhi/my-weather-app`
9. In AWS `http://52.15.142.162:8080/weather?city=dallas&lat=32.7767&lon=96.7970` looks like the website is blocking and works with localhost
10. Jenkins `http://ec2-52-15-142-162.us-east-2.compute.amazonaws.com:32000`
11. images: in images folder