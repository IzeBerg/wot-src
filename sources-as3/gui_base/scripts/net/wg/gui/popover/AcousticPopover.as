package net.wg.gui.popover
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ACOUSTICS;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.popover.data.AcousticStaticData;
   import net.wg.gui.popover.data.AcousticTypeBlockData;
   import net.wg.gui.popover.vo.AcousticPopoverVo;
   import net.wg.infrastructure.base.meta.IAcousticPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.AcousticPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class AcousticPopover extends AcousticPopoverMeta implements IAcousticPopoverMeta
   {
      
      private static const SEPARATOR_TOP_MARGIN:Number = -13;
      
      private static const ACTION_BTN_TOP_MARGIN:Number = 11;
      
      private static const ACTION_BTN_BOTTOM_MARGIN:Number = 14;
       
      
      public var separator:MovieClip = null;
      
      public var bounds:Sprite = null;
      
      public var centerImg:Sprite = null;
      
      public var playBtn:IButtonIconLoader = null;
      
      public var pauseBtn:IButtonIconLoader = null;
      
      public var repeatBtn:IButtonIconLoader = null;
      
      private var _action_buttons:Object = null;
      
      private var _data:AcousticPopoverVo = null;
      
      private var _lastAnimatedItems:Vector.<AcousticButton> = null;
      
      private var _lastSelectedItems:Vector.<AcousticButton> = null;
      
      private var _selectedItemsRaw:Array = null;
      
      private var _animatedItemsRaw:Array = null;
      
      private var _isPopulated:Boolean = false;
      
      private var _acoustics:Vector.<AcousticButton> = null;
      
      private var _acousticsById:Object = null;
      
      private var _blockHeight:Number = 0;
      
      private var _isItemsEnabled:Boolean = true;
      
      public function AcousticPopover()
      {
         super();
         this._action_buttons = {
            "play":this.playBtn,
            "pause":this.pauseBtn,
            "repeat":this.repeatBtn
         };
         this._lastAnimatedItems = new Vector.<AcousticButton>();
         this._lastSelectedItems = new Vector.<AcousticButton>();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.playBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_PLAY;
         this.playBtn.iconOffsetLeft = 1;
         this.playBtn.iconOffsetTop = 1;
         this.pauseBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_PAUSE;
         this.pauseBtn.iconOffsetLeft = 1;
         this.pauseBtn.iconOffsetTop = 1;
         this.repeatBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_REFRESH;
         this.repeatBtn.iconOffsetLeft = 1;
         this.repeatBtn.iconOffsetTop = 1;
         this.playBtn.addEventListener(ButtonEvent.CLICK,this.onPlayBtnClickHandler);
         this.pauseBtn.addEventListener(ButtonEvent.CLICK,this.onPauseBtnClickHandler);
         this.repeatBtn.addEventListener(ButtonEvent.CLICK,this.onRepeatBtnClickHandler);
         this.addEventListener(Event.RESIZE,this.onResizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            PopOver(wrapper).titleTextField.text = this._data.title;
            this.applyData(new AcousticStaticData().getDataById(this._data.sndType));
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(Event.RESIZE,this.onResizeHandler);
         App.utils.data.cleanupDynamicObject(this._action_buttons);
         this._action_buttons = null;
         this.releaseAcousticItems();
         this._lastAnimatedItems = null;
         this._lastSelectedItems = null;
         if(this._selectedItemsRaw)
         {
            this._selectedItemsRaw.splice(0,this._selectedItemsRaw.length);
            this._selectedItemsRaw = null;
         }
         if(this._animatedItemsRaw)
         {
            this._animatedItemsRaw.splice(0,this._animatedItemsRaw.length);
            this._animatedItemsRaw = null;
         }
         this.playBtn.removeEventListener(ButtonEvent.CLICK,this.onPlayBtnClickHandler);
         this.pauseBtn.removeEventListener(ButtonEvent.CLICK,this.onPauseBtnClickHandler);
         this.repeatBtn.removeEventListener(ButtonEvent.CLICK,this.onRepeatBtnClickHandler);
         this.playBtn.dispose();
         this.pauseBtn.dispose();
         this.repeatBtn.dispose();
         this.playBtn = null;
         this.pauseBtn = null;
         this.repeatBtn = null;
         this.bounds = null;
         this.centerImg = null;
         this.separator = null;
         this._data.dispose();
         this._data = null;
         super.onDispose();
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_RIGHT;
         super.initLayout();
      }
      
      override public function get width() : Number
      {
         return this.bounds.width;
      }
      
      override public function get height() : Number
      {
         return this.bounds.height;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this);
      }
      
      override protected function setData(param1:AcousticPopoverVo) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function applyData(param1:AcousticTypeBlockData) : void
      {
         var _loc2_:AcousticButton = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.releaseAcousticItems();
         if(param1)
         {
            this.centerImg.y = param1.bgImgPosY;
            this._blockHeight = Math.max(this._blockHeight,this.centerImg.y + this.centerImg.height);
            this._acoustics = new Vector.<AcousticButton>();
            this._acousticsById = {};
            _loc2_ = null;
            _loc3_ = 0;
            _loc4_ = param1.items.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc2_ = App.utils.classFactory.getComponent(Linkages.ACOUSTIC_BTN,AcousticButton);
               _loc2_.setData(param1.items[_loc3_]);
               _loc2_.x = param1.items[_loc3_].x;
               _loc2_.y = param1.items[_loc3_].y;
               this._blockHeight = Math.max(this._blockHeight,_loc2_.y + _loc2_.height);
               this.addAcousticItemListener(_loc2_);
               this.addChild(_loc2_);
               this._acoustics.push(_loc2_);
               this._acousticsById[param1.items[_loc3_].id] = _loc2_;
               _loc3_++;
            }
            this._isPopulated = true;
            if(this._selectedItemsRaw)
            {
               this.onItemSelect(this._selectedItemsRaw);
               this._selectedItemsRaw.splice(0,this._selectedItemsRaw.length);
               this._selectedItemsRaw = null;
            }
            if(this._animatedItemsRaw)
            {
               this.onItemPlay(this._animatedItemsRaw);
               this._animatedItemsRaw.splice(0,this._animatedItemsRaw.length);
               this._animatedItemsRaw = null;
            }
         }
      }
      
      private function releaseAcousticItems() : void
      {
         var _loc1_:AcousticButton = null;
         if(this._acoustics)
         {
            _loc1_ = null;
            while(this._acoustics.length)
            {
               _loc1_ = this._acoustics.pop();
               delete this._acousticsById[_loc1_.id];
               this.removeAcousticItemsListener(_loc1_);
               this.removeChild(_loc1_);
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._acoustics = null;
            this._acousticsById = null;
         }
         this._blockHeight = 0;
         this._lastAnimatedItems.splice(0,this._lastAnimatedItems.length);
         this._lastSelectedItems.splice(0,this._lastSelectedItems.length);
      }
      
      private function addAcousticItemListener(param1:AcousticButton) : void
      {
         param1.addEventListener(ButtonEvent.CLICK,this.onAcousticItemClickHandler);
      }
      
      private function removeAcousticItemsListener(param1:AcousticButton) : void
      {
         param1.removeEventListener(ButtonEvent.CLICK,this.onAcousticItemClickHandler);
      }
      
      private function onAcousticItemClickHandler(param1:ButtonEvent) : void
      {
         onSpeakerClickS(AcousticButton(param1.target).id);
      }
      
      private function updateSize() : void
      {
         var _loc1_:Number = this._blockHeight + SEPARATOR_TOP_MARGIN;
         this.separator.y = _loc1_;
         _loc1_ += this.separator.height + ACTION_BTN_TOP_MARGIN;
         this.playBtn.y = _loc1_;
         this.pauseBtn.y = _loc1_;
         this.repeatBtn.y = _loc1_;
         this.bounds.height = _loc1_ + this.repeatBtn.height + ACTION_BTN_BOTTOM_MARGIN;
         popoverLayout.invokeLayout();
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      override protected function onItemSelect(param1:Array) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 110
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      override protected function onItemPlay(param1:Array) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 110
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public function as_setEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == this._isItemsEnabled)
         {
            return;
         }
         this._isItemsEnabled = param1;
         if(this._acoustics)
         {
            _loc2_ = 0;
            _loc3_ = this._acoustics.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this._acoustics[_loc2_].enabled = this._isItemsEnabled;
               _loc2_++;
            }
         }
      }
      
      private function onPlayBtnClickHandler(param1:ButtonEvent) : void
      {
         onActionStartS(ACOUSTICS.ACTION_PLAY);
      }
      
      private function onPauseBtnClickHandler(param1:ButtonEvent) : void
      {
         onActionStartS(ACOUSTICS.ACTION_PAUSE);
      }
      
      private function onRepeatBtnClickHandler(param1:ButtonEvent) : void
      {
         onActionStartS(ACOUSTICS.ACTION_REPEAT);
      }
      
      public function as_updateBtnEnabled(param1:String, param2:Boolean) : void
      {
         var _loc3_:IButtonIconLoader = null;
         if(this._action_buttons.hasOwnProperty(param1))
         {
            _loc3_ = this._action_buttons[param1];
            _loc3_.enabled = param2;
         }
      }
   }
}
