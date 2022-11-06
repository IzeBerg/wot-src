package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IMinimapEntry extends IUpdatable
   {
       
      
      function isTeamPoint() : Boolean;
      
      function init(param1:String, param2:String, param3:String, param4:String) : void;
   }
}
