package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.data.VPOfferVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.motion.Tween;
   
   public class OfferRenderer extends SoundButtonEx
   {
      
      public static const WIDTH:int = 140;
      
      public static const HEIGHT:int = 33;
      
      public static const SPACING:int = 8;
      
      private static const HOVER_ANIMATION_DURATION:int = 300;
      
      private static const HIT_AREA_BORDER_VALUE:int = 2;
       
      
      public var selectionSign:MovieClip = null;
      
      public var selection:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var selectedTitleTF:TextField = null;
      
      public var regularTitleTF:TextField = null;
      
      private var _index:uint;
      
      private var _offerVO:VPOfferVO = null;
      
      private var _hoverTweens:Vector.<Tween>;
      
      public function OfferRenderer()
      {
         super();
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      override protected function onDispose() : void
      {
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.disposeHoverTweens();
         this._hoverTweens = null;
         this.selectedTitleTF = null;
         this.regularTitleTF = null;
         this.selection = null;
         this.selectionSign = null;
         removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._hoverTweens = new Vector.<Tween>(0);
         allowDeselect = false;
         mouseChildren = false;
         buttonMode = true;
         soundType = SoundTypes.CAROUSEL_BTN;
         this.hover.alpha = 0;
         addEventListener(MouseEvent.MOUSE_OUT,this.onBtnSlotMouseOutHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onBtnSlotMouseOverHandler);
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "hitArea";
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
         if(this._offerVO && isInvalid(InvalidationType.DATA))
         {
            this.selectedTitleTF.htmlText = this._offerVO.label;
            this.regularTitleTF.htmlText = this._offerVO.label;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.selectedTitleTF.visible = this.selected;
            this.regularTitleTF.visible = !this.selected;
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
      
      public function getData() : Object
      {
         return this._offerVO;
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return super.data;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 == null || this._offerVO == param1)
         {
            return;
         }
         super.data = param1;
         this._offerVO = VPOfferVO(param1);
         invalidateData();
      }
      
      public function setData(param1:Object) : void
      {
      }
      
      public function setListData(param1:ListData) : void
      {
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
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = this.index;
      }
      
      public function get selectable() : Boolean
      {
         return true;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      private function onBtnSlotMouseOutHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         App.toolTipMgr.hide();
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":0}));
      }
      
      private function onBtnSlotMouseOverHandler(param1:MouseEvent) : void
      {
         this.disposeHoverTweens();
         App.toolTipMgr.showComplex(this._offerVO.tooltipData);
         this._hoverTweens.push(new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":1}));
      }
   }
}
