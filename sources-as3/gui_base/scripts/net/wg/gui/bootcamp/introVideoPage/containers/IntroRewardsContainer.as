package net.wg.gui.bootcamp.introVideoPage.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.uilogger.UILogger;
   import net.wg.infrastructure.uilogger.bootcamp.BOOTCAMP_LOGGER_CONSTANTS;
   import net.wg.infrastructure.uilogger.bootcamp.TooltipLogger;
   
   public class IntroRewardsContainer extends UIComponentEx
   {
      
      private static const REWARD_RENDERER:String = "IntroRewardUI";
      
      private static const TXREWARDS_POS_Y_SMALL:int = 22;
      
      private static const TXREWARDS_POS_Y:int = 32;
      
      private static const REWARDS_POS_Y_SMALL:int = 69;
      
      private static const REWARDS_POS_Y:int = 87;
      
      private static const BG_HEIGHT_SMALL:int = 222;
      
      private static const BG_HEIGHT:int = 252;
      
      private static const REWARDS_GAP:int = -10;
       
      
      public var txtRewards:TextField = null;
      
      public var rewards:GroupEx = null;
      
      public var background:Sprite = null;
      
      private var _logger:UILogger = null;
      
      public function IntroRewardsContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rewards.layout = new HorizontalGroupLayout(REWARDS_GAP);
         this.rewards.itemRendererLinkage = REWARD_RENDERER;
         this.txtRewards.text = BOOTCAMP.WELLCOME_BOOTCAMP_REWARDS;
         this._logger = new TooltipLogger(this,BOOTCAMP_LOGGER_CONSTANTS.LOGGER_FEATURE,BOOTCAMP_LOGGER_CONSTANTS.INTRO_LOGGER_GROUP);
      }
      
      override protected function onDispose() : void
      {
         if(this._logger)
         {
            this._logger.dispose();
            this._logger = null;
         }
         this.rewards.dispose();
         this.rewards = null;
         this.txtRewards = null;
         this.background = null;
         super.onDispose();
      }
      
      public function setData(param1:BCIntroVideoVO) : void
      {
         this.rewards.dataProvider = param1.rewards;
      }
      
      public function setIsSmall(param1:Boolean) : void
      {
         this.txtRewards.y = !!param1 ? Number(TXREWARDS_POS_Y_SMALL) : Number(TXREWARDS_POS_Y);
         this.rewards.y = !!param1 ? Number(REWARDS_POS_Y_SMALL) : Number(REWARDS_POS_Y);
         height = this.background.height = !!param1 ? Number(BG_HEIGHT_SMALL) : Number(BG_HEIGHT);
      }
   }
}
