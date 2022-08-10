package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class GraphicsOptimizationManagerMeta extends BaseDAAPIModule
   {
       
      
      public var registerOptimizationArea:Function;
      
      public var unregisterOptimizationArea:Function;
      
      public var updateOptimizationArea:Function;
      
      public var isOptimizationAvailable:Function;
      
      public var isOptimizationEnabled:Function;
      
      public var switchOptimizationEnabled:Function;
      
      public function GraphicsOptimizationManagerMeta()
      {
         super();
      }
      
      public function registerOptimizationAreaS(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         App.utils.asserter.assertNotNull(this.registerOptimizationArea,"registerOptimizationArea" + Errors.CANT_NULL);
         return this.registerOptimizationArea(param1,param2,param3,param4);
      }
      
      public function unregisterOptimizationAreaS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.unregisterOptimizationArea,"unregisterOptimizationArea" + Errors.CANT_NULL);
         this.unregisterOptimizationArea(param1);
      }
      
      public function updateOptimizationAreaS(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         App.utils.asserter.assertNotNull(this.updateOptimizationArea,"updateOptimizationArea" + Errors.CANT_NULL);
         this.updateOptimizationArea(param1,param2,param3,param4,param5);
      }
      
      public function isOptimizationAvailableS(param1:String) : Boolean
      {
         App.utils.asserter.assertNotNull(this.isOptimizationAvailable,"isOptimizationAvailable" + Errors.CANT_NULL);
         return this.isOptimizationAvailable(param1);
      }
      
      public function isOptimizationEnabledS(param1:String) : Boolean
      {
         App.utils.asserter.assertNotNull(this.isOptimizationEnabled,"isOptimizationEnabled" + Errors.CANT_NULL);
         return this.isOptimizationEnabled(param1);
      }
      
      public function switchOptimizationEnabledS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.switchOptimizationEnabled,"switchOptimizationEnabled" + Errors.CANT_NULL);
         this.switchOptimizationEnabled(param1);
      }
   }
}
