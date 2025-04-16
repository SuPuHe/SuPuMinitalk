/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: omizin <omizin@student.42heilbronn.de>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/14 12:35:19 by omizin            #+#    #+#             */
/*   Updated: 2025/04/15 15:51:35 by omizin           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

volatile sig_atomic_t	g_ack_received = 0;

void	ft_handle_ack(int sig)
{
	(void)sig;
	g_ack_received = 1;
	usleep(50);
}

void	ft_send_char(pid_t pid, char c)
{
	int	i;

	i = 7;
	while (i >= 0)
	{
		g_ack_received = 0;
		if ((c >> i) & 1)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		while (!g_ack_received)
			pause();
		i--;
	}
}

int	main(int argc, char **argv)
{
	int		i;
	pid_t	pid;

	if (argc != 3)
	{
		ft_printf("Try ./client <pid> <string>");
		return (1);
	}
	pid = ft_atoi(argv[1]);
	signal(SIGUSR1, ft_handle_ack);
	i = 0;
	while (argv[2][i])
	{
		ft_send_char(pid, argv[2][i]);
		i++;
	}
	ft_send_char(pid, '\0');
	return (0);
}
