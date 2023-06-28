package net.wg.gui.cyberSport.interfaces
{
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.events.InputEvent;
   
   public interface ICSAutoSearchMainView extends IDisposable, IFocusContainer, IFocusChainContainer, IDisplayObject
   {
       
      
      function enableButtons(param1:Boolean) : void;
      
      function stopTimer() : void;
      
      function changeButtonsState(param1:Boolean, param2:Boolean) : void;
      
      function setData(param1:AutoSearchVO) : void;
      
      function setMainLabel(param1:String) : void;
      
      function setTimeDirection(param1:int) : void;
      
      function setCountDownSeconds(param1:int) : void;
      
      function setSize(param1:Number, param2:Number) : void;
      
      function handleInput(param1:InputEvent) : void;
      
      function removeForm() : void;
      
      function get hasForm() : Boolean;
   }
}
