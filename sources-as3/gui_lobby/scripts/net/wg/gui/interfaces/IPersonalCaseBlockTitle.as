package net.wg.gui.interfaces
{
   import net.wg.gui.lobby.tankman.vo.PersonalCaseStatTitleVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IPersonalCaseBlockTitle extends IUIComponentEx
   {
       
      
      function setDate(param1:PersonalCaseStatTitleVO) : void;
   }
}
