import numpy as np
import neat

class NEATControl:
  def __init__(self) -> None:
    # Set configuration file
    config_path = "./config-feedforward.txt"
    self.config = neat.config.Config(neat.DefaultGenome, neat.DefaultReproduction,
                                neat.DefaultSpeciesSet, neat.DefaultStagnation, config_path)

    # Create core evolution algorithm class
    self.p = neat.Population(self.config)

    # Add reporter for fancy statistical result
    self.p.add_reporter(neat.StdOutReporter(True))
    stats = neat.StatisticsReporter()
    self.p.add_reporter(stats)

    # Run NEAT
    self.p.run(self.run, 1000)
    
  def run(self, genomes, config):
    pass


def activate(alive):
  return np.random.randint(2, size=len(alive))