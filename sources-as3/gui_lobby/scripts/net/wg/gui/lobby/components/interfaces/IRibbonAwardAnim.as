package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IRibbonAwardAnim extends IUIComponentEx
   {
       
      
      function setRendererData(param1:Object) : void;
      
      function blink(param1:Number = 0) : void;
      
      function fadeIn(param1:Number = 0) : void;
      
      function fadeOut(param1:Number = 0) : void;
   }
}
