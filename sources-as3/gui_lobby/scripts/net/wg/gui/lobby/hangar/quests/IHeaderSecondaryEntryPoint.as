package net.wg.gui.lobby.hangar.quests
{
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   
   public interface IHeaderSecondaryEntryPoint extends IDAAPIModule, IDisplayObject
   {
       
      
      function get alias() : String;
      
      function set alias(param1:String) : void;
   }
}
