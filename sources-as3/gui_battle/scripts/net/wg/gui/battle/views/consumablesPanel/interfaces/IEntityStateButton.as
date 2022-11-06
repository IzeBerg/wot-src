package net.wg.gui.battle.views.consumablesPanel.interfaces
{
   import net.wg.gui.battle.components.buttons.interfaces.IBattleButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   
   public interface IEntityStateButton extends IBattleButton
   {
       
      
      function get consumablesVO() : ConsumablesVO;
      
      function set key(param1:int) : void;
      
      function set entityName(param1:String) : void;
      
      function set entityState(param1:String) : void;
   }
}
