package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
   import scaleform.clik.data.DataProvider;
   
   public class TechStatisticsInitVO extends ProfileBattleTypeInitVO
   {
      
      private static const TABLE_HEADER:String = "tableHeader";
      
      private static const PRESTIGE_KEY:String = "prestigeLevel";
       
      
      public var tableHeader:DataProvider = null;
      
      public var selectedColumn:int = 4;
      
      public var selectedColumnSorting:String = "descending";
      
      public var dropdownSeasonLabel:String = "";
      
      public var showSeasonDropdown:Boolean = false;
      
      public var seasonItems:Array = null;
      
      public var seasonIndex:int = -1;
      
      public var seasonEnabled:Boolean = false;
      
      private var _isPrestigeEnabled:Boolean = false;
      
      public function TechStatisticsInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:NormalSortingBtnVO = null;
         var _loc6_:int = 0;
         if(param1 == TABLE_HEADER)
         {
            this._isPrestigeEnabled = false;
            this.tableHeader = new DataProvider();
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = new NormalSortingBtnVO(_loc3_[_loc6_]);
               if(_loc5_.id == PRESTIGE_KEY)
               {
                  this._isPrestigeEnabled = true;
               }
               this.tableHeader.push(_loc5_);
               _loc6_++;
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
         if(this.seasonItems != null)
         {
            this.seasonItems.length = 0;
            this.seasonItems = null;
         }
         super.onDispose();
      }
      
      public function get isPrestigeEnabled() : Boolean
      {
         return this._isPrestigeEnabled;
      }
   }
}
