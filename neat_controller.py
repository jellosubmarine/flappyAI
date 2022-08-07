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

    self.alive_vector = []
    self.top_distances = []
    self.bot_distances = []
    self.bird_y = []
    self.new_data = False
    
    self.output_vector = []
    self.data_ready = False
    
    self.gen_change = False
    
  def start(self):
    # Run NEAT
    print("started neat")
    self.p.run(self.run, 1000)
    
  def run(self, genomes, config):
    print("neat running")
    # Init NEAT
    nets = []

    for _, g in genomes:
        net = neat.nn.FeedForwardNetwork.create(g, config)
        nets.append(net)
        g.fitness = 0
        
    while True:
      if self.gen_change:
        self.gen_change = False
        break
        
      if self.new_data:
        self.new_data = False
        
        self.output_vector = [0 for i in range(len(self.alive_vector))]
        debug_vec =  [0 for i in range(len(self.alive_vector))]
        for idx, alive in enumerate(self.alive_vector):
          if alive:  
            input_data = [self.top_distances[idx],self.bot_distances[idx],self.bird_y[idx]]
            output = nets[idx].activate(input_data)
            # print(output)
            debug_vec[idx] = output[0]
            self.output_vector[idx] = 1 if output[0] > 0 else 0
        # print(debug_vec)
        # print(self.output_vector)
        for idx, alive in enumerate(self.alive_vector):
          if alive:
            genomes[idx][1].fitness += 0.1
          else:
            genomes[idx][1].fitness -= 0.2
        self.data_ready = True
        
        
    


def activate(alive):
  return np.random.randint(2, size=len(alive))