package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import fl.transitions.easing.Strong;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPVehicleCarouselVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   
   public class SetVehiclesRenderer extends UIComponentEx implements IScrollerItemRenderer, ISoundable
   {
      
      public static const WIDTH:int = 168;
      
      public static const HEIGHT:int = 60;
      
      private static const HOVER_ANIMATION_DURATION:int = 300;
      
      private static const FADE_OUT_ANIMATION_DURATION:int = 250;
      
      private static const VEHICLE_ICON_WIDTH:int = 120;
      
      private static const VEHICLE_ICON_HEIGHT:int = 90;
      
      private static const HIT_AREA_PADDING:Number = 0.5;
      
      private static const HIR_AREA_Y_POSITION:int = 27;
      
      private static const HIT_AREA_BORDER_VALUE:int = 2;
       
      
      public var selection:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var icon:Image = null;
      
      public var titleTF:TextField = null;
      
      public var flag:MovieClip = null;
      
      public var compensationStatus:Image = null;
      
      public var vehicleType:Image = null;
      
      public var vehicleLevel:Image = null;
      
      private var _data:VPVehicleCarouselVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _selected:Boolean = false;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent = null;
      
      private var _imageTween:Tween;
      
      private var _hoverTweens:Vector.<Tween>;
      
      public function SetVehiclesRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.disposeImageTween();
         this.disposeHoverTweens();
         this._imageTween = null;
         this._hoverTweens = null;
         this.icon.removeEventListener(Event.CHANGE,this.onIconLoadComplete);
         this.icon.dispose();
         this.icon = null;
         this.titleTF = null;
         this.flag = null;
         this.selection = null;
         this.vehicleType.removeEventListener(Event.CHANGE,this.onVehicleInfoLoadComplete);
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.vehicleLevel.removeEventListener(Event.CHANGE,this.onVehicleInfoLoadComplete);
         this.vehicleLevel.dispose();
         this.vehicleLevel = null;
         this.compensationStatus.dispose();
         this.compensationStatus = null;
         removeEventListener(MouseEvent.CLICK,this.onBtnSlotClickHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._hoverTweens = new Vector.<Tween>(0);
         mouseChildren = false;
         buttonMode = true;
         this.icon.alpha = 0;
         this.icon.addEventListener(Event.CHANGE,this.onIconLoadComplete);
         this.hover.alpha = 0;
         this.titleTF.alpha = 0.7;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         addEventListener(MouseEvent.CLICK,this.onBtnSlotClickHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "hitArea";
         hitArea = _loc1_;
         addChildAt(hitArea,0);
         this.compensationStatus.visible = false;
         this.vehicleType.addEventListener(Event.CHANGE,this.onVehicleInfoLoadComplete);
         this.vehicleLevel.addEventListener(Event.CHANGE,this.onVehicleInfoLoadComplete);
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.disposeImageTween();
            this.flag.gotoAndStop(this._data.nation + 1);
            if(this.icon.source != this._data.icon)
            {
               this.icon.alpha = 0;
               this.icon.sourceAlt = this._data.iconAlt;
               this.icon.source = this._data.icon || this._data.iconAlt;
            }
            this.vehicleLevel.source = this._data.level;
            this.vehicleType.source = this._data.tankType;
            this.titleTF.htmlText = this._data.label;
            this.compensationStatus.visible = this._data.hasCompensation;
            if(this.compensationStatus.visible)
            {
               this.compensationStatus.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
            }
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.selection.visible = this.selected;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = hitArea.graphics;
            _loc1_.clear();
            _loc1_.lineStyle(1,16777215,0.15);
            _loc1_.beginFill(0,0.25);
            _loc1_.drawRoundRect(HIT_AREA_PADDING,HIR_AREA_Y_POSITION + HIT_AREA_PADDING,WIDTH - HIT_AREA_PADDING * 2,HEIGHT - HIT_AREA_PADDING * 2,HIT_AREA_BORDER_VALUE,HIT_AREA_BORDER_VALUE);
            _loc1_.endFill();
            this.vehicleType.x = this.vehicleLevel.x + this.vehicleLevel.width - 4;
            this.vehicleType.y = this.vehicleLevel.y + (this.vehicleLevel.height - this.vehicleType.height >> 1);
            this.titleTF.x = this.vehicleType.x + this.vehicleType.width - 2;
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return null;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.CAROUSEL_BTN;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      private function disposeImageTween() : void
      {
         if(this._imageTween)
         {
            this._imageTween.paused = true;
            this._imageTween.dispose();
         }
      }
      
      private function disposeHoverTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._hoverTweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._hoverTweens.length = 0;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1 == null || this._data == param1)
         {
            return;
         }
         this._data = VPVehicleCarouselVO(param1);
         App.utils.asserter.assertNotNull(this._data,"_data" + Errors.CANT_NULL);
         invalidateData();
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      public function get rowsCount() : int
      {
         return Values.ZERO;
      }
      
      public function set rowsCount(param1:int) : void
      {
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
      
      private function onBtnSlotClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isLeftButton(param1) && !this.selected)
         {
            dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
            dispatchEvent(new VehiclePreviewEvent(VehiclePreviewEvent.SHOW,this._data));
         }
      }
      
      private function onBtnSlotMouseOutHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         this._toolTipMgr.hide();
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":0}),new Tween(HOVER_ANIMATION_DURATION,this.titleTF,{"alpha":0.7},{"fastTransform":false}));
      }
      
      private function onBtnSlotMouseOverHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SHOP_VEHICLE,null,this._data.intCD);
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":1}),new Tween(HOVER_ANIMATION_DURATION,this.titleTF,{"alpha":1},{"fastTransform":false}));
      }
      
      private function onIconLoadComplete(param1:Event) : void
      {
         this.disposeImageTween();
         this.icon.width = VEHICLE_ICON_WIDTH;
         this.icon.height = VEHICLE_ICON_HEIGHT;
         this._imageTween = new Tween(FADE_OUT_ANIMATION_DURATION,this.icon,{"alpha":1},{"ease":Strong.easeIn});
      }
      
      private function onVehicleInfoLoadComplete(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
