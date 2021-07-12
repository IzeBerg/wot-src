package net.wg.gui.lobby.rankedBattles19.components.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IRankIcon extends IUIComponentEx, IUpdatable, IResizableRankedComponent
   {
       
      
      function showReflection(param1:Boolean, param2:Boolean = false) : void;
      
      function enableReflection(param1:Boolean) : void;
      
      function getShieldOffset(param1:String) : Number;
      
      function hasVisibleShield() : Boolean;
      
      function useButtonMode(param1:Boolean) : void;
      
      function get isEnabled() : Boolean;
      
      function set isEnabled(param1:Boolean) : void;
   }
}
