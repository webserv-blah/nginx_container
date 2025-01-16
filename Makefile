# ------------------------------------------------------------------------------
.DEFAULT_GOAL = all
# ------------------------------------------------------------------------------
# 컨테이너이름과 마운트디렉토리이름
SERVICES      = practice_nginx
VOLUMES       = resources

# ------------------------------------------------------------------------------
# 각 개인의 /$HOME/resources 디렉토리에 마운트됩니다.
MOUNT_DIR     = $(HOME)/$(VOLUMES)
CONFIG        = ./srcs/.config

# ------------------------------------------------------------------------------
$(DATA_DIR) $(MOUNT_DIR):
	sudo mkdir -p $@

$(CONFIG):
	@echo "HOST_MOUNT=$(MOUNT_DIR)" > $@

all: $(DATA_DIR) $(MOUNT_DIR) $(CONFIG)
	docker-compose -f ./srcs/docker-compose.yml up -d --build

clean:
	docker-compose -f ./srcs/docker-compose.yml down

fclean:
	make clean
	sudo rm -rf $(MOUNT_DIR)
	docker volume rm $(VOLUMES)
	docker image prune -f -a
	docker volume prune -f -a
	docker network prune -f

re: $(DATA_DIR) $(MOUNT_DIR) $(CONFIG)
	make fclean
	make all

# ------------------------------------------------------------------------------
# utils
# 1) 컨테이너 터미널 접속
sh:
	docker exec -it $(SERVICES) /bin/bash

# 2) 컨테이너 CMD 로그 확인
log:
	make log $(SERVICES);

# ------------------------------------------------------------------------------
.PHONY: all clean fclean re sh log
