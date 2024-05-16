package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   
   public class ToolTipSelectedVehicle extends ToolTipSpecial
   {
       
      
      public var headerTF:TextField = null;
      
      public var whiteBg:Sprite = null;
      
      private var _vehicleBlockItems:Vector.<UIComponentEx> = null;
      
      private const MIN_CONTENT_WIDTH:Number = 275;
      
      private const MARGIN_BEETWEEN_BLOCKS:Number = 3;
      
      public function ToolTipSelectedVehicle()
      {
         super();
         this.headerTF = content.headerTF;
         this.whiteBg = content.whiteBg;
         this._vehicleBlockItems = new Vector.<UIComponentEx>();
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipSelectedVehicle " + name + "]";
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Separator = null;
         if(content.width < this.MIN_CONTENT_WIDTH)
         {
            contentWidth = this.MIN_CONTENT_WIDTH;
         }
         super.updateSize();
         if(this.whiteBg.visible)
         {
            _loc1_ = separators[separators.length - 1];
            this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
            this.whiteBg.height = content.height + contentMargin.bottom - _loc1_.y;
         }
      }
      
      override protected function redraw() : void
      {
         var _loc2_:VehicleVO = null;
         var _loc3_:Separator = null;
         var _loc1_:ILocale = App.utils.locale;
         _loc2_ = new VehicleVO(_data);
         separators = new Vector.<Separator>();
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = _loc1_.makeString(TOOLTIPS.SELECTEDVEHICLE_HEADER);
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         _loc3_ = Utils.instance.createSeparate(content);
         _loc3_.y = topPosition ^ 0;
         separators.push(_loc3_);
         this.whiteBg.y = _loc3_.y;
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         topPosition = this.addSuitableVehicleBlockItem(_loc2_,topPosition);
         contentMargin.bottom = Utils.instance.MARGIN_AFTER_BLOCK;
         _loc2_.dispose();
         _loc2_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:UIComponentEx = null;
         for each(_loc1_ in this._vehicleBlockItems)
         {
            content.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._vehicleBlockItems.splice(0,this._vehicleBlockItems.length);
         this._vehicleBlockItems = null;
         this.headerTF = null;
         this.whiteBg = null;
         super.onDispose();
      }
      
      private function addSuitableVehicleBlockItem(param1:VehicleVO, param2:Number) : Number
      {
         var _loc3_:SuitableVehicleBlockItem = App.utils.classFactory.getComponent("SuitableVehicleBlockItemUI",SuitableVehicleBlockItem);
         this._vehicleBlockItems.push(_loc3_);
         _loc3_.setData(App.utils.nations.getNationIcon(param1.nationID),param1.level,param1.smallIconPath,"../maps/icons/filters/tanks/" + param1.type + ".png",param1.shortUserName);
         _loc3_.x = contentMargin.left + bgShadowMargin.left;
         _loc3_.y = param2 ^ 0;
         content.addChild(_loc3_);
         return Number(param2 + (_loc3_.height + this.MARGIN_BEETWEEN_BLOCKS));
      }
   }
}
