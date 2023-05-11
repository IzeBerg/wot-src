package net.wg.gui.lobby.clans.common
{
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IClanHeaderComponent extends IUIComponentEx
   {
       
      
      function setEmblem(param1:String) : void;
      
      function setState(param1:ClanProfileHeaderStateVO) : void;
      
      function setBaseInfo(param1:ClanBaseInfoVO) : void;
      
      function updateFilters(param1:Boolean) : void;
   }
}
