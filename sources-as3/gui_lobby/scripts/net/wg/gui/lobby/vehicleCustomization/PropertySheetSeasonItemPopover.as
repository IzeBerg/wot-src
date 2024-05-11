package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.SmallSlotVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PropertySheetSeasonItemPopover extends UIComponentEx
   {
      
      private static const ICON_WIDTH:int = 48;
      
      private static const ICON_HEIGHT:int = 48;
      
      private static const WIDE_ICON_WIDTH:int = 131;
      
      private static const BORDER_OFFSET:int = 1;
       
      
      public var itemIcon:Image = null;
      
      public var itemBorder:MovieClip = null;
      
      public var itemBackground:MovieClip = null;
      
      private var _model:SmallSlotVO = null;
      
      public function PropertySheetSeasonItemPopover()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.itemIcon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         mouseEnabled = false;
         mouseChildren = false;
         this.itemIcon.addEventListener(Event.CHANGE,this.onItemIconChangeHandler);
         this.itemIcon.addEventListener(IOErrorEvent.IO_ERROR,this.onItemIconIoErrorHandler);
      }
      
      override protected function onDispose() : void
      {
         this.itemIcon.removeEventListener(Event.CHANGE,this.onItemIconChangeHandler);
         this.itemIcon.removeEventListener(IOErrorEvent.IO_ERROR,this.onItemIconIoErrorHandler);
         this.itemIcon.dispose();
         this.itemIcon = null;
         this.itemBorder = null;
         this.itemBackground = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this._model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.itemIcon.source = this._model.itemIcon;
               this.itemBackground.visible = this._model.isBgVisible;
               this.itemBorder.visible = this._model.isFrameVisible;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.itemIcon.height = this._model.iconHeight != Values.DEFAULT_INT ? Number(this._model.iconHeight) : Number(ICON_HEIGHT);
               if(this._model.iconWidth != Values.DEFAULT_INT)
               {
                  this.itemIcon.width = this._model.iconWidth;
               }
               else
               {
                  this.itemIcon.width = !!this._model.itemIsWide ? Number(WIDE_ICON_WIDTH) : Number(ICON_WIDTH);
               }
               _loc1_ = Math.min(this.itemIcon.scaleX,this.itemIcon.scaleY);
               this.itemIcon.scaleX = this.itemIcon.scaleY = _loc1_;
               this.itemBackground.width = this.itemIcon.width;
               this.itemBackground.height = this.itemIcon.height;
               this.itemBorder.width = this.itemBackground.width + (BORDER_OFFSET << 1);
               this.itemBorder.height = this.itemBackground.height + (BORDER_OFFSET << 1);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      public function setData(param1:SmallSlotVO) : void
      {
         if(param1 != this._model)
         {
            this._model = param1;
            invalidateData();
            invalidateSize();
         }
      }
      
      override public function get width() : Number
      {
         return this.itemBorder.width;
      }
      
      private function onItemIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onItemIconIoErrorHandler(param1:Event) : void
      {
         visible = false;
         DebugUtils.LOG_ERROR(param1.toString());
      }
   }
}
