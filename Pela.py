# -*- coding: utf-8 -*-
# http://pygametutorials.wikidot.com/tutorials-basic
# http://eli.thegreenplace.net/2008/12/13/writing-a-game-in-python-with-pygame-part-i/
'''
Created on 07.10.2013

@author: Märt Sessman
'''

import pygame, math, sys
from pygame.locals import *


class Something():
    pass
class SomethingElse():
    pass

def pela():
    # Parameetrid
    SCREEN_WIDTH, SCREEN_HEIGHT = 400, 400
    BG_COLOR = 150, 150, 80

    pygame.init()
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT), 0, 32)
    clock = pygame.time.Clock()
    run = True
    while run:
        # Limit frame speed to 50 FPS
        #
        # time_passed = clock.tick(50)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False

        # Joonistame tausta
        screen.fill(BG_COLOR)
        pygame.display.flip()    
    pygame.quit()

if __name__ == "__main__" :
    pela()