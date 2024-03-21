package net.wg.gui.battle.views.consumablesPanel.interfaces
{
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   
   public interface IBattleShellButton extends IConsumablesButton, ICoolDownCompleteHandler
   {
       
      
      function setNext(param1:Boolean, param2:Boolean = false) : void;
      
      function setCurrent(param1:Boolean, param2:Boolean = false) : void;
      
      function setInfinity(param1:Boolean = false) : void;
      
      function setQuantity(param1:int, param2:Boolean = false) : void;
      
      function setSpgShotResult(param1:int) : void;
      
      function get reloading() : Boolean;
      
      function get coolDownCurrentFrame() : int;
      
      function get empty() : Boolean;
      
      function set empty(param1:Boolean) : void;
   }
}
