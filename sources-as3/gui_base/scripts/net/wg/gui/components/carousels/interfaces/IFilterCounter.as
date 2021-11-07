package net.wg.gui.components.carousels.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   
   public interface IFilterCounter extends IUIComponent
   {
       
      
      function blink() : void;
      
      function hide() : void;
      
      function setCloseButtonTooltip(param1:String) : void;
      
      function setCount(param1:String, param2:Boolean = false, param3:Boolean = false) : void;
      
      function get hasCounter() : Boolean;
      
      function set hasCounter(param1:Boolean) : void;
      
      function get hasButton() : Boolean;
      
      function set hasButton(param1:Boolean) : void;
   }
}
