package net.wg.gui.lobby.questsWindow.components.interfaces
{
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IConditionRenderer extends IUpdatable, IFocusChainContainer
   {
       
      
      function layout() : void;
      
      function get buttonWidth() : Number;
      
      function set buttonWidth(param1:Number) : void;
   }
}
