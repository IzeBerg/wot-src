package net.wg.gui.lobby.hangar.quests
{
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IHeaderFlagsEntryPoint extends IUIComponentEx, IDAAPIModule
   {
       
      
      function get marginRight() : int;
      
      function get marginLeft() : int;
      
      function get marginTop() : int;
   }
}
