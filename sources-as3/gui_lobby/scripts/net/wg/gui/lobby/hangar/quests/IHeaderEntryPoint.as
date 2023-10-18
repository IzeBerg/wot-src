package net.wg.gui.lobby.hangar.quests
{
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IHeaderEntryPoint extends IUIComponentEx, IDAAPIModule
   {
       
      
      function get alias() : String;
      
      function set alias(param1:String) : void;
      
      function get marginRight() : int;
      
      function get marginLeft() : int;
      
      function get marginTop() : int;
   }
}
