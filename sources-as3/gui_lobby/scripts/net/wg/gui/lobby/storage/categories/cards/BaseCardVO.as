package net.wg.gui.lobby.storage.categories.cards
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import scaleform.clik.data.DataProvider;
   
   public class BaseCardVO extends DAAPIDataClass
   {
      
      private static const PRICE:String = "price";
      
      private static const SPECIALIZATIONS_ARRAY:String = "specializations";
      
      private static const EXTRA_PARAMS:String = "extraParams";
       
      
      public var id:Number;
      
      public var contextMenuId:String = "";
      
      public var title:String = "";
      
      public var image:String = "";
      
      public var imageAlt:String = "";
      
      public var description:String = "";
      
      public var additionalInfo:String = "";
      
      public var price:ItemPriceVO;
      
      public var count:int;
      
      public var nationFlagIcon:String = "";
      
      public var selected:Boolean;
      
      public var enabled:Boolean = true;
      
      public var available:Boolean = true;
      
      public var active:Boolean = false;
      
      public var isMoneyEnough:Boolean = true;
      
      public var isWideImage:Boolean = false;
      
      public var type:String = "";
      
      public var upgradable:Boolean = false;
      
      public var upgradeButtonTooltip:String = "";
      
      public var specializations:DataProvider = null;
      
      public var extraParams:DataProvider = null;
      
      public var customData:Object = null;
      
      public function BaseCardVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[CardVO > id: " + this.id + ", image: " + this.image + "]";
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == PRICE && param2 != null)
         {
            this.price = new ItemPriceVO(param2);
            return false;
         }
         if(param1 == SPECIALIZATIONS_ARRAY)
         {
            this.specializations = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.specializations.push(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         if(param1 == EXTRA_PARAMS)
         {
            this.extraParams = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.extraParams.push(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.price)
         {
            this.price.dispose();
            this.price = null;
         }
         super.onDispose();
      }
      
      public function isEqual(param1:BaseCardVO) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.id == param1.id && this.contextMenuId == param1.contextMenuId && this.title == param1.title && this.image == param1.image && this.description == param1.description && this.count == param1.count && this.nationFlagIcon == param1.nationFlagIcon && this.selected == param1.selected && this.enabled == param1.enabled && (this.price == param1.price || this.price && param1.price && this.price.isEquals(param1.price)) && this.isWideImage == param1.isWideImage && this.type == param1.type;
      }
   }
}
