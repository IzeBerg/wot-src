package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class VehicleParametersMeta extends BaseDAAPIComponent
   {
       
      
      public var onParamClick:Function;
      
      public var onListScroll:Function;
      
      public function VehicleParametersMeta()
      {
         super();
      }
      
      public function onParamClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onParamClick,"onParamClick" + Errors.CANT_NULL);
         this.onParamClick(param1);
      }
      
      public function onListScrollS() : void
      {
         App.utils.asserter.assertNotNull(this.onListScroll,"onListScroll" + Errors.CANT_NULL);
         this.onListScroll();
      }
   }
}
