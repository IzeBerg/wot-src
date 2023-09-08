package net.wg.gui.lobby.clans.common
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IClanNameField extends IUIComponentEx
   {
       
      
      function get clanVO() : ClanVO;
      
      function set clanVO(param1:ClanVO) : void;
      
      function get canShowBg() : Boolean;
      
      function set canShowBg(param1:Boolean) : void;
   }
}
