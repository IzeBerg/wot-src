package net.wg.gui.battle.components.buttons.interfaces
{
   public interface ITooltipTarget
   {
       
      
      function get tooltipStr() : String;
      
      function set tooltipStr(param1:String) : void;
      
      function get isTooltipSpecial() : Boolean;
      
      function set isTooltipSpecial(param1:Boolean) : void;
   }
}
