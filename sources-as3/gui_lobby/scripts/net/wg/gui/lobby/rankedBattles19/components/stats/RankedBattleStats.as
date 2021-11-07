package net.wg.gui.lobby.rankedBattles19.components.stats
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ITextManager;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattleStats extends UIComponentEx
   {
      
      private static const VALUE_Y_OFFSET_BIG:int = -28;
      
      private static const VALUE_Y_OFFSET_SMALL:int = -24;
      
      private static const LABEL_Y_OFFSET:int = 2;
      
      private static const STATE_BIG:String = "state_big";
      
      private static const STATE_SMALL:String = "state_small";
       
      
      public var icon:Image = null;
      
      public var valueTf:TextField = null;
      
      public var labelTf:TextField = null;
      
      public var hit:Sprite = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _data:RankedBattlesStatsVO = null;
      
      private var _labelYOffset:int = 2;
      
      private var _valueYOffsetBig:int = -28;
      
      private var _valueYOffsetSmall:int = -24;
      
      private var _state:String = "state_big";
      
      private var _textMgr:ITextManager = null;
      
      private var _valueStyleBig:String = "superPromoTitle";
      
      private var _valueStyleSmall:String = "promoTitle";
      
      private var _iconSizeBig:int = 70;
      
      private var _iconSizeSmall:int = 52;
      
      public function RankedBattleStats()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this._textMgr = App.textMgr;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.mouseChildren = this.icon.mouseEnabled = false;
         this.valueTf.mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         hitArea = null;
         this.valueTf = null;
         this.labelTf = null;
         this.hit = null;
         this._data = null;
         this._textMgr = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this.labelTf)
               {
                  this.labelTf.htmlText = this._data.label;
                  App.utils.commons.updateTextFieldSize(this.labelTf);
               }
               invalidateState();
            }
            if(isInvalid(InvalidationType.STATE))
            {
               _loc1_ = this._state == STATE_SMALL;
               _loc2_ = !!_loc1_ ? String(this._iconSizeSmall) : String(this._iconSizeBig);
               this.icon.source = RES_ICONS.maps_icons_rankedbattles_stats_all_all_png(_loc2_,this._data.icon);
               this.valueTf.htmlText = this._textMgr.getTextStyleById(!!_loc1_ ? this._valueStyleSmall : this._valueStyleBig,this._data.value);
               App.utils.commons.updateTextFieldSize(this.valueTf);
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               _loc3_ = 0;
               if(this.icon.ready)
               {
                  this.icon.x = -(this.icon.width >> 1);
                  _loc3_ = this.icon.height | 0;
               }
               this.valueTf.x = -(this.valueTf.width >> 1);
               this.valueTf.y = _loc3_ + (this._state == STATE_SMALL ? this._valueYOffsetSmall : this._valueYOffsetBig);
               if(this.labelTf)
               {
                  this.labelTf.x = -(this.labelTf.width >> 1);
                  this.labelTf.y = this.valueTf.y + this.valueTf.height + this._labelYOffset | 0;
               }
               this.hit.width = this.icon.width;
               this.hit.height = this.valueTf.y + this.valueTf.height;
               this.hit.x = this.icon.x;
            }
         }
      }
      
      public function maximize() : void
      {
         if(this._state != STATE_BIG)
         {
            this._state = STATE_BIG;
            invalidateState();
         }
      }
      
      public function minimize() : void
      {
         if(this._state != STATE_SMALL)
         {
            this._state = STATE_SMALL;
            invalidateState();
         }
      }
      
      public function setData(param1:RankedBattlesStatsVO) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      protected function showTooltip() : void
      {
         if(this._data && this._data.tooltip)
         {
            this._tooltipMgr.showComplex(this._data.tooltip);
         }
      }
      
      public function set iconBlendMode(param1:String) : void
      {
         this.icon.blendMode = param1;
      }
      
      public function set valueStyleBig(param1:String) : void
      {
         if(this._valueStyleBig != param1)
         {
            this._valueStyleBig = param1;
            invalidateState();
         }
      }
      
      public function set valueStyleSmall(param1:String) : void
      {
         if(this._valueStyleSmall != param1)
         {
            this._valueStyleSmall = param1;
            invalidateState();
         }
      }
      
      public function set iconSizeBig(param1:int) : void
      {
         if(this._iconSizeBig != param1)
         {
            this._iconSizeBig = param1;
            invalidateState();
         }
      }
      
      public function set iconSizeSmall(param1:int) : void
      {
         if(this._iconSizeSmall != param1)
         {
            this._iconSizeSmall = param1;
            invalidateState();
         }
      }
      
      public function set valueYOffsetBig(param1:int) : void
      {
         if(this._valueYOffsetBig != param1)
         {
            this._valueYOffsetBig = param1;
            invalidateLayout();
         }
      }
      
      public function set valueYOffsetSmall(param1:int) : void
      {
         if(this._valueYOffsetSmall != param1)
         {
            this._valueYOffsetSmall = param1;
            invalidateLayout();
         }
      }
      
      public function get labelYOffset() : int
      {
         return this._labelYOffset;
      }
      
      public function set labelYOffset(param1:int) : void
      {
         if(this._labelYOffset != param1)
         {
            this._labelYOffset = param1;
            invalidateLayout();
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
