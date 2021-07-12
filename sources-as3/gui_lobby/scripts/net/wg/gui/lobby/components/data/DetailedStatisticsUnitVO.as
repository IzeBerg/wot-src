package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DetailedStatisticsUnitVO extends StatisticsLabelDataVO
   {
       
      
      private var _itemsList:DataProvider = null;
      
      public function DetailedStatisticsUnitVO(param1:Object)
      {
         this._itemsList = new DataProvider();
         super(param1);
      }
      
      override protected function parseData(param1:Object) : void
      {
         var _loc5_:Object = null;
         var _loc2_:Array = param1 as Array;
         App.utils.asserter.assertNotNull(_loc2_,Errors.INVALID_TYPE + Array);
         var _loc3_:uint = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            if(!_loc5_)
            {
               this._itemsList.push(null);
            }
            else if(_loc5_.hasOwnProperty(TruncateDetailedStatisticsLabelDataVO.TRUNCATE_VO))
            {
               this._itemsList.push(new TruncateDetailedStatisticsLabelDataVO(_loc5_));
            }
            else
            {
               this._itemsList.push(new DetailedStatisticsLabelDataVO(_loc5_));
            }
            _loc4_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._itemsList)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this._itemsList.cleanUp();
         this._itemsList = null;
         super.onDispose();
      }
      
      public function get itemsList() : IDataProvider
      {
         return this._itemsList;
      }
   }
}
