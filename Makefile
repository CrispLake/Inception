NAME = Inception

WP_DIR = /home/emajuri/data/wordpress
DB_DIR = /home/emajuri/data/mariadb

COMPOSE = ./srcs/compose.yaml

all: $(NAME)

$(NAME): $(WP_DIR) | $(DB_DIR)
	@grep emajuri.42.fr /etc/hosts > /dev/null || echo "127.0.0.1	emajuri.42.fr" | sudo tee -a /etc/hosts > /dev/null
	docker compose -f $(COMPOSE) up -d

$(WP_DIR):
	mkdir -p $@

$(DB_DIR):
	mkdir -p $@

clean:
	docker compose -f $(COMPOSE) down --rmi all -v

fclean: clean
	sudo sed -i '/emajuri\.42\.fr/d' /etc/hosts
	sudo rm -rf $(WP_DIR) $(DB_DIR)

re: fclean all

restart:
	docker compose -f $(COMPOSE) restart

prune:
	docker system prune -f
