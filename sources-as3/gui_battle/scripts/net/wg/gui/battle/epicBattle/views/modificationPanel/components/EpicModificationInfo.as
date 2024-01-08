package net.wg.gui.battle.epicBattle.views.modificationPanel.components
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EpicModificationInfo extends BattleUIComponent
   {
       
      
      public var label:TextField = null;
      
      public function EpicModificationInfo()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         super.onDispose();
      }
      
      public function setLabel(param1:String) : void
      {
         this.label.text = param1;
      }
   }
}
