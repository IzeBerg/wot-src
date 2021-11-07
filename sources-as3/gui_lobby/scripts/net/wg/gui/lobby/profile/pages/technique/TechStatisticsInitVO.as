package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
   import scaleform.clik.data.DataProvider;
   
   public class TechStatisticsInitVO extends ProfileBattleTypeInitVO
   {
      
      private static const TABLE_HEADER:String = "tableHeader";
       
      
      public var tableHeader:DataProvider = null;
      
      public var selectedColumn:int = 4;
      
      public var selectedColumnSorting:String = "descending";
      
      public function TechStatisticsInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == TABLE_HEADER)
         {
            this.tableHeader = new DataProvider();
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.tableHeader.push(new NormalSortingBtnVO(_loc3_[_loc5_]));
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:NormalSortingBtnVO = null;
         if(this.tableHeader != null)
         {
            for each(_loc1_ in this.tableHeader)
            {
               _loc1_.dispose();
            }
            this.tableHeader.cleanUp();
            this.tableHeader = null;
         }
         super.onDispose();
      }
   }
}
