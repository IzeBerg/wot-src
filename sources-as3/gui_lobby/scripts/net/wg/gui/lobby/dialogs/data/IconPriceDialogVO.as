package net.wg.gui.lobby.dialogs.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class IconPriceDialogVO extends DAAPIDataClass
   {
      
      private static const ITEM_PRICE_LBL:String = "itemPrices";
      
      private static const ACTION_PRICE_LBL:String = "actionPrice";
       
      
      public var itemPrices:Vector.<ItemPriceVO> = null;
      
      public var actionPrice:ActionPriceVO = null;
      
      public function IconPriceDialogVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == ITEM_PRICE_LBL)
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
         if(param1 == ACTION_PRICE_LBL)
         {
            this.actionPrice = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
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
         if(this.actionPrice != null)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         super.onDispose();
      }
   }
}
