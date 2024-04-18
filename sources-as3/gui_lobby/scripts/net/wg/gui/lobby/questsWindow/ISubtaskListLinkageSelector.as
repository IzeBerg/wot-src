package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISubtaskListLinkageSelector extends IDisposable
   {
       
      
      function getSpecialLinkage(param1:Object, param2:int) : String;
      
      function setUnlocksCount(param1:int, param2:int) : void;
   }
}
