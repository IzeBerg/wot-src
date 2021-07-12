package net.wg.gui.lobby.quests.components.interfaces
{
   import net.wg.data.VO.AwardsItemVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ITaskAwardItemRenderer extends IUIComponentEx
   {
       
      
      function setData(param1:AwardsItemVO) : void;
   }
}
