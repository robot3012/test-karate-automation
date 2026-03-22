function fn() {
    karate.configure('ssl', true);
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  // permitir override de la baseUrl vía -DbaseUrl=...
  var baseUrl = karate.properties['baseUrl'] || java.lang.System.getProperty('baseUrl') || 'https://serverest.dev';
  var config = {
    env: env,
    baseUrl: baseUrl,
    myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}