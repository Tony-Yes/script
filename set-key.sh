#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgs2IDJRb7gTNDS/7gyO5V9UkU3kziqXw6jyjHsRa//mBcx8DriezNAxR7nupCJSgFKTC8RTmFs0EvcJm+6sfk596FcZ2ol9WIi0iK7ezC/NHuU5+5SN7rLIvnT7nADPRYRuEsZsrLai+IUFGns+GopX9ynTth9Np3ndT6FvqZl4cUiadpdT836AF1gnk938sBEf4RC18d61QS4DPu3kdvG//i6Tik3PpOUJuN4FXSmBqko++PUuhjOrmUJ9yDksniI+L4nQXPZjYZAjuFC/0NykY8hKAaEFyJwqR4UodxpvMGs4kuT54YbJPLnIP+ZofyDIlzwzfng1BIPV3ZVlT5ffb4yJnwBkjDIZEIS8y/gojjiINyAxxo0aaNy7pXZc1S7wl+YGGPFVJxsqOC58wKMxj87yakI/xK3ZQqvc3lpVP80zwdzSkTdz53h7+P3wcYwXl7m530tU0UOBbp9/SLHkV5hD8BU3/G39LQbtvWftdb67264pYzVpJBfYuYxls= tony@Tony-Akemi" > ~/.ssh/authorized_keys
sed -i "s/^.*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i "s/^.*RSAAuthentication.*/RSAAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^.*AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/g" /etc/ssh/sshd_config
systemctl restart sshd
echo "Done"