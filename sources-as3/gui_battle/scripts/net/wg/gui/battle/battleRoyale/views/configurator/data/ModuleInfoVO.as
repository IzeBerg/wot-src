package net.wg.gui.battle.battleRoyale.views.configurator.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorModuleVO;
   
   public class ModuleInfoVO extends DAAPIDataClass
   {
      
      private static const PARAMETERS_LABEL:String = "parameters";
      
      private static const MODULE_LABEL:String = "module";
       
      
      public var header:String = "";
      
      public var icon:String = "";
      
      public var hotKeys:Array = null;
      
      public var parameters:Vector.<ModuleParameterVO>;
      
      public var module:ConfiguratorModuleVO = null;
      
      public function ModuleInfoVO(param1:Object = null)
      {
         this.parameters = new Vector.<ModuleParameterVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == PARAMETERS_LABEL)
         {
            this.clearParameters();
            _loc3_ = param2 as Array;
            if(_loc3_)
            {
               for each(_loc4_ in _loc3_)
               {
                  this.parameters.push(new ModuleParameterVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         if(param1 == MODULE_LABEL)
         {
            if(this.module)
            {
               this.module.dispose();
            }
            this.module = new ConfiguratorModuleVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearParameters();
         this.parameters = null;
         if(this.hotKeys)
         {
            this.hotKeys.splice(0,this.hotKeys.length);
            this.hotKeys = null;
         }
         this.module.dispose();
         this.module = null;
         super.onDispose();
      }
      
      private function clearParameters() : void
      {
         var _loc1_:ModuleParameterVO = null;
         for each(_loc1_ in this.parameters)
         {
            _loc1_.dispose();
         }
         this.parameters.splice(0,this.parameters.length);
      }
   }
}
