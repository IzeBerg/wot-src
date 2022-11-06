package net.wg.gui.lobby.hangar.quests
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.hangar.data.SecondaryEntryPointVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SecondaryEntryPointContent extends UIComponentEx
   {
      
      private static const GOLD_COLOR:int = 15450485;
      
      private static const WHITE_COLOR:int = 16777215;
      
      private static const CREAM_COLOR:int = 16768409;
      
      private static const DISABLED_COLOR:int = 12105912;
      
      private static const FONT_SIZE_SMALL:int = 14;
      
      private static const FONT_SIZE_BIG:int = 18;
      
      private static const PADDING_TOP:int = 6;
      
      private static const PADDING_LEFT:int = -7;
      
      private static const TEXT_Y_BIG:int = 9;
      
      private static const TEXT_Y_SMALL:int = 46;
      
      private static const SHIELD_WIDTH:int = 60;
      
      private static const SHIELD_HEIGHT:int = 62;
      
      private static const FLAG_OFFSET_Y:int = 23;
      
      private static const ALT_ICON_OFFSET_Y:int = -17;
      
      private static const ALT_ICON_COMPLETED_OFFSET_Y:int = -11;
      
      private static const ORANGE_SHADOW:Array = [new DropShadowFilter(1,45,6233088)];
       
      
      public var bounds:MovieClip = null;
      
      public var tf:TextField = null;
      
      public var icon:Image = null;
      
      public var extraIcon:Image = null;
      
      public var flagIcon:Image = null;
      
      public var altIcon:Image = null;
      
      private var _data:SecondaryEntryPointVO = null;
      
      private var _hasActiveChapter:Boolean = false;
      
      private var _hasPoints:Boolean = false;
      
      public function SecondaryEntryPointContent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bounds = null;
         this.tf = null;
         this.icon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.altIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.altIcon.dispose();
         this.altIcon = null;
         this.flagIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.flagIcon.dispose();
         this.flagIcon = null;
         this.extraIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.extraIcon.dispose();
         this.extraIcon = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.altIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.flagIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.extraIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.altIcon.smoothing = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Array = null;
         super.draw();
         if(this._data == null)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.flagIcon.source = this._data.flagIcon;
            this.altIcon.source = this._data.altIcon;
            this.extraIcon.source = this._data.extraIcon;
            this._hasActiveChapter = this._data.chapterID > 0;
            this._hasPoints = !this._hasActiveChapter && this._data.points > 0;
            if(this._hasActiveChapter || this._hasPoints)
            {
               this.tf.visible = true;
               _loc1_ = new TextFormat();
               _loc2_ = null;
               if(this._hasPoints)
               {
                  this.tf.text = String(this._data.points);
                  _loc1_.size = FONT_SIZE_SMALL;
                  _loc1_.color = CREAM_COLOR;
                  _loc2_ = ORANGE_SHADOW;
               }
               else
               {
                  this.tf.text = this._data.text;
                  _loc1_ = new TextFormat();
                  _loc1_.size = FONT_SIZE_BIG;
                  _loc1_.color = !this._data.isEnabled ? DISABLED_COLOR : (!!this._data.isBought ? GOLD_COLOR : WHITE_COLOR);
               }
               this.tf.setTextFormat(_loc1_);
               this.tf.filters = _loc2_;
            }
            else
            {
               this.tf.visible = false;
            }
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.tf.y = PADDING_TOP + (!!this._hasPoints ? TEXT_Y_SMALL : TEXT_Y_BIG);
            if(this.icon.ready)
            {
               this.icon.x = PADDING_LEFT;
               this.icon.y = PADDING_TOP;
            }
            if(this.flagIcon.ready)
            {
               this.flagIcon.x = PADDING_LEFT + (SHIELD_WIDTH - this.flagIcon.width >> 1);
               this.flagIcon.y = PADDING_TOP + FLAG_OFFSET_Y;
            }
            if(this.altIcon.ready)
            {
               this.altIcon.x = PADDING_LEFT + (SHIELD_WIDTH - this.altIcon.width >> 1);
               if(this._hasActiveChapter)
               {
                  this.altIcon.y = PADDING_TOP + SHIELD_HEIGHT + ALT_ICON_OFFSET_Y;
               }
               else
               {
                  this.altIcon.y = PADDING_TOP + (SHIELD_HEIGHT - this.altIcon.height >> 1) + ALT_ICON_COMPLETED_OFFSET_Y;
               }
            }
            if(this.extraIcon.ready)
            {
               this.extraIcon.x = PADDING_LEFT;
               this.extraIcon.y = PADDING_TOP;
            }
         }
      }
      
      public function setData(param1:SecondaryEntryPointVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
