package net.wg.gui.lobby.modulesPanel.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class DeviceVO extends DAAPIDataClass
   {
      
      private static const FIELD_ITEM_PRICES:String = "itemPrices";
       
      
      public var showPrice:Boolean = true;
      
      public var id:Number = NaN;
      
      public var type:String = "";
      
      public var slotIndex:int = -1;
      
      public var name:String = "";
      
      public var target:String = "";
      
      public var targetVisible:Boolean = false;
      
      public var status:String = "";
      
      public var isSelected:Boolean = false;
      
      public var disabled:Boolean = false;
      
      public var moduleLabel:String = "";
      
      public var tooltipType:String = "";
      
      public var removeButtonLabel:String = "";
      
      public var removeButtonTooltip:String = "";
      
      public var overlayType:String = "";
      
      public var highlightType:String = "";
      
      public var bgHighlightType:String = "";
      
      public var itemPrices:Vector.<ItemPriceVO> = null;
      
      public function DeviceVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ItemPriceVO = null;
         if(this.itemPrices != null)
         {
            for each(_loc1_ in this.itemPrices)
            {
               _loc1_.dispose();
            }
            this.itemPrices = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2 != null && param1 == FIELD_ITEM_PRICES)
         {
            this.itemPrices = new Vector.<ItemPriceVO>(0);
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.itemPrices.push(new ItemPriceVO(_loc3_[_loc5_]));
                  _loc5_++;
               }
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
