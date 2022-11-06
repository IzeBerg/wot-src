package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.IStatisticsBodyContainerData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StatisticsBodyVO extends DAAPIDataClass implements IStatisticsBodyContainerData
   {
      
      private static const LINKAGE:String = "linkage";
      
      private static const DATA_LIST:String = "dataList";
       
      
      private var _dataListVO:Vector.<StatisticsLabelLinkageDataVO> = null;
      
      public function StatisticsBodyVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:StatisticsLabelLinkageDataVO = null;
         if(param1 == DATA_LIST)
         {
            this._dataListVO = new Vector.<StatisticsLabelLinkageDataVO>();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + DATA_LIST);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_[_loc5_];
               App.utils.asserter.assert(_loc6_.hasOwnProperty(LINKAGE),"Item " + _loc5_ + " hasn\'t linkage property!");
               _loc7_ = _loc6_[LINKAGE];
               _loc8_ = this.createItemData(_loc7_,_loc6_);
               App.utils.asserter.assertNotNull(_loc8_,_loc7_ + " not supported here!");
               this._dataListVO.push(_loc8_);
               _loc5_++;
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._dataListVO)
         {
            _loc1_.dispose();
         }
         this._dataListVO.splice(0,this._dataListVO.length);
         this._dataListVO = null;
         super.onDispose();
      }
      
      protected function createItemData(param1:String, param2:Object) : StatisticsLabelLinkageDataVO
      {
         if(param1 == Linkages.DETAILED_STATISTICS_VIEW)
         {
            return new DetailedLabelDataVO(param2);
         }
         return null;
      }
      
      public function get dataListVO() : Vector.<StatisticsLabelLinkageDataVO>
      {
         return this._dataListVO;
      }
   }
}
