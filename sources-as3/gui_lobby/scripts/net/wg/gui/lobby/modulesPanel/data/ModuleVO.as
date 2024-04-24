package net.wg.gui.lobby.modulesPanel.data
{
   public class ModuleVO extends DeviceVO
   {
      
      private static const PARAMS_ITEMS:String = "paramsItems";
       
      
      public var showExtendedParams:Boolean = true;
      
      public var level:int = -1;
      
      public var paramValues:String = "";
      
      public var paramNames:String = "";
      
      public var extraModuleInfo:String = "";
      
      public var count:String = "";
      
      public var highlightedParameterIdx:int = -1;
      
      public var paramsItems:Vector.<ParamsItemVO> = null;
      
      public function ModuleVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == PARAMS_ITEMS)
         {
            _loc3_ = param2 as Array;
            this.paramsItems = new Vector.<ParamsItemVO>(0);
            for each(_loc4_ in _loc3_)
            {
               this.paramsItems.push(new ParamsItemVO(_loc4_));
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ParamsItemVO = null;
         if(this.paramsItems != null)
         {
            for each(_loc1_ in this.paramsItems)
            {
               _loc1_.dispose();
            }
            this.paramsItems = null;
         }
         super.onDispose();
      }
   }
}
