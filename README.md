# cityhive_homework

Hi everyone,
This code open for learning best practice for clean code architecture by using this plugins:

## flutter_bloc

state managemnt packge

https://pub.dev/packages/flutter_bloc

## get_it

plugin for easy implememnt DI(dependency injection)

note its not pure DI this is service locator that in the background working diff from di but same result :)

https://pub.dev/packages/get_it

## retrofit

plugin for http request this is wrapper for dio plugin

https://pub.dev/packages/retrofit

## Hive - nosql DB

plugin for create local db , didnt use in the end

https://pub.dev/packages/floor

## Run project

For run this project we need to do some things:

1.clone project XD

2. search for tut_end_point (nodejs server folder), open it with your favorite ide/command line (vs code,web storm,etc... )

3. run at the terminal/cmd from the path of the server proj ```npm_install```

4. run ```npm start```

5. open flutter project and run it with chrome, or use my public url  - https://city-hive-project.web.app (hosted on firebase hosting) 

## **Notice

If you have problems please check your local address and change some properties:


```static const BASE_URL = "http://localhost:5000/api/";```

to your new address ip value

```static const BASE_URL = "http://{YOURIP}:5000/api/";```

3. run the project and enjoy :)


