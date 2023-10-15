function fn() {
	
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';

  }
  var config = {
    apiURL: 'https://api.realworld.io/api/'
      }
  if (env == 'dev') {
	config.userEmail= 'venkikarate@gmail.com'
	config.userpassword='1992venkappa'
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'qa') {
    // customize
  }
  return config;
}