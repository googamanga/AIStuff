# AGI

Copyright 2013, [Alex Gaputin](googamanga@yahoo.com). All rights reserved.

TODO
-test God and Environment
-ADD INSPECT() TO BRAIN SO IT CAN BE TRANSFERED TO ENVIRONMENT.SPAWN()



mutation only on action and initialization

Plan:
  main loop:
    create agents if needed
      copy existing agents or make random or both, no sexual reproduction yet
    each agent acts
    agent judgement (distribute net rewards)
    save data
    clean up dead agents

Models
  God (knows all, judges all, reaches all)
    [needed cus environment is not modeled enough yet]
    environment, god's dirty right hand man
      Agents (collection)
        Brain (model)
          nodes (data structure)
            variables (model)
          connections (data structure)
            variables (model)