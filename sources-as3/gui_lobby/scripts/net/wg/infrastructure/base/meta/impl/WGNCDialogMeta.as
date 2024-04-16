package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.dialogs.SimpleDialog;
   
   public class WGNCDialogMeta extends SimpleDialog
   {
       
      
      public var doAction:Function;
      
      public function WGNCDialogMeta()
      {
         super();
      }
      
      public function doActionS(param1:String, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.doAction,"doAction" + Errors.CANT_NULL);
         this.doAction(param1,param2);
      }
   }
}
