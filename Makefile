# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: omizin <omizin@student.42heilbronn.de>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/14 11:13:53 by omizin            #+#    #+#              #
#    Updated: 2025/04/14 12:46:55 by omizin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

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
	git clone $(SUPULIB_REPO) $(SUPULIB_DIR)

$(SUPULIB_DIR)/SuPuLib.a: $(SUPULIB_DIR)/Makefile
	$(MAKE) -C $(SUPULIB_DIR)

# Compile server
$(NAME_SERVER): $(SUPULIB_DIR)/SuPuLib.a $(SERVER_OBJS)
	$(CC) $(CFLAGS) $(SERVER_OBJS) $(SUPULIB_DIR)/SuPuLib.a -o $(NAME_SERVER)

# Compile client
$(NAME_CLIENT): $(SUPULIB_DIR)/SuPuLib.a $(CLIENT_OBJS)
	$(CC) $(CFLAGS) $(CLIENT_OBJS) $(SUPULIB_DIR)/SuPuLib.a -o $(NAME_CLIENT)

# Compile object files
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJS_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJS_DIR):
	mkdir -p $(OBJS_DIR)

bonus: all

clean:
	$(RM) $(OBJS_DIR)
	$(MAKE) -C $(SUPULIB_DIR) clean

fclean: clean
	$(RM) $(NAME_SERVER) $(NAME_CLIENT)
	$(MAKE) -C $(SUPULIB_DIR) fclean

re: fclean all

.PHONY: all clean fclean re bonus
