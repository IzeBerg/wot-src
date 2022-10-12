package net.wg.gui.battle.views.consumablesPanel.interfaces
{
   public interface IBattleOptionalDeviceButton extends IConsumablesButton
   {
       
      
      function setUsed(param1:Boolean, param2:Boolean = false) : void;
      
      function get intCD() : int;
      
      function set intCD(param1:int) : void;
   }
}
