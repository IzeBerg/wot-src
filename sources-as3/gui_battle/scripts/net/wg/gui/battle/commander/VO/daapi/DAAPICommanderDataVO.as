package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPICommanderDataVO extends DAAPIDataClass
   {
      
      private static const LEFT_ITEMS_FIELD_NAME:String = "leftItems";
      
      private static const RIGHT_ITEMS_FIELD_NAME:String = "rightItems";
       
      
      public var leftItems:Vector.<DAAPIVehicleCommanderDataVO> = null;
      
      public var rightItems:Vector.<DAAPIVehicleCommanderDataVO> = null;
      
      public function DAAPICommanderDataVO(param1:Object)
      {
         super(param1);
      }
      
      private static function clearItems(param1:Vector.<DAAPIVehicleCommanderDataVO>) : void
      {
         var _loc2_:DAAPIVehicleCommanderDataVO = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
         }
         param1.fixed = false;
         param1.length = 0;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case LEFT_ITEMS_FIELD_NAME:
            case RIGHT_ITEMS_FIELD_NAME:
               if(param2)
               {
                  this[param1] = Vector.<DAAPIVehicleCommanderDataVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIVehicleCommanderDataVO));
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         clearItems(this.leftItems);
         clearItems(this.rightItems);
         this.leftItems = null;
         this.rightItems = null;
         super.onDispose();
      }
   }
}
