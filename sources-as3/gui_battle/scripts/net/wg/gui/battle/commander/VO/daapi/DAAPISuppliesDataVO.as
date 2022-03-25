package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPISuppliesDataVO extends DAAPIDataClass
   {
      
      protected static const LEFT_INFO_FIELD_NAME:String = "leftSupplyInfos";
      
      protected static const RIGHT_INFO_FIELD_NAME:String = "rightSupplyInfos";
      
      protected static const LEFT_IDS_FIELD_NAME:String = "leftSupplyIDs";
      
      protected static const RIGHT_IDS_FIELD_NAME:String = "rightSupplyIDs";
       
      
      public var leftSupplyInfos:Vector.<DAAPISupplyInfoVO> = null;
      
      public var rightSupplyInfos:Vector.<DAAPISupplyInfoVO> = null;
      
      public var leftSupplyIDs:Vector.<Number> = null;
      
      public var rightSupplyIDs:Vector.<Number> = null;
      
      public function DAAPISuppliesDataVO(param1:Object)
      {
         super(param1);
      }
      
      private static function clearInfoList(param1:Vector.<DAAPISupplyInfoVO>) : void
      {
         var _loc2_:DAAPISupplyInfoVO = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
         }
         clearList(Vector.<Object>(param1));
      }
      
      private static function clearList(param1:Vector.<Object>) : void
      {
         if(param1)
         {
            param1.fixed = false;
            param1.length = 0;
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case LEFT_INFO_FIELD_NAME:
            case RIGHT_INFO_FIELD_NAME:
               if(param2)
               {
                  this[param1] = Vector.<DAAPISupplyInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPISupplyInfoVO));
               }
               return false;
            case LEFT_IDS_FIELD_NAME:
            case RIGHT_IDS_FIELD_NAME:
               if(param2)
               {
                  this[param1] = App.utils.data.convertNumberArrayToVector(param1,param2);
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         clearInfoList(this.leftSupplyInfos);
         clearInfoList(this.rightSupplyInfos);
         clearList(Vector.<Object>(this.leftSupplyIDs));
         clearList(Vector.<Object>(this.rightSupplyIDs));
         this.leftSupplyInfos = null;
         this.rightSupplyInfos = null;
         this.leftSupplyIDs = null;
         this.rightSupplyIDs = null;
         super.onDispose();
      }
   }
}
