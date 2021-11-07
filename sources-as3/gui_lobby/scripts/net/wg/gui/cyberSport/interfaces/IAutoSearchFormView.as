package net.wg.gui.cyberSport.interfaces
{
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public interface IAutoSearchFormView extends IUIComponentEx, IFocusContainer, IFocusChainContainer
   {
       
      
      function stopTimer() : void;
      
      function enableButtons(param1:Boolean) : void;
      
      function setData(param1:AutoSearchVO) : void;
      
      function setMainLabel(param1:String) : void;
      
      function setTimeDirection(param1:int) : void;
      
      function setCountDownSeconds(param1:int) : void;
      
      function changeButtonsState(param1:Boolean, param2:Boolean) : void;
      
      function get isOnStage() : Boolean;
   }
}
