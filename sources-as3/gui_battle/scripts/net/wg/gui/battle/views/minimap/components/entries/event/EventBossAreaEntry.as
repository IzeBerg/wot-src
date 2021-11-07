package net.wg.gui.battle.views.minimap.components.entries.event
{
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventBossAreaEntry extends BattleUIComponent
   {
       
      
      public var bossArea:Sprite = null;
      
      public function EventBossAreaEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bossArea = null;
         super.onDispose();
      }
      
      public function setVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function setScale(param1:Number, param2:Number) : void
      {
         this.bossArea.scaleX = param1;
         this.bossArea.scaleY = param2;
      }
   }
}
