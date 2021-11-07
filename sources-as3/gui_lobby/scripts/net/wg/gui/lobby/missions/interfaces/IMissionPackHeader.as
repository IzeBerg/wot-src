package net.wg.gui.lobby.missions.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IMissionPackHeader extends IUIComponentEx, IUpdatable
   {
       
      
      function setCollapsed(param1:Boolean, param2:Boolean) : void;
   }
}
