package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   
   public interface IEventConsumablesButton extends IConsumablesButton
   {
       
      
      function setCharge(param1:int, param2:Number, param3:Boolean) : void;
      
      function setSelected(param1:Boolean) : void;
      
      function setDebuffView(param1:Boolean) : void;
   }
}
