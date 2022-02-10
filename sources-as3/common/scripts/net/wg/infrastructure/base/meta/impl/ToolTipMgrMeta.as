package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class ToolTipMgrMeta extends BaseDAAPIModule
   {
       
      
      public var onCreateComplexTooltip:Function;
      
      public var onCreateTypedTooltip:Function;
      
      public var onHideTooltip:Function;
      
      public var onCreateWulfTooltip:Function;
      
      public function ToolTipMgrMeta()
      {
         super();
      }
      
      public function onCreateComplexTooltipS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onCreateComplexTooltip,"onCreateComplexTooltip" + Errors.CANT_NULL);
         this.onCreateComplexTooltip(param1,param2);
      }
      
      public function onCreateTypedTooltipS(param1:String, param2:Array, param3:String) : void
      {
         App.utils.asserter.assertNotNull(this.onCreateTypedTooltip,"onCreateTypedTooltip" + Errors.CANT_NULL);
         this.onCreateTypedTooltip(param1,param2,param3);
      }
      
      public function onHideTooltipS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onHideTooltip,"onHideTooltip" + Errors.CANT_NULL);
         this.onHideTooltip(param1);
      }
      
      public function onCreateWulfTooltipS(param1:String, param2:Array, param3:int, param4:int) : void
      {
         App.utils.asserter.assertNotNull(this.onCreateWulfTooltip,"onCreateWulfTooltip" + Errors.CANT_NULL);
         this.onCreateWulfTooltip(param1,param2,param3,param4);
      }
   }
}
