package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class OperationTitleInfo extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const INFO_ICON_GAP:int = 13;
      
      public static const HEADER_FONT_BIG:int = 36;
      
      public static const HEADER_FONT_SMALL:int = 28;
      
      public static const ICON_TOP_SHIFT_BIG:int = 8;
      
      public static const ICON_TOP_SHIFT_SMALL:int = 6;
      
      public static const INV_FONT_SIZE:String = "invalidateFontSize";
       
      
      public var titleTF:TextField;
      
      public var infoButton:IButtonIconLoader;
      
      private var _data:OperationTitleVO;
      
      private var _fontSize:int = 28;
      
      private var _iconTopShift:int = 6;
      
      public function OperationTitleInfo()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_INFO;
         this.infoButton.addEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.infoButton.removeEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
         this.infoButton.dispose();
         this.infoButton = null;
         this.titleTF = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            invalidateSize();
         }
         if(isInvalid(INV_FONT_SIZE))
         {
            _loc1_ = this.titleTF.getTextFormat();
            _loc1_.size = this._fontSize;
            this.titleTF.setTextFormat(_loc1_);
            this._iconTopShift = this._fontSize == HEADER_FONT_BIG ? int(ICON_TOP_SHIFT_BIG) : int(ICON_TOP_SHIFT_SMALL);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.infoButton.y = this.titleTF.y + (this.titleTF.textHeight - this.infoButton.height >> 1) + this._iconTopShift;
            this.infoButton.x = (this.titleTF.textWidth >> 1) + INFO_ICON_GAP;
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            if(this._data == null)
            {
               invalidate(INV_FONT_SIZE);
            }
            this._data = OperationTitleVO(param1);
            invalidateData();
         }
      }
      
      override public function get width() : Number
      {
         return this.titleTF.width;
      }
      
      public function set fontSize(param1:int) : void
      {
         if(this._fontSize == param1)
         {
            return;
         }
         this._fontSize = param1;
         invalidate(INV_FONT_SIZE);
      }
      
      private function onInfoButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new OperationEvent(OperationEvent.INFO_BTN_CLICK));
      }
   }
}
