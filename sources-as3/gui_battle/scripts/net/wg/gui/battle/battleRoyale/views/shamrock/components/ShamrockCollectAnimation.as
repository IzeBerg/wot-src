package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ShamrockCollectAnimation extends BattleUIComponent
   {
       
      
      public var valueTF:TextField = null;
      
      public var icon:Sprite = null;
      
      public function ShamrockCollectAnimation()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.valueTF = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function setValue(param1:int) : void
      {
         this.valueTF.text = "+" + param1;
      }
   }
}
