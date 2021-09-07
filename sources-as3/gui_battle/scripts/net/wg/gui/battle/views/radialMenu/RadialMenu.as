package net.wg.gui.battle.views.radialMenu
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.generated.RADIAL_MENU_CONSTS;
   import net.wg.gui.battle.views.radialMenu.components.BackGround;
   import net.wg.infrastructure.base.meta.IRadialMenuMeta;
   import net.wg.infrastructure.base.meta.impl.RadialMenuMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.gfx.MouseEventEx;
   
   public class RadialMenu extends RadialMenuMeta implements IRadialMenuMeta
   {
      
      private static const DEFAULT_NONE_KEY:String = "";
      
      private static const BACK_ALPHA:Number = 0.6;
      
      private static const INTERNAL_MENU_RADIUS:int = 20;
      
      private static const OFFSET_ANGLE:Number = 30;
      
      private static const POINT_RADIUS:int = 190;
      
      private static const EFFECT_TIME:int = 900;
      
      private static const PAUSE_BEFORE_HIDE:int = 300;
      
      private static const CIRCLE_DEGREES:int = 360;
      
      private static const HIDE_STATE:String = "hide";
       
      
      public var negativeBtn:RadialButton = null;
      
      public var toBaseBtn:RadialButton = null;
      
      public var helpBtn:RadialButton = null;
      
      public var reloadBtn:RadialButton = null;
      
      public var attackBtn:RadialButton = null;
      
      public var positiveBtn:RadialButton = null;
      
      public var background:BackGround = null;
      
      public var circleBackground:MovieClip = null;
      
      public var arrowElement:MovieClip = null;
      
      private var _bottomShortcutsMap:Dictionary;
      
      private var _regularShortcutsMap:Dictionary;
      
      private var _state:String = "default";
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _wheelPosition:int = -1;
      
      private var _scaleKoefX:Number = 1;
      
      private var _scaleKoefY:Number = 1;
      
      private var _mouseOffset:Point;
      
      private var _isAction:Boolean = false;
      
      private var _buttons:Vector.<RadialButton> = null;
      
      private var _buttonsCount:int = 6;
      
      private var _color:String = "white";
      
      private var _backgroundColor:String = "";
      
      private var _hideWithAnimationState:Boolean = false;
      
      private var _colorMgr:IColorSchemeManager;
      
      private var _isColorBlind:Boolean = false;
      
      public function RadialMenu()
      {
         this._bottomShortcutsMap = new Dictionary();
         this._regularShortcutsMap = new Dictionary();
         this._mouseOffset = new Point(0,0);
         this._colorMgr = App.colorSchemeMgr;
         super();
         this._buttons = new <RadialButton>[this.negativeBtn,this.toBaseBtn,this.helpBtn,this.reloadBtn,this.attackBtn,this.positiveBtn];
         this._buttonsCount = this._buttons.length;
         this._isColorBlind = this._colorMgr.getIsColorBlindS();
         this.resetState();
         this.updateButtons();
      }
      
      override protected function buildData(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = param1.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_].state;
            this._bottomShortcutsMap[_loc3_] = param1[_loc4_].bottomShortcuts;
            this._regularShortcutsMap[_loc3_] = param1[_loc4_].regularShortcuts;
            _loc4_++;
         }
      }
      
      override protected function show(param1:Number, param2:Number, param3:String, param4:Array, param5:Array) : void
      {
         this._isAction = false;
         this._state = param3;
         if(RADIAL_MENU_CONSTS.GREEN_TARGET_STATES.indexOf(param3) >= 0)
         {
            this._color = RADIAL_MENU_CONSTS.GREEN_STATE;
            this._backgroundColor = param3 == RADIAL_MENU_CONSTS.TARGET_STATE_ALLY ? RADIAL_MENU_CONSTS.GREEN_STATE : RADIAL_MENU_CONSTS.GREEN_STATE_2;
         }
         else if(RADIAL_MENU_CONSTS.RED_TARGET_STATES.indexOf(param3) >= 0)
         {
            this._color = this._backgroundColor = !!this._isColorBlind ? RADIAL_MENU_CONSTS.PURPLE_STATE : RADIAL_MENU_CONSTS.RED_STATE;
         }
         else
         {
            this._color = this._backgroundColor = RADIAL_MENU_CONSTS.ORANGE_STATE;
         }
         this.arrowElement.arrow.gotoAndStop(this._color);
         this.circleBackground.visible = true;
         this.circleBackground.gotoAndStop(this._backgroundColor);
         App.utils.scheduler.cancelTask(this.internalHide);
         App.utils.scheduler.cancelTask(this.hideButton);
         this.updateData(param4);
         this.internalShow(param1,param2);
         x = param5[0];
         y = param5[1];
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.setSize(this._stageWidth,this._stageHeight);
            onRefreshS();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.background.setBackgroundAlpha(BACK_ALPHA);
      }
      
      override protected function onDispose() : void
      {
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         App.utils.scheduler.cancelTask(this.internalHide);
         App.utils.scheduler.cancelTask(this.hideButton);
         this.internalHide();
         this._buttons.length = 0;
         App.utils.data.cleanupDynamicObject(this._bottomShortcutsMap);
         App.utils.data.cleanupDynamicObject(this._regularShortcutsMap);
         this.negativeBtn.dispose();
         this.negativeBtn = null;
         this.toBaseBtn.dispose();
         this.toBaseBtn = null;
         this.helpBtn.dispose();
         this.helpBtn = null;
         this.reloadBtn.dispose();
         this.reloadBtn = null;
         this.attackBtn.dispose();
         this.attackBtn = null;
         this.positiveBtn.dispose();
         this.positiveBtn = null;
         this.background.dispose();
         this.background = null;
         this.circleBackground = null;
         this.arrowElement = null;
         this._colorMgr = null;
         this._bottomShortcutsMap = null;
         this._regularShortcutsMap = null;
         this._mouseOffset = null;
         this._buttons = null;
         super.onDispose();
      }
      
      public function as_hide(param1:Boolean) : void
      {
         if(param1)
         {
            this.doActionAndHideRadialMenu();
         }
         else
         {
            this.internalHide();
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidateSize();
      }
      
      private function updateDataForWithShortcutsArray(param1:Array, param2:Boolean) : void
      {
         var _loc3_:RadialButton = null;
         var _loc4_:Object = null;
         var _loc7_:String = null;
         var _loc5_:uint = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1[_loc6_];
            if(_loc4_ == null)
            {
               DebugUtils.LOG_ERROR("Missing data for button: ",_loc6_,this._state);
            }
            else
            {
               _loc3_ = this._buttons[_loc4_.indexInGroup];
               _loc3_.action = _loc4_.action;
               _loc7_ = RADIAL_MENU_CONSTS.WHITE_STATE;
               if(!param2)
               {
                  _loc7_ = this._color;
               }
               _loc3_.setTitle(_loc4_.title,_loc7_);
               _loc3_.iconState = _loc7_;
               _loc3_.icon = _loc4_.icon;
               if(!isNaN(_loc4_.key) && _loc4_.key != KeyProps.KEY_NONE)
               {
                  _loc3_.hotKey = App.utils.commons.keyToString(_loc4_.key).keyName;
               }
               else
               {
                  _loc3_.hotKey = DEFAULT_NONE_KEY;
               }
               _loc3_.buttonVisualState = _loc4_.bState;
               _loc3_.idx = _loc4_.indexInGroup;
               _loc3_.enabled = false;
            }
            _loc6_++;
         }
      }
      
      private function updateData(param1:Array) : void
      {
         this.updateDataForWithShortcutsArray(this._bottomShortcutsMap[this._state],true);
         var _loc2_:Array = this._regularShortcutsMap[this._state];
         if(param1.length > 0)
         {
            _loc2_ = param1;
         }
         this.updateDataForWithShortcutsArray(_loc2_,false);
      }
      
      private function selectButton(param1:RadialButton) : void
      {
         if(!param1.selected)
         {
            param1.state = InteractiveStates.OVER;
            param1.selected = true;
            if(param1.buttonVisualState != RADIAL_MENU_CONSTS.EMPTY_BUTTON_STATE || param1.buttonVisualState != RADIAL_MENU_CONSTS.DISABLED_BUTTON_STATE)
            {
               onSelectS();
            }
         }
      }
      
      private function unSelectButton(param1:RadialButton) : void
      {
         if(param1.selected)
         {
            param1.state = InteractiveStates.OUT;
            param1.selected = false;
         }
      }
      
      private function cancelButton(param1:RadialButton) : void
      {
         param1.state = InteractiveStates.UP;
         param1.selected = false;
      }
      
      private function internalShow(param1:Number, param2:Number) : void
      {
         this._scaleKoefX = 1 / App.stage.scaleX;
         this._scaleKoefY = 1 / App.stage.scaleY;
         this._hideWithAnimationState = false;
         visible = true;
         this.background.visible = true;
         var _loc3_:uint = 0;
         while(_loc3_ < this._buttonsCount)
         {
            this.cancelButton(this._buttons[_loc3_]);
            this._buttons[_loc3_].visible = this._buttons[_loc3_].buttonVisualState != RADIAL_MENU_CONSTS.EMPTY_BUTTON_STATE;
            _loc3_++;
         }
         if(App.stage)
         {
            App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         }
         this._mouseOffset.x = 0;
         this._mouseOffset.y = 0;
         this._wheelPosition = -1;
         this.checkButtonSelectionWithMouse(param1,param2);
      }
      
      private function hideWithAnimation() : void
      {
         App.utils.scheduler.scheduleTask(this.internalHide,EFFECT_TIME);
         this._hideWithAnimationState = true;
         if(App.stage)
         {
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         }
      }
      
      private function internalHide() : void
      {
         this.resetState();
         onHideCompletedS();
      }
      
      private function resetState() : void
      {
         visible = false;
         this._hideWithAnimationState = false;
         this._mouseOffset = new Point(0,0);
         this._wheelPosition = -1;
         this.arrowElement.visible = false;
         if(App.stage)
         {
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         }
      }
      
      private function hideButton(param1:Array) : void
      {
         var _loc2_:RadialButton = param1[0];
         _loc2_.state = HIDE_STATE;
      }
      
      private function updateButtons() : void
      {
         var _loc2_:RadialButton = null;
         var _loc3_:Number = NaN;
         var _loc1_:Number = CIRCLE_DEGREES / this._buttons.length;
         var _loc4_:uint = 0;
         while(_loc4_ < this._buttonsCount)
         {
            _loc2_ = this._buttons[_loc4_];
            _loc3_ = _loc1_ * _loc4_ + OFFSET_ANGLE;
            if(_loc4_ > (this._buttonsCount >> 1) - 1)
            {
               _loc3_ = -CIRCLE_DEGREES + _loc3_;
            }
            _loc2_.angle = _loc3_;
            _loc4_++;
         }
      }
      
      private function doActionAndHideRadialMenu() : void
      {
         var _loc2_:RadialButton = null;
         if(!this.visible)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc3_:Number = 0;
         while(_loc3_ < this._buttonsCount)
         {
            _loc2_ = this._buttons[_loc3_];
            if(_loc2_.selected && _loc2_.buttonVisualState == RADIAL_MENU_CONSTS.NORMAL_BUTTON_STATE)
            {
               App.utils.scheduler.scheduleTask(this.hideButton,PAUSE_BEFORE_HIDE,[_loc2_]);
               this._isAction = true;
               onActionS(_loc2_.action);
               _loc1_ = true;
            }
            else
            {
               this._buttons[_loc3_].visible = false;
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            this.background.visible = false;
            this.circleBackground.visible = false;
            this.arrowElement.visible = false;
            this.hideWithAnimation();
         }
         else
         {
            this.internalHide();
         }
      }
      
      override public function get visible() : Boolean
      {
         return !this._hideWithAnimationState && super.visible;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this._isColorBlind = App.colorSchemeMgr.getIsColorBlindS();
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this.handleMouseButtonEvent(param1);
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this.handleMouseButtonEvent(param1);
      }
      
      private function handleMouseButtonEvent(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx)
         {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
               this.internalHide();
            }
            else if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
               this.doActionAndHideRadialMenu();
            }
         }
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         this.checkButtonSelectionWithMouse(this.mouseX,this.mouseY);
      }
      
      private function checkButtonSelectionWithMouse(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:RadialButton = null;
         if(this.visible && !this._isAction)
         {
            this._wheelPosition = -1;
            _loc3_ = 0;
            _loc4_ = new Point(param1,param2);
            _loc5_ = _loc4_.x - this._mouseOffset.x;
            _loc6_ = _loc4_.y - this._mouseOffset.y;
            _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            if(_loc7_ <= INTERNAL_MENU_RADIUS)
            {
               while(_loc3_ < this._buttonsCount)
               {
                  this.unSelectButton(this._buttons[_loc3_]);
                  _loc3_++;
               }
               this.arrowElement.visible = false;
               return;
            }
            _loc9_ = Math.atan2(_loc6_,_loc5_);
            _loc10_ = POINT_RADIUS * Math.cos(_loc9_);
            _loc11_ = POINT_RADIUS * Math.sin(_loc9_);
            _loc4_.x = _loc10_;
            _loc4_.y = _loc11_;
            if(_loc7_ > POINT_RADIUS)
            {
               this._mouseOffset.x = this.mouseX - _loc10_;
               this._mouseOffset.y = this.mouseY - _loc11_;
            }
            if(_loc7_ > INTERNAL_MENU_RADIUS)
            {
               _loc4_ = this.localToGlobal(_loc4_);
               while(_loc3_ < this._buttonsCount)
               {
                  _loc12_ = this._buttons[_loc3_];
                  if(_loc12_.hitAreaSpr.hitTestPoint(_loc4_.x * this._scaleKoefX,_loc4_.y * this._scaleKoefY,true))
                  {
                     this.selectButton(_loc12_);
                  }
                  else
                  {
                     this.unSelectButton(_loc12_);
                  }
                  _loc3_++;
               }
            }
            _loc8_ = Math.atan2(_loc6_,_loc5_) * 180 / Math.PI;
            this.arrowElement.rotation = _loc8_;
            this.arrowElement.visible = this.visible;
         }
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:RadialButton = null;
         var _loc4_:uint = 0;
         if(this.visible && !this._isAction)
         {
            _loc2_ = param1.delta;
            if(this._wheelPosition == -1)
            {
               _loc4_ = 0;
               while(_loc4_ < this._buttonsCount)
               {
                  _loc3_ = this._buttons[_loc4_];
                  if(_loc3_.selected)
                  {
                     this._wheelPosition = _loc4_;
                     break;
                  }
                  _loc4_++;
               }
            }
            if(this._wheelPosition > -1)
            {
               this.unSelectButton(this._buttons[this._wheelPosition]);
            }
            if(_loc2_ < 0)
            {
               ++this._wheelPosition;
               if(this._wheelPosition >= this._buttonsCount)
               {
                  this._wheelPosition = 0;
               }
            }
            else
            {
               --this._wheelPosition;
               if(this._wheelPosition < 0)
               {
                  this._wheelPosition = this._buttonsCount - 1;
               }
            }
            this.selectButton(this._buttons[this._wheelPosition]);
         }
      }
   }
}
