package net.wg.gui.components.advanced.interfaces
{
   import net.wg.gui.components.controls.IProgressBar;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IProgressBarAnim extends IUIComponentEx, IProgressBar
   {
       
      
      function setData(param1:Object) : void;
      
      function get useAnim() : Boolean;
      
      function set useAnim(param1:Boolean) : void;
   }
}
