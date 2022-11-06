package net.wg.gui.battle.epicBattle.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPITotalStatsVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicVehiclesStatsVO extends DAAPIDataClass
   {
      
      private static const LEFT_ITEMS_IDS_FIELD_NAME:String = "leftItemsIDs";
      
      private static const RIGHT_ITEMS_IDS_FIELD_NAME:String = "rightItemsIDs";
      
      private static const COND_LEFT_FIELD_NAME:String = "leftItems";
      
      private static const COND_RIGHT_FIELD_NAME:String = "rightItems";
      
      private static const TOTAL_STATS_FIELD_NAME:String = "totalStats";
       
      
      public var leftItems:Vector.<EpicVehicleStatsVO> = null;
      
      public var rightItems:Vector.<EpicVehicleStatsVO> = null;
      
      public var leftVehiclesIDs:Vector.<Number> = null;
      
      public var rightVehiclesIDs:Vector.<Number> = null;
      
      public var totalStats:DAAPITotalStatsVO = null;
      
      public function EpicVehiclesStatsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         switch(param1)
         {
            case LEFT_ITEMS_IDS_FIELD_NAME:
               if(param2)
               {
                  _loc3_ = param2 as Array;
                  App.utils.asserter.assertNotNull(_loc3_,LEFT_ITEMS_IDS_FIELD_NAME + Errors.CANT_NULL);
                  _loc4_ = _loc3_.length;
                  this.leftVehiclesIDs = new Vector.<Number>();
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.leftVehiclesIDs.push(_loc3_[_loc5_]);
                     _loc5_++;
                  }
               }
               return false;
            case RIGHT_ITEMS_IDS_FIELD_NAME:
               if(param2)
               {
                  _loc3_ = param2 as Array;
                  App.utils.asserter.assertNotNull(_loc3_,RIGHT_ITEMS_IDS_FIELD_NAME + Errors.CANT_NULL);
                  _loc4_ = _loc3_.length;
                  this.rightVehiclesIDs = new Vector.<Number>();
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.rightVehiclesIDs.push(_loc3_[_loc5_]);
                     _loc5_++;
                  }
               }
               return false;
            case COND_LEFT_FIELD_NAME:
               if(param2)
               {
                  _loc3_ = param2 as Array;
                  App.utils.asserter.assertNotNull(_loc3_,COND_LEFT_FIELD_NAME + Errors.CANT_NULL);
                  _loc4_ = _loc3_.length;
                  this.leftItems = new Vector.<EpicVehicleStatsVO>();
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.leftItems.push(new EpicVehicleStatsVO(_loc3_[_loc5_]));
                     _loc5_++;
                  }
               }
               return false;
            case COND_RIGHT_FIELD_NAME:
               if(param2)
               {
                  _loc3_ = param2 as Array;
                  App.utils.asserter.assertNotNull(_loc3_,COND_RIGHT_FIELD_NAME + Errors.CANT_NULL);
                  _loc4_ = _loc3_.length;
                  this.rightItems = new Vector.<EpicVehicleStatsVO>();
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.rightItems.push(new EpicVehicleStatsVO(_loc3_[_loc5_]));
                     _loc5_++;
                  }
               }
               return false;
            case TOTAL_STATS_FIELD_NAME:
               this.totalStats = new DAAPITotalStatsVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EpicVehicleStatsVO = null;
         if(this.leftItems)
         {
            for each(_loc1_ in this.leftItems)
            {
               _loc1_.dispose();
            }
            this.leftItems.fixed = false;
            this.leftItems.splice(0,this.leftItems.length);
            this.leftItems = null;
         }
         if(this.rightItems)
         {
            for each(_loc1_ in this.rightItems)
            {
               _loc1_.dispose();
            }
            this.rightItems.fixed = false;
            this.rightItems.splice(0,this.rightItems.length);
            this.rightItems = null;
         }
         if(this.totalStats)
         {
            this.totalStats.dispose();
            this.totalStats = null;
         }
         if(this.leftVehiclesIDs)
         {
            this.leftVehiclesIDs = null;
         }
         if(this.rightVehiclesIDs)
         {
            this.rightVehiclesIDs = null;
         }
         super.onDispose();
      }
   }
}
