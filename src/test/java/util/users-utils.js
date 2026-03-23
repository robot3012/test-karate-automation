function fn() {
  function randomId() {
    return java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 16);
  }

  function generateEmail(prefix) {
    var safePrefix = prefix || 'qa';
    return safePrefix + '.' + randomId() + '@example.com';
  }

  function generateUser(overrides) {
    var user = {
      nome: 'QA Test',
      email: generateEmail('qa'),
      password: 'Pwd@1234',
      administrador: 'true'
    };

    if (overrides) {
      for (var k in overrides) {
        user[k] = overrides[k];
      }
    }
    return user;
  }

  return {
    randomId: randomId,
    generateEmail: generateEmail,
    generateUser: generateUser
  };
}

