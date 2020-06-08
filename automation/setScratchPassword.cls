String username = 'test-agoxmfk7kzoh@example.com';
String pass = 'thaioil.1234';
system.setPassword([select id from user where username = :username].id, pass);