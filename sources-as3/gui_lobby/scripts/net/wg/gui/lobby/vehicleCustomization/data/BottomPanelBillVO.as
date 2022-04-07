package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   
   public class BottomPanelBillVO extends DAAPIDataClass
   {
      
      private static const PRICE_PANEL:String = "pricePanel";
      
      private static const IS_ENOUGH_STATUSES:String = "isEnoughStatuses";
       
      
      public var title:String = "";
      
      public var priceLbl:String = "";
      
      public var fromStorageLbl:String = "";
      
      private var _pricePanel:ItemPriceVO = null;
      
      private var _isEnoughStatuses:Vector.<PriceVO>;
      
      public function BottomPanelBillVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(param1 == PRICE_PANEL)
         {
            this._pricePanel = new ItemPriceVO(param2);
            return false;
         }
         if(IS_ENOUGH_STATUSES == param1)
         {
            if(this._isEnoughStatuses && this._isEnoughStatuses.length > 0)
            {
               this._isEnoughStatuses.splice(0,this._isEnoughStatuses.length);
            }
            else
            {
               this._isEnoughStatuses = new Vector.<PriceVO>();
            }
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._isEnoughStatuses.push(new PriceVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._pricePanel)
         {
            this._pricePanel.dispose();
            this._pricePanel = null;
         }
         if(this._isEnoughStatuses)
         {
            this._isEnoughStatuses.length = 0;
            this._isEnoughStatuses = null;
         }
         super.onDispose();
      }
      
      public function get isEnoughStatuses() : Vector.<PriceVO>
      {
         return this._isEnoughStatuses;
      }
      
      public function get pricePanel() : ItemPriceVO
      {
         return this._pricePanel;
      }
   }
}
