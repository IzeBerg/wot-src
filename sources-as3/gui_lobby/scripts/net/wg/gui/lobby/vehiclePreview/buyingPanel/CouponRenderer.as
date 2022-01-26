package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.data.VPCouponVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class CouponRenderer extends SoundButtonEx
   {
      
      public static const WIDTH:int = 60;
      
      public static const HEIGHT:int = 60;
      
      private static const HOVER_ANIMATION_DURATION:int = 300;
      
      private static const HIT_AREA_BORDER_VALUE:int = 2;
      
      private static const HIT_AREA_NAME:String = "hitArea";
       
      
      public var selectionSign:MovieClip = null;
      
      public var selection:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var icon:Image = null;
      
      private var _couponVO:VPCouponVO = null;
      
      private var _hoverTweens:Vector.<Tween>;
      
      private var _couponDiscount:int = 0;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function CouponRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.disposeHoverTweens();
         this._hoverTweens = null;
         this._couponVO = null;
         this._toolTipMgr = null;
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.selection = null;
         this.hover = null;
         this.selectionSign = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.mouseEnabled = false;
         this._hoverTweens = new Vector.<Tween>(0);
         allowDeselect = false;
         mouseChildren = false;
         buttonMode = true;
         soundType = SoundTypes.CAROUSEL_BTN;
         this.hover.alpha = 0;
         addEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = HIT_AREA_NAME;
         hitArea = _loc1_;
         addChildAt(hitArea,0);
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(this._couponVO && isInvalid(InvalidationType.DATA))
         {
            this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.icon.source = this._couponVO.icon;
            this.selected = this._couponVO.isSelected;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.selection.visible = this.selectionSign.visible = this.selected;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = hitArea.graphics;
            _loc1_.clear();
            _loc1_.lineStyle(1,16777215,0.35);
            _loc1_.beginFill(0,0.35);
            _loc1_.drawRoundRect(0,0,WIDTH,HEIGHT,HIT_AREA_BORDER_VALUE,HIT_AREA_BORDER_VALUE);
            _loc1_.endFill();
         }
      }
      
      public function setCouponDiscount(param1:int) : void
      {
         this._couponDiscount = param1;
      }
      
      private function disposeHoverTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._hoverTweens)
         {
            for each(_loc1_ in this._hoverTweens)
            {
               _loc1_.paused = true;
               _loc1_.dispose();
            }
            this._hoverTweens.length = 0;
         }
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 == null || this._couponVO == param1)
         {
            return;
         }
         super.data = param1;
         this._couponVO = VPCouponVO(param1);
         invalidateData();
      }
      
      override public function get selected() : Boolean
      {
         return _selected;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         invalidate(InvalidationType.SELECTED_INDEX);
         dispatchEventAndSound(new Event(Event.SELECT));
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.x = WIDTH - this.icon.width >> 1;
         this.icon.y = HEIGHT - this.icon.height >> 1;
      }
      
      private function onBtnSlotMouseOutHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         this._toolTipMgr.hide();
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":0}));
      }
      
      private function onBtnSlotMouseOverHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         this._toolTipMgr.showSpecial(this._couponVO.tooltip,null,this._couponDiscount,this._couponVO.tooltipBonusesData);
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":1}));
      }
   }
}
