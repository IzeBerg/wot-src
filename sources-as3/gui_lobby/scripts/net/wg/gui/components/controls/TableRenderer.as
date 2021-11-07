package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.LobbyShared;
   import net.wg.infrastructure.managers.ISoundManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class TableRenderer extends SoundListItemRenderer implements ITableRenderer
   {
      
      private static const INV_PASSIVE:String = "invPassive";
      
      private static const UP_STATE_NAME:String = "up";
      
      private static const DEFAULT_SHADOW_BG_OFFSET:int = 4;
       
      
      public var rendererBg:MovieClip = null;
      
      public var disableMc:BitmapFill = null;
      
      public var disabledOverlayMc:BitmapFill = null;
      
      private var _statesPassive:Vector.<String>;
      
      private var _rendererBgLabelsHash:Object = null;
      
      private var _firstClick:Boolean = false;
      
      private var _isEnableDoubleClickSimulation:Boolean = false;
      
      private var _isPassive:Boolean = false;
      
      private var _preventAutoSizingBg:Boolean = false;
      
      public function TableRenderer()
      {
         this._statesPassive = Vector.<String>(["passive_"]);
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutosizing = true;
         if(this.disableMc)
         {
            this.updateDisableFillSize(this.disableMc);
         }
         if(this.disabledOverlayMc)
         {
            this.updateDisableFillSize(this.disabledOverlayMc);
         }
         constraints = null;
      }
      
      override protected function draw() : void
      {
         var _loc1_:ISoundManager = null;
         if(isInvalid(INV_PASSIVE))
         {
            _loc1_ = App.soundMgr;
            if(this._isPassive)
            {
               if(_loc1_)
               {
                  _loc1_.removeSoundHdlrs(this);
               }
            }
            else if(_loc1_)
            {
               _loc1_.addSoundsHdlrs(this);
            }
            setState(Boolean(_state) ? _state : UP_STATE_NAME);
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               this.setBackgroundState();
               _newFrame = null;
            }
            if(focusIndicator && _newFocusIndicatorFrame)
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            updateText();
            if(autoSize != TextFieldAutoSize.NONE)
            {
               invalidateSize();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(!preventAutosizing)
            {
               alignForAutoSize();
            }
            if(!this._preventAutoSizingBg)
            {
               this.rendererBg.width = _width;
            }
         }
         this.updateDisable(_data && !enabled);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._rendererBgLabelsHash = generateLabelHash(this.rendererBg);
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._isPassive)
         {
            return this._statesPassive;
         }
         return !!_selected ? statesSelected : statesDefault;
      }
      
      override protected function onDispose() : void
      {
         if(!this._isPassive && App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.stopSimulationDoubleClick();
         App.utils.data.cleanupDynamicObject(this._rendererBgLabelsHash);
         this._rendererBgLabelsHash = null;
         if(this.disabledOverlayMc)
         {
            this.disabledOverlayMc.dispose();
            this.disabledOverlayMc = null;
         }
         if(this.disableMc)
         {
            this.disableMc.dispose();
            this.disableMc = null;
         }
         this._statesPassive.splice(0,this._statesPassive.length);
         this._statesPassive = null;
         this.rendererBg = null;
         super.onDispose();
      }
      
      protected function updateDisable(param1:Boolean) : void
      {
         if(this.disableMc)
         {
            this.disableMc.visible = param1;
            this.updateDisableFillSize(this.disableMc);
         }
         if(this.disabledOverlayMc)
         {
            this.disabledOverlayMc.visible = param1;
            this.updateDisableFillSize(this.disabledOverlayMc);
         }
      }
      
      protected function getBgShadowOffset() : int
      {
         return DEFAULT_SHADOW_BG_OFFSET;
      }
      
      protected function startSimulationDoubleClick() : void
      {
         this._isEnableDoubleClickSimulation = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
      }
      
      protected function stopSimulationDoubleClick() : void
      {
         this._isEnableDoubleClickSimulation = false;
         App.utils.scheduler.cancelTask(this.clearFirstClick);
         this.stageRemoveListener();
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
      }
      
      protected function updateButtonMode() : void
      {
         buttonMode = !this._isPassive;
      }
      
      private function setBackgroundState() : void
      {
         if(this._rendererBgLabelsHash[_newFrame])
         {
            this.rendererBg.gotoAndPlay(_newFrame);
         }
         else
         {
            this.setDefaultBgState();
         }
      }
      
      private function updateDisableFillSize(param1:BitmapFill) : void
      {
         var _loc2_:Number = Math.max(scaleX,scaleY);
         param1.scaleX = 1 / _loc2_;
         param1.scaleY = 1 / _loc2_;
         param1.widthFill = this.rendererBg.width * _loc2_ >> 0;
         param1.heightFill = height - this.getBgShadowOffset() * _loc2_ >> 0;
      }
      
      private function stageRemoveListener() : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
      }
      
      private function setDefaultBgState() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc1_:Vector.<String> = this.getStatePrefixes();
         var _loc2_:uint = _loc1_.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = _loc4_ + UP_STATE_NAME;
            if(this._rendererBgLabelsHash[_loc5_])
            {
               this.rendererBg.gotoAndPlay(_loc5_);
               return;
            }
            _loc3_++;
         }
      }
      
      public function get isPassive() : Boolean
      {
         return this._isPassive;
      }
      
      public function set isPassive(param1:Boolean) : void
      {
         this._isPassive = param1;
         this.updateButtonMode();
         invalidate(INV_PASSIVE);
      }
      
      public function get preventAutoSizingBg() : Boolean
      {
         return this._preventAutoSizingBg;
      }
      
      public function set preventAutoSizingBg(param1:Boolean) : void
      {
         this._preventAutoSizingBg = param1;
         invalidateSize();
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(!this._isEnableDoubleClickSimulation)
         {
            super.handleMouseRelease(param1);
         }
      }
      
      private function clearFirstClick(param1:MouseEvent = null) : void
      {
         if(this._firstClick && param1)
         {
            super.handleMouseRelease(param1);
         }
         this._firstClick = false;
         this.stageRemoveListener();
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc4_:MouseEventEx = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:MouseEventEx = null;
         var _loc2_:Point = new Point(mouseX,mouseY);
         _loc2_ = localToGlobal(_loc2_);
         var _loc3_:Number = App.appScale;
         if(this.hitTestPoint(_loc2_.x / _loc3_,_loc2_.y / _loc3_,true))
         {
            if(this._firstClick)
            {
               this.stageRemoveListener();
               App.utils.scheduler.cancelTask(this.clearFirstClick);
               this._firstClick = false;
               _loc4_ = param1 as MouseEventEx;
               _loc5_ = _loc4_ == null ? uint(0) : uint(_loc4_.mouseIdx);
               _loc6_ = _loc4_ == null ? uint(0) : uint(_loc4_.buttonIdx);
               _loc7_ = new MouseEventEx(MouseEvent.DOUBLE_CLICK);
               _loc7_.mouseIdx = _loc5_;
               _loc7_.buttonIdx = _loc6_;
               dispatchEvent(_loc7_);
            }
            else
            {
               this._firstClick = true;
               param1.preventDefault();
               param1.stopImmediatePropagation();
               App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
               App.utils.scheduler.scheduleTask(this.clearFirstClick,LobbyShared.DOUBLE_CLICK_INTERVAL,param1);
            }
         }
         else
         {
            this._firstClick = false;
         }
      }
   }
}
