package net.wg.gui.bootcamp.battleResult.containers.bottomReward
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   
   public class BottomRewardContainer extends UIComponentEx
   {
       
      
      public var rewardMC:MovieClip = null;
      
      public var reward:AnimatedTextContainer = null;
      
      private var _data:DataProvider = null;
      
      public function BottomRewardContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.reward.text = BOOTCAMP.PROGRESSION_LABEL;
         this.reward.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.reward.dispose();
         this.reward = null;
         this.rewardMC = null;
         this._data = null;
         super.onDispose();
      }
      
      public function animate() : void
      {
         this.rewardMC.visible = true;
         this.reward.visible = true;
         this.play();
      }
   }
}
