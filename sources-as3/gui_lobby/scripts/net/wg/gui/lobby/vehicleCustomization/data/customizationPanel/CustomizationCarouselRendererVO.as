package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class CustomizationCarouselRendererVO extends DAAPIDataClass
   {
      
      private static const EDITABLE_ICON_NAME_PREFIX_SMALL:String = "small";
      
      private static const EDITABLE_ICON_NAME_PREFIX_BIG:String = "big";
      
      private static const BUY_PRICE:String = "buyPrice";
       
      
      public var intCD:int = -1;
      
      public var index:int = -1;
      
      public var typeId:int = -1;
      
      public var isWide:Boolean = false;
      
      public var isPlaceHolder:Boolean = false;
      
      public var icon:String = "";
      
      public var styleName:String = "";
      
      public var styleNameSmall:String = "";
      
      public var locked:Boolean = false;
      
      public var showDetailItems:Boolean = false;
      
      public var quantity:String = "";
      
      public var rentalInfoText:String = "";
      
      public var isRental:Boolean = false;
      
      public var autoRentEnabled:Boolean = false;
      
      public var buyPrice:ItemPriceVO = null;
      
      public var formIconSource:String = "";
      
      public var buyOperationAllowed:Boolean = true;
      
      public var customizationDisplayType:int = 0;
      
      public var showAlert:Boolean = false;
      
      public var showRareIcon:Boolean = false;
      
      public var isEquipped:Boolean = false;
      
      public var isSpecial:Boolean = false;
      
      public var isDarked:Boolean = false;
      
      public var isAlreadyUsed:Boolean = false;
      
      public var lockText:String = "";
      
      public var imageCached:Boolean = true;
      
      public var isAllSeasons:Boolean = true;
      
      public var noveltyCounter:int = -1;
      
      public var editNoveltyCounter:int = -1;
      
      public var defaultIconAlpha:Number = 1.0;
      
      public var isDim:Boolean = false;
      
      public var formFactor:int = -1;
      
      public var progressionLevel:int = -1;
      
      public var editableIcon:String = "";
      
      public var editBtnEnabled:Boolean = false;
      
      public var showEditableHint:Boolean = false;
      
      public var showEditBtnHint:Boolean = false;
      
      public var scale:Number = 1.0;
      
      public var tooltip:String = "";
      
      public var isChained:Boolean = false;
      
      public var isUnsuitable:Boolean = false;
      
      public var isProgressionRewindEnabled:Boolean = false;
      
      public var isWithSerialNumber:Boolean = false;
      
      public var isInProgress:Boolean = false;
      
      public var isLinked:Boolean = false;
      
      public var isNew:Boolean = false;
      
      public function CustomizationCarouselRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BUY_PRICE)
         {
            this.buyPrice = new ItemPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.buyPrice != null)
         {
            this.buyPrice.dispose();
            this.buyPrice = null;
         }
         super.onDispose();
      }
      
      public function get isEditableStyle() : Boolean
      {
         return StringUtils.isNotEmpty(this.editableIcon);
      }
      
      public function get editableIconBig() : String
      {
         return this.editableIcon.replace(EDITABLE_ICON_NAME_PREFIX_SMALL,EDITABLE_ICON_NAME_PREFIX_BIG);
      }
   }
}
