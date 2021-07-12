package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.exceptions.IndexOutOfBoundsException;
   
   public class ClanProfileSummaryBlockVO extends DAAPIDataClass
   {
      
      private static const STAT_BLOCKS:String = "statBlocks";
       
      
      public var header:String = "";
      
      public var isShowHeader:Boolean = false;
      
      public var statBlocks:Vector.<ClanProfileStatsLineVO> = null;
      
      public var emptyLbl:String = "";
      
      public var isActivated:Boolean = false;
      
      public function ClanProfileSummaryBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == STAT_BLOCKS)
         {
            this.statBlocks = new Vector.<ClanProfileStatsLineVO>(0);
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this.statBlocks.push(new ClanProfileStatsLineVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.cleanStatBlocks();
         super.onDispose();
      }
      
      public function getBlockAt(param1:int) : ClanProfileStatsLineVO
      {
         if(!this.statBlocks)
         {
            return null;
         }
         var _loc2_:int = this.statBlocks.length;
         if(param1 < 0 && param1 >= _loc2_)
         {
            throw new IndexOutOfBoundsException("Index: " + param1 + ", " + "Size: " + _loc2_);
         }
         return this.statBlocks[param1];
      }
      
      private function cleanStatBlocks() : void
      {
         var _loc1_:ClanProfileStatsLineVO = null;
         if(!this.statBlocks)
         {
            return;
         }
         for each(_loc1_ in this.statBlocks)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.statBlocks.splice(0,this.statBlocks.length);
         this.statBlocks = null;
      }
   }
}
