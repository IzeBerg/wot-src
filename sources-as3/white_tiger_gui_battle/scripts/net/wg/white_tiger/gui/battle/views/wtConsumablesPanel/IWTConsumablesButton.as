package net.wg.white_tiger.gui.battle.views.wtConsumablesPanel
{
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   
   public interface IWTConsumablesButton extends IConsumablesButton
   {
       
      
      function setCharge(param1:int, param2:Number, param3:Boolean) : void;
      
      function setSelected(param1:Boolean) : void;
      
      function setDebuffView(param1:Boolean) : void;
   }
}
