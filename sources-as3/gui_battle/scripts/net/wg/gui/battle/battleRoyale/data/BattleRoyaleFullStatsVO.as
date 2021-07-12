package net.wg.gui.battle.battleRoyale.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyaleFullStatsVO extends DAAPIDataClass
   {
      
      private static const MINIMAP_ITEMS_LBL:String = "minimapItems";
      
      private static const ALIVE_BLOCK_LBL:String = "aliveBlock";
      
      private static const DESTROYED_BLOCK_LBL:String = "destroyedBlock";
      
      private static const HEADER_LBL:String = "header";
       
      
      public var aliveBlock:VehicleCounterVO = null;
      
      public var destroyedBlock:VehicleCounterVO = null;
      
      public var minimapItems:Array;
      
      public var header:BattleRoyaleEventHeaderVO = null;
      
      public function BattleRoyaleFullStatsVO(param1:Object = null)
      {
         this.minimapItems = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == MINIMAP_ITEMS_LBL)
         {
            this.fillItems(this.minimapItems,param2);
            return false;
         }
         if(param1 == ALIVE_BLOCK_LBL)
         {
            this.aliveBlock = new VehicleCounterVO(param2);
            return false;
         }
         if(param1 == DESTROYED_BLOCK_LBL)
         {
            this.destroyedBlock = new VehicleCounterVO(param2);
            return false;
         }
         if(param1 == HEADER_LBL)
         {
            this.header = new BattleRoyaleEventHeaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this.aliveBlock.dispose();
         this.aliveBlock = null;
         this.destroyedBlock.dispose();
         this.destroyedBlock = null;
         this.clearItems(this.minimapItems);
         this.minimapItems = null;
         super.onDispose();
      }
      
      private function clearItems(param1:Array) : void
      {
         var _loc2_:DescriptionBlockWithIconVO = null;
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
         }
         param1.splice(0,param1.length);
      }
      
      private function fillItems(param1:Array, param2:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               param1.push(new DescriptionBlockWithIconVO(_loc3_[_loc5_]));
               _loc5_++;
            }
         }
         else
         {
            App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
         }
      }
   }
}
