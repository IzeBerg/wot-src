package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.windows.SimpleWindow;
   
   public class SwitchPeripheryWindowMeta extends SimpleWindow
   {
       
      
      public var requestForChange:Function;
      
      public var onDropDownOpened:Function;
      
      public function SwitchPeripheryWindowMeta()
      {
         super();
      }
      
      public function requestForChangeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.requestForChange,"requestForChange" + Errors.CANT_NULL);
         this.requestForChange(param1);
      }
      
      public function onDropDownOpenedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onDropDownOpened,"onDropDownOpened" + Errors.CANT_NULL);
         this.onDropDownOpened(param1);
      }
   }
}
