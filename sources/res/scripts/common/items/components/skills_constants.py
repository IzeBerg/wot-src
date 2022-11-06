SKILL_NAMES = ('reserved', 'commander', 'radioman', 'driver', 'gunner', 'loader', 'repair',
               'fireFighting', 'camouflage', 'brotherhood', 'any', 'reserved', 'reserved',
               'reserved', 'reserved', 'reserved', 'commander_tutor', 'commander_eagleEye',
               'commander_sixthSense', 'commander_expert', 'commander_universalist',
               'commander_enemyShotPredictor', 'reserved', 'reserved', 'reserved',
               'reserved', 'reserved', 'reserved', 'driver_virtuoso', 'driver_smoothDriving',
               'driver_badRoadsKing', 'driver_rammingMaster', 'driver_tidyPerson',
               'reserved', 'reserved', 'reserved', 'reserved', 'gunner_gunsmith',
               'gunner_sniper', 'gunner_smoothTurret', 'gunner_rancorous', 'reserved',
               'reserved', 'reserved', 'reserved', 'reserved', 'loader_pedant', 'loader_desperado',
               'loader_intuition', 'reserved', 'reserved', 'reserved', 'reserved',
               'radioman_inventor', 'radioman_finder', 'radioman_retransmitter',
               'radioman_lastEffort', 'reserved', 'reserved', 'reserved', 'reserved')
SKILL_INDICES = dict((x[1], x[0]) for x in enumerate(SKILL_NAMES) if not x[1].startswith('reserved'))
ORDERED_ROLES = ('commander', 'gunner', 'driver', 'radioman', 'loader')
ROLES = frozenset(('commander', 'radioman', 'driver', 'gunner', 'loader'))
ROLE_LIMITS = {'commander': 1, 'driver': 1}
COMMON_SKILLS = frozenset(('repair', 'fireFighting', 'camouflage', 'brotherhood'))
ROLES_AND_COMMON_SKILLS = ROLES | COMMON_SKILLS
COMMANDER_SKILLS = frozenset(('commander_tutor', 'commander_expert', 'commander_universalist',
                              'commander_sixthSense', 'commander_eagleEye', 'commander_enemyShotPredictor'))
SKILLS_BY_ROLES = {'commander': COMMON_SKILLS.union(COMMANDER_SKILLS), 
   'driver': COMMON_SKILLS.union(('driver_tidyPerson', 'driver_smoothDriving', 'driver_virtuoso',
                     'driver_badRoadsKing', 'driver_rammingMaster')), 
   'gunner': COMMON_SKILLS.union(('gunner_smoothTurret', 'gunner_sniper', 'gunner_rancorous', 'gunner_gunsmith')), 
   'loader': COMMON_SKILLS.union(('loader_pedant', 'loader_desperado', 'loader_intuition')), 
   'radioman': COMMON_SKILLS.union(('radioman_finder', 'radioman_inventor', 'radioman_lastEffort',
                     'radioman_retransmitter'))}
ACTIVE_SKILLS = SKILLS_BY_ROLES['commander'] | SKILLS_BY_ROLES['radioman'] | SKILLS_BY_ROLES['driver'] | SKILLS_BY_ROLES['gunner'] | SKILLS_BY_ROLES['loader']
ACTIVE_FREE_SKILLS = ACTIVE_SKILLS | {'any'}
UNLEARNABLE_SKILLS = ('commander_sixthSense', )
LEARNABLE_ACTIVE_SKILLS = ACTIVE_SKILLS.difference(UNLEARNABLE_SKILLS)
PERKS = frozenset(('brotherhood', 'commander_sixthSense', 'commander_expert', 'commander_enemyShotPredictor',
                   'driver_tidyPerson', 'gunner_rancorous', 'gunner_sniper', 'loader_pedant',
                   'loader_desperado', 'radioman_lastEffort'))