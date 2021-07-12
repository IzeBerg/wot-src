from gui.battle_results.components import base, bootcamp
_BOOTCAMP_VO_META = base.DictMeta({'background': '', 
   'rewards': {'medals': [], 'ribbons': [], 'unlocks': []}, 'hasUnlocks': False, 
   'stats': [], 'resultTypeStr': '', 
   'finishReasonStr': '', 
   'showRewards': False, 
   'credits': {'value': 0, 'str': '0'}, 'xp': {'value': 0, 'str': '0'}, 'finishReason': '', 
   'playerResult': '', 
   'videoButtons': []})
_BOOTCAMP_REWARDS_VO_META = base.DictMeta({'medals': [], 'ribbons': [], 'unlocks': []})
_BOOTCAMP_STATVALUE_VO_META = base.DictMeta({'value': 0, 
   'str': '0'})
BOOTCAMP_RESULTS_BLOCK = base.StatsBlock(_BOOTCAMP_VO_META, '')
BOOTCAMP_RESULTS_BLOCK.addComponent(0, bootcamp.BackgroundItem('background'))
BOOTCAMP_RESULTS_BLOCK.addComponent(1, bootcamp.RewardsBlock(_BOOTCAMP_REWARDS_VO_META, 'rewards'))
BOOTCAMP_RESULTS_BLOCK.addComponent(2, bootcamp.HasUnlocksFlag('hasUnlocks'))
BOOTCAMP_RESULTS_BLOCK.addComponent(3, bootcamp.StatsBlock(base.ListMeta(), 'stats'))
BOOTCAMP_RESULTS_BLOCK.addComponent(4, bootcamp.ResultTypeStrItem('resultTypeStr'))
BOOTCAMP_RESULTS_BLOCK.addComponent(5, bootcamp.FinishReasonStrItem('finishReasonStr'))
BOOTCAMP_RESULTS_BLOCK.addComponent(6, bootcamp.ShowRewardsFlag('showRewards'))
BOOTCAMP_RESULTS_BLOCK.addComponent(7, bootcamp.CreditsBlock(_BOOTCAMP_STATVALUE_VO_META, 'credits'))
BOOTCAMP_RESULTS_BLOCK.addComponent(8, bootcamp.XPBlock(_BOOTCAMP_STATVALUE_VO_META, 'xp'))
BOOTCAMP_RESULTS_BLOCK.addComponent(9, bootcamp.FinishReasonItem('finishReason'))
BOOTCAMP_RESULTS_BLOCK.addComponent(10, bootcamp.PlayerResultItem('playerResult'))
BOOTCAMP_RESULTS_BLOCK.addComponent(11, bootcamp.VideoButtonsItem('videoButtons'))