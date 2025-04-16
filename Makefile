# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: omizin <omizin@student.42heilbronn.de>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/14 11:13:53 by omizin            #+#    #+#              #
#    Updated: 2025/04/16 11:17:45 by omizin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RESET_COLOR	= \033[0m			# Reset to default color
YELLOW		= \033[1;33m		# Brighter yellow
BLUE		= \033[1;34m		# Bright blue
GREEN		= \033[1;32m		# Bright green
RED			= \033[1;31m		# Bright red
CYAN		= \033[1;36m		# Bright cyan

NAME_SERVER = server
NAME_CLIENT = client

SUPULIB_DIR = SuPuLib
SUPULIB_REPO = https://github.com/SuPuHe/SuPuLib.git
SRCS_DIR = srcs
OBJS_DIR = objs
INCS_DIR = includes

INCLUDE = -I$(INCS_DIR) -I$(SUPULIB_DIR)/libft/includes -I$(SUPULIB_DIR)/ft_printf/includes
CC = cc
CFLAGS = -Wall -Wextra -Werror $(INCLUDE)

RM = rm -rf
# Source files for server
SERVER_SRCS = server.c

SERVER_SRCS := $(addprefix $(SRCS_DIR)/, $(SERVER_SRCS))

SERVER_OBJS = $(SERVER_SRCS:$(SRCS_DIR)/%.c=$(OBJS_DIR)/%.o)

# Source files for client
CLIENT_SRCS = client.c

CLIENT_SRCS := $(addprefix $(SRCS_DIR)/, $(CLIENT_SRCS))

CLIENT_OBJS = $(CLIENT_SRCS:$(SRCS_DIR)/%.c=$(OBJS_DIR)/%.o)

all: $(SUPULIB_DIR)/SuPuLib.a $(NAME_SERVER) $(NAME_CLIENT)

$(SUPULIB_DIR):
	@git clone $(SUPULIB_REPO) $(SUPULIB_DIR)
	@echo "$(GREEN)SuPuLib cloned successfully$(RESET_COLOR)"

$(SUPULIB_DIR)/SuPuLib.a: | $(SUPULIB_DIR)
	@$(MAKE) -C $(SUPULIB_DIR)

# Compile server
$(NAME_SERVER): $(SUPULIB_DIR)/SuPuLib.a $(SERVER_OBJS)
	@$(CC) $(CFLAGS) $(SERVER_OBJS) $(SUPULIB_DIR)/SuPuLib.a -o $(NAME_SERVER)
	@echo "$(GREEN)Server compiled successfully$(RESET_COLOR)"

# Compile client
$(NAME_CLIENT): $(SUPULIB_DIR)/SuPuLib.a $(CLIENT_OBJS)
	@$(CC) $(CFLAGS) $(CLIENT_OBJS) $(SUPULIB_DIR)/SuPuLib.a -o $(NAME_CLIENT)
	@echo "$(GREEN)Client compiled successfully$(RESET_COLOR)"

# Compile object files
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJS_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

bonus: all

clean:
	@$(RM) $(OBJS_DIR)
	@$(MAKE) -C $(SUPULIB_DIR) clean
	@echo "$(GREEN)Clean sucessfully$(RESET_COLOR)"

fclean: clean
	@$(RM) $(NAME_SERVER) $(NAME_CLIENT)
	@$(MAKE) -C $(SUPULIB_DIR) fclean
	@echo "$(GREEN)Fclean sucessfully$(RESET_COLOR)"

re: fclean all

.PHONY: all clean fclean re bonus
