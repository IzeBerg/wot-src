package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesRewardRibbonVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AnimatedRewardRibbon extends UIComponentEx
   {
      
      private static const SHOW_RIBBON_STATE:String = "showRibbon";
      
      private static const SHOW_AWARD_TEMPLATE_STATE:String = "showAward";
      
      private static const END_FRAME:int = 33;
       
      
      public var award1:AwardItemRendererEx = null;
      
      public var award2:AwardItemRendererEx = null;
      
      public var award3:AwardItemRendererEx = null;
      
      public var award4:AwardItemRendererEx = null;
      
      public var award5:AwardItemRendererEx = null;
      
      public var award6:AwardItemRendererEx = null;
      
      public var rewardIconContainer:AnimatedRewardRibbonIconContainer = null;
      
      public var glow:MovieClip = null;
      
      public var ribbon:MovieClip = null;
      
      private var _awards:Vector.<AwardItemRendererEx> = null;
      
      private var _awardCount:int = 0;
      
      private var _state:String = "";
      
      public function AnimatedRewardRibbon()
      {
         super();
         addFrameScript(END_FRAME,this.onShowRibbonAnimationComplete);
      }
      
      override protected function onDispose() : void
      {
         stop();
         addFrameScript(END_FRAME,null);
         if(this.award1)
         {
            this.award1.dispose();
            this.award1 = null;
         }
         if(this.award2)
         {
            this.award2.dispose();
            this.award2 = null;
         }
         if(this.award3)
         {
            this.award3.dispose();
            this.award3 = null;
         }
         if(this.award4)
         {
            this.award4.dispose();
            this.award4 = null;
         }
         if(this.award5)
         {
            this.award5.dispose();
            this.award5 = null;
         }
         if(this.award6)
         {
            this.award6.dispose();
            this.award6 = null;
         }
         this.rewardIconContainer.dispose();
         this.rewardIconContainer = null;
         this.glow = null;
         this.ribbon = null;
         this._awards.splice(0,this._awards.length);
         this._awards = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._awards = new <AwardItemRendererEx>[this.award1,this.award2,this.award3,this.award4,this.award5,this.award6];
      }
      
      public function setRibbonData(param1:EpicBattlesRewardRibbonVO) : void
      {
         var _loc2_:int = 0;
         if(param1.awards)
         {
            this._awardCount = param1.awards.length;
            _loc2_ = 0;
            while(_loc2_ < this._awardCount)
            {
               this._awards[_loc2_].setData(param1.awards[_loc2_]);
               _loc2_++;
            }
         }
         this.rewardIconContainer.setData(param1);
      }
      
      public function show() : void
      {
         this.setState(SHOW_RIBBON_STATE);
      }
      
      private function onShowRibbonAnimationComplete() : void
      {
         this.setState(SHOW_AWARD_TEMPLATE_STATE + this._awardCount.toString());
      }
      
      private function setState(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         gotoAndPlay(param1);
      }
   }
}
