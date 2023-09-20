package net.wg.gui.bootcamp.introVideoPage.containers
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.motion.Tween;
   
   public class IntroLogoContainer extends UIComponentEx
   {
      
      private static const REWARDS_SMALL_PADDING:int = 286;
      
      private static const REWARDS_PADDING:int = 318;
      
      private static const TWEEN_DURATION:int = 1000;
      
      private static const TWEEN_DELAY:int = 1000;
       
      
      public var dashline:Sprite = null;
      
      public var txtDescription:TextField = null;
      
      public var txtReferral:TextField = null;
      
      public var rewards:IntroRewardsContainer = null;
      
      private var _tween:Tween = null;
      
      public function IntroLogoContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.txtDescription = null;
         this.txtReferral = null;
         this.dashline = null;
         if(this.rewards)
         {
            this.rewards.dispose();
            this.rewards = null;
         }
         if(this._tween)
         {
            this._tween.onComplete = null;
            this._tween.onChange = null;
            this._tween.dispose();
            this._tween = null;
         }
         super.onDispose();
      }
      
      public function animate(param1:Boolean) : void
      {
         if(param1)
         {
            this.rewards.alpha = 0;
            this._tween = new Tween(TWEEN_DURATION,this.rewards,{"alpha":1},{
               "delay":TWEEN_DELAY,
               "ease":Strong.easeIn
            });
         }
         else
         {
            this.rewards.visible = false;
         }
      }
      
      public function setData(param1:BCIntroVideoVO) : void
      {
         this.rewards.setData(param1);
      }
      
      public function setIsSmall(param1:Boolean) : void
      {
         this.rewards.y = !!param1 ? Number(REWARDS_SMALL_PADDING) : Number(REWARDS_PADDING);
         this.rewards.setIsSmall(param1);
      }
      
      public function setReferralVisibility(param1:Boolean = false) : void
      {
         this.dashline.visible = param1;
         this.txtReferral.visible = param1;
      }
      
      public function get referralDescription() : String
      {
         return this.txtReferral.text;
      }
      
      public function set referralDescription(param1:String) : void
      {
         this.txtReferral.text = param1;
      }
      
      public function get logoDescription() : String
      {
         return this.txtDescription.text;
      }
      
      public function set logoDescription(param1:String) : void
      {
         this.txtDescription.text = param1;
      }
      
      public function set dashLength(param1:Number) : void
      {
         this.dashline.x = -Math.ceil(this.dashline.width >> 1);
      }
   }
}
