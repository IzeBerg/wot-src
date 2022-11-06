package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattlesIntroVO extends DAAPIDataClass
   {
      
      private static const HEADER_DATA_FIELD:String = "headerData";
      
      private static const BLOCKS_DATA_FIELD:String = "blocksData";
       
      
      public var state:int = 0;
      
      public var hasURL:Boolean = true;
      
      public var headerData:RankedBattlesPageHeaderVO = null;
      
      public var blocksData:Vector.<RankedBattlesIntroBlockVO> = null;
      
      public function RankedBattlesIntroVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == HEADER_DATA_FIELD)
         {
            this.headerData = new RankedBattlesPageHeaderVO(param2);
            return false;
         }
         if(param1 == BLOCKS_DATA_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,BLOCKS_DATA_FIELD + Errors.CANT_NULL);
            this.blocksData = new Vector.<RankedBattlesIntroBlockVO>(0);
            for each(_loc4_ in param2)
            {
               this.blocksData.push(new RankedBattlesIntroBlockVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.headerData)
         {
            this.headerData.dispose();
            this.headerData = null;
         }
         if(this.blocksData)
         {
            for each(_loc1_ in this.blocksData)
            {
               _loc1_.dispose();
            }
            this.blocksData.length = 0;
            this.blocksData = null;
         }
         super.onDispose();
      }
   }
}
