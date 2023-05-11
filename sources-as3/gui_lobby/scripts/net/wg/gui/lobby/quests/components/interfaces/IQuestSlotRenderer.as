package net.wg.gui.lobby.quests.components.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IQuestSlotRenderer extends IUIComponentEx, IUpdatable
   {
       
      
      function get separatorVisible() : Boolean;
      
      function set separatorVisible(param1:Boolean) : void;
   }
}
