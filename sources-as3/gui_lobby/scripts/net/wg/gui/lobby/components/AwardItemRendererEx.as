package net.wg.gui.lobby.components
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class AwardItemRendererEx extends UIComponentEx implements IListItemRenderer, IUpdatable, IScrollerItemRenderer
   {
      
      private static const ICONS_OFFSET:int = 10;
      
      private static const ICONS_OFFSET_Y:int = 2;
      
      private static const EFFECTS_OFFSET_X:int = 3;
      
      private static const EFFECTS_OFFSET_Y:int = 5;
      
      private static const GLOW_ANIM_SCALE:Number = 0.4;
      
      private static const GLOW_MASK_SIZE:Number = 160;
       
      
      public var img:IImage;
      
      public var txtLabel:TextField;
      
      public var starIcon:IImage;
      
      public var awardObtainedIcon:IImage = null;
      
      public var highlight:MovieClip = null;
      
      public var overlay:MovieClip = null;
      
      public var glowAnim:MovieClip = null;
      
      public var glowMask:MovieClip = null;
      
      private var _data:AwardItemRendererExVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent;
      
      private var _hasSize:Boolean = false;
      
      private var _rendererWidth:Number = 0;
      
      private var _rendererHeight:Number = 0;
      
      private var _gap:int = 0;
      
      private var _allowRescaleUpward:Boolean = false;
      
      private var _loader:Loader;
      
      public function AwardItemRendererEx()
      {
         super();
         this._toolTipMgr = App.toolTipMgr;
         this.txtLabel.autoSize = TextFieldAutoSize.LEFT;
         this.highlight.mouseEnabled = this.overlay.mouseEnabled = false;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this._rendererWidth = param1;
         this._rendererHeight = param2;
         this._hasSize = true;
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this.img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.img.dispose();
         this.img = null;
         this.overlay = null;
         this.highlight = null;
         this.glowAnim = null;
         this.glowMask = null;
         if(this._loader)
         {
            this._loader.unloadAndStop();
            this._loader = null;
         }
         this.starIcon.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.starIcon.dispose();
         this.starIcon = null;
         this.awardObtainedIcon.removeEventListener(Event.CHANGE,this.onAwardObtainedIconChangeHandler);
         this.awardObtainedIcon.dispose();
         this.awardObtainedIcon = null;
         this.txtLabel = null;
         this._owner = null;
         this._data = null;
         this._toolTipMgr = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.txtLabel.mouseEnabled = false;
         this.img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.starIcon.addEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.starIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_STORE_CONDITION_ON;
         this.starIcon.visible = false;
         this.glowAnim.visible = false;
         this.awardObtainedIcon.addEventListener(Event.CHANGE,this.onAwardObtainedIconChangeHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:URLRequest = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               this.img.scaleX = this.img.scaleY = 1;
               this.txtLabel.htmlText = this._data.label;
               this.img.source = this._data.imgSource;
               this.starIcon.visible = this._data.hasCompensation;
               _loc1_ = this._data.obtainedImage;
               this.awardObtainedIcon.visible = this._data.isObtained && StringUtils.isNotEmpty(_loc1_) && StringUtils.isNotEmpty(this._data.imgSource);
               if(this.awardObtainedIcon.visible)
               {
                  if(this.awardObtainedIcon.source != _loc1_)
                  {
                     this.awardObtainedIcon.source = _loc1_;
                  }
               }
               else
               {
                  _loc6_ = this._data.tokensPawnedImage;
                  this.awardObtainedIcon.visible = this._data.areTokensPawned && StringUtils.isNotEmpty(_loc6_);
                  if(this.awardObtainedIcon.visible && this.awardObtainedIcon.source != _loc6_)
                  {
                     this.awardObtainedIcon.source = _loc6_;
                  }
               }
               _loc2_ = this._data.overlayType;
               _loc3_ = StringUtils.isNotEmpty(_loc2_);
               this.overlay.visible = _loc3_;
               if(_loc3_)
               {
                  this.overlay.gotoAndStop(_loc2_);
               }
               _loc4_ = this._data.highlightType;
               _loc5_ = StringUtils.isNotEmpty(_loc4_);
               this.highlight.visible = _loc5_;
               if(_loc5_)
               {
                  this.highlight.gotoAndStop(_loc4_);
               }
               this._gap = this._data.gap;
               this.updateTextFieldLayout();
               invalidateSize();
               this.txtLabel.visible = this.img.visible = true;
               if(this._data.hasAnimation)
               {
                  _loc7_ = new URLRequest("animations/battlePass/BPRays.swf");
                  this._loader = new Loader();
                  this._loader.load(_loc7_);
                  this.glowAnim.addChild(this._loader);
                  this.glowAnim.scaleX = this.glowAnim.scaleY = GLOW_ANIM_SCALE;
                  this.glowMask.width = this.glowMask.height = GLOW_MASK_SIZE;
                  this.glowAnim.visible = true;
                  this.glowAnim.mouseEnabled = this.glowAnim.mouseChildren = false;
               }
            }
            else
            {
               this.txtLabel.visible = this.img.visible = this.awardObtainedIcon.visible = false;
            }
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            if(this._hasSize)
            {
               if(this.img.width > this._rendererWidth || this.img.height > this._rendererHeight || this._allowRescaleUpward && (this.img.width != this._rendererWidth || this.img.height != this._rendererHeight))
               {
                  _loc8_ = this._rendererWidth / this.img.bitmapWidth;
                  _loc9_ = this._rendererHeight / this.img.bitmapHeight;
                  this.img.scaleX = this.img.scaleY = _loc8_ > _loc9_ ? Number(_loc9_) : Number(_loc8_);
               }
               this.img.x = this._rendererWidth - this.img.width >> 1;
               this.img.y = this._rendererHeight - this.img.height >> 1;
               this.highlight.x = this.overlay.x = this.img.x + EFFECTS_OFFSET_X;
               this.highlight.y = this.overlay.y = this.img.y + EFFECTS_OFFSET_Y;
               this.starIcon.x = this.width - this.starIcon.width + ICONS_OFFSET ^ 0;
               this.awardObtainedIcon.x = this._rendererWidth - this.awardObtainedIcon.width >> 1;
               this.awardObtainedIcon.y = this.img.y + this.img.height - (this.awardObtainedIcon.height >> 1) + this._data.obtainedImageOffset ^ 0;
            }
            else
            {
               this.awardObtainedIcon.x = this.img.x + (this.img.width - this.awardObtainedIcon.width >> 1);
            }
            if(this._data.hasAnimation)
            {
               this.glowAnim.x = Math.round(-this.glowAnim.width / 2 + this.img.x + this.img.width / 2);
               this.glowAnim.y = Math.round(-this.glowAnim.height / 2 + this.img.y + this.img.height / 2);
               this.glowMask.x = Math.round(-this.glowMask.width / 2 + this.img.x + this.img.width / 2);
               this.glowMask.y = Math.round(-this.glowMask.height / 2 + this.img.y + this.img.height / 2);
            }
            this.updateTextFieldLayout();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = AwardItemRendererExVO(param1);
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      private function updateTextFieldLayout() : void
      {
         if(this._data.align == TEXT_ALIGN.RIGHT)
         {
            this.txtLabel.x = this.img.x + this.img.width - this.txtLabel.width + this._data.padding ^ 0;
         }
         else if(this._data.align == TEXT_ALIGN.LEFT)
         {
            this.txtLabel.x = this.img.x - this.txtLabel.width + ICONS_OFFSET - this._data.padding ^ 0;
         }
         else
         {
            this.txtLabel.x = this.img.x + (this.img.width - this.txtLabel.width >> 1) ^ 0;
         }
         this.txtLabel.y = this.img.y + this.img.height - this.txtLabel.textHeight + this._gap + ICONS_OFFSET_Y ^ 0;
      }
      
      private function showToolTip() : void
      {
         if(this._data.isWulfTooltip)
         {
            this._toolTipMgr.showWulfTooltip.apply(this._toolTipMgr,[this._data.specialAlias].concat(this._data.specialArgs));
         }
         else if(this._data.isSpecial)
         {
            this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
         }
         else if(this._data.isWulfTooltip)
         {
            this._toolTipMgr.showWulfTooltip.apply(this._toolTipMgr,[this._data.tooltip].concat(this._data.specialArgs));
         }
         else if(StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._toolTipMgr.showComplex(this._data.tooltip);
         }
      }
      
      private function showTooltipOnStarComponent() : void
      {
         this._toolTipMgr.showComplex(this._data.compensationTooltip);
      }
      
      override public function get width() : Number
      {
         return this._rendererWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1,this._rendererHeight);
      }
      
      override public function get height() : Number
      {
         return this._rendererHeight;
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this._rendererWidth,param1);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         var _loc2_:Point = null;
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         if(param1 && this._data)
         {
            _loc2_ = new Point(mouseX,mouseY);
            _loc2_ = localToGlobal(_loc2_);
            if(hitTestPoint(_loc2_.x,_loc2_.y,true))
            {
               if(this.starIcon.visible && this.starIcon.hitTestPoint(_loc2_.x,_loc2_.y,true))
               {
                  this.showTooltipOnStarComponent();
               }
               else
               {
                  this.showToolTip();
               }
            }
         }
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
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
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this.setData(param1);
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      public function set allowRescaleUpward(param1:Boolean) : void
      {
         this._allowRescaleUpward = param1;
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
      
      private function onAwardObtainedIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.enabled)
         {
            return;
         }
         if(param1.target == this.starIcon)
         {
            this.showTooltipOnStarComponent();
         }
         else if(this._hasSize && param1.target == this || param1.target == this.img)
         {
            this.showToolTip();
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
