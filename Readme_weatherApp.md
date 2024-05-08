1.Go to https://home.openweathermap.org/api_keys and get the API key `xxxxx229xxxx06044xxxfb` 
2. Go to spring.starters.io and create a spring boot project
3. 
- depedency:
  <dependency>
 <groupId>org.springframework.boot</groupId>
 <artifactId>spring-boot-starter-web</artifactId>
 </dependency>
 - Weather Service

@Service
 public class WeatherService {
 private final String MY_WEATHER_API_URL = "https://api.openweathermap.org/data/2.5/weather";
 private final String MY_API_KEY = "<FROM_STEP_1>";
 private final RestTemplate restTemplate;
 public WeatherService(RestTemplate restTemplate) {
 this.restTemplate = restTemplate;
 }.
 public WeatherInformation getWeatherData(double lat, double lon) {
 String url = String.format("%s?lat=%f&lon=%f&appid=%s", MY_WEATHER_API_URL, lat, lon, MY_API_KEY);
 return restTemplate.getForObject(url, WeatherInformation.class);
 }
 }

 @RestController
 @RequestMapping("/weather")
 public class WeatherController {
 private final WeatherService weatherService;
 public WeatherController(WeatherService weatherService) {
 this.weatherService = weatherService;
 }
 @GetMapping("/get")
 public ResponseEntity getWeather(@RequestParam double lat, @RequestParam double lon) {
 WeatherInformation weatherInfo = weatherService.getWeatherData(lat, lon);
 return ResponseEntity.ok().body(weatherInfo);
 }
 }

 - CI/CD

 - Pipeline Stages:

 - Containerize this
Build & Dockerize: Execute build commands specific to your weather microservice and create a Docker image using the docker build command.
 - Store image in ECR
   `docker login -u AWS -p $(aws ecr get-login-password --region us-east-2) XXXXXXXXXX.dkr.ecr.us-east-2.amazonaws.com`
Push to ECR: Authenticate with AWS ECR and push the built Docker image to a designated ECR repository.

Deploy to EKS: Use the kubectl apply command within the pipeline script to deploy the Weather microservice manifest file (e.g., deployment.yaml) referencing the pushed Docker image in ECR.

Configuration:

Jenkinsfile: Define the pipeline stages and commands using a Jenkinsfile stored in your source code repository.
Credentials: Configure Jenkins credentials for accessing your version control system (e.g., Git username/password) and AWS credentials for ECR and EKS access.

 - Tools and Resources:

Jenkins Plugins: Consider plugins like Git Plugin, Docker Pipeline Plugin, Kubernetes API Plugin, ECR Plugin depending on your specific needs.
ECR and Kubernetes Manifests: Set up an ECR repository to store your Docker images and prepare Kubernetes deployment manifests for your weather microservice.
Security: Ensure proper IAM roles and permissions are set for Jenkins to interact with S3, ECR, and EKS securely.
