package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class PopoverManagerMeta extends BaseDAAPIModule
   {
       
      
      public var requestShowPopover:Function;
      
      public var requestHidePopover:Function;
      
      public function PopoverManagerMeta()
      {
         super();
      }
      
      public function requestShowPopoverS(param1:String, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.requestShowPopover,"requestShowPopover" + Errors.CANT_NULL);
         this.requestShowPopover(param1,param2);
      }
      
      public function requestHidePopoverS() : void
      {
         App.utils.asserter.assertNotNull(this.requestHidePopover,"requestHidePopover" + Errors.CANT_NULL);
         this.requestHidePopover();
      }
   }
}
