package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.base.meta.impl.WindowViewMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IWindowGeometry;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.utils.IViewRestrictions;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class AbstractWindowView extends WindowViewMeta implements IAbstractWindowView
   {
      
      private static const BG_ENABLED:String = "enable";
      
      private static const BG_DISABLED:String = "disable";
       
      
      private var _window:IWindow;
      
      private var _canMinimize:Boolean = false;
      
      private var _enabledCloseBtn:Boolean = true;
      
      private var _canResize:Boolean = false;
      
      private var _showWindowBgForm:Boolean = true;
      
      private var _showWindowBg:Boolean = true;
      
      private var _geometry:IWindowGeometry;
      
      private var _isSourceTracked:Boolean = false;
      
      public function AbstractWindowView()
      {
         super();
         this._geometry = new DefaultWindowGeometry();
      }
      
      override public function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      override public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         App.utils.scheduler.scheduleOnNextFrame(this.changeBackgroundLabel,BG_ENABLED);
      }
      
      override protected function onLeaveModalFocus() : void
      {
         super.onLeaveModalFocus();
         App.utils.scheduler.scheduleOnNextFrame(this.changeBackgroundLabel,BG_DISABLED);
      }
      
      override protected function getViewContainer() : DisplayObjectContainer
      {
         return DisplayObjectContainer(this.window);
      }
      
      override protected function configUI() : void
      {
         if(this.window)
         {
            this.window.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         }
         initSize();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this._window)
         {
            this._window.removeEventListener(InputEvent.INPUT,this.handleInput);
         }
         App.utils.scheduler.cancelTask(this.changeBackgroundLabel);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._window)
         {
            this._window.dispose();
            this._window.setWindowContent(null);
            this._window = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.geometry && this._window && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            this.geometry.setPosition(this._window);
            this.checkAppBounds();
         }
      }
      
      public function as_getGeometry() : Array
      {
         if(this._window)
         {
            return [this._window.x,this._window.y,this._window.width,this._window.height];
         }
         return null;
      }
      
      public function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this._geometry = new StoredWindowGeometry(param1,param2,param3,param4);
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      public function getWrapperLinkage() : String
      {
         return Linkages.WINDOW;
      }
      
      public function handleWindowClose() : void
      {
         if(onTryClosingS())
         {
            onWindowCloseS();
         }
      }
      
      public function handleWindowMinimize() : void
      {
         onWindowMinimizeS();
      }
      
      public function setWindow(param1:IWindow) : void
      {
         this._window = param1;
      }
      
      protected final function canCloseFromInputDetails(param1:InputDetails) : Boolean
      {
         return param1.code == Keyboard.ESCAPE && param1.value == InputValue.KEY_DOWN && this._window.getBackground().currentLabel == BG_ENABLED;
      }
      
      protected function onClosingApproved() : void
      {
      }
      
      protected function onClosingDeclined() : void
      {
      }
      
      protected function changeBackgroundLabel(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         if(this.window)
         {
            _loc2_ = this._window.getBackground();
            if(_loc2_ && _loc2_.currentLabel != param1)
            {
               _loc2_.gotoAndPlay(param1);
            }
         }
      }
      
      private function checkAppBounds() : void
      {
         var _loc1_:IViewRestrictions = App.utils.viewRestrictions;
         var _loc2_:int = _loc1_.leftOffset;
         var _loc3_:int = _loc1_.topOffset;
         var _loc4_:int = App.appWidth - _loc1_.horizontalOffset;
         var _loc5_:int = App.appHeight - _loc1_.verticalOffset;
         var _loc6_:int = this._window.width;
         if(_loc6_ > _loc4_)
         {
            this._window.x = Math.max(_loc4_ - _loc6_ >> 1,_loc2_);
         }
         else
         {
            if(this._window.x < _loc2_)
            {
               this._window.x = _loc2_;
            }
            if(this._window.x + _loc6_ > _loc4_)
            {
               this._window.x = _loc4_ - _loc6_ | 0;
            }
         }
         var _loc7_:int = this._window.height;
         if(_loc7_ > _loc5_)
         {
            this._window.y = Math.max(_loc5_ - _loc7_ >> 1,_loc3_);
         }
         else
         {
            if(this._window.y < _loc3_)
            {
               this._window.y = _loc3_;
            }
            if(this._window.y + _loc7_ > _loc5_)
            {
               this._window.y = _loc5_ - _loc7_ | 0;
            }
         }
      }
      
      private function validateView() : void
      {
         if(this._window != null)
         {
            UIComponent(this._window).invalidate(Window.INVALID_SRC_VIEW);
         }
      }
      
      override public function get isModal() : Boolean
      {
         return as_config.configVO.isModal;
      }
      
      override public function get containerContent() : IManagedContent
      {
         return this._window;
      }
      
      override public function get wrapper() : IWrapper
      {
         return this._window;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         this.setWindow(IWindow(param1));
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get canMinimize() : Boolean
      {
         return this._canMinimize;
      }
      
      public function set canMinimize(param1:Boolean) : void
      {
         if(param1 != this._canMinimize)
         {
            this._canMinimize = param1;
            this.validateView();
         }
      }
      
      public function get enabledCloseBtn() : Boolean
      {
         return this._enabledCloseBtn;
      }
      
      public function set enabledCloseBtn(param1:Boolean) : void
      {
         if(param1 != this._enabledCloseBtn)
         {
            this._enabledCloseBtn = param1;
            this.validateView();
         }
      }
      
      public function get canDrag() : Boolean
      {
         return as_config.configVO.canDrag;
      }
      
      public function get canClose() : Boolean
      {
         return as_config.configVO.canClose;
      }
      
      public function get canResize() : Boolean
      {
         return this._canResize;
      }
      
      public function set canResize(param1:Boolean) : void
      {
         if(param1 != this._canResize)
         {
            this._canResize = param1;
            this.validateView();
         }
      }
      
      public function get isCentered() : Boolean
      {
         return as_config.configVO.isCentered;
      }
      
      public function set isCentered(param1:Boolean) : void
      {
      }
      
      public function get showWindowBgForm() : Boolean
      {
         return this._showWindowBgForm;
      }
      
      public function set showWindowBgForm(param1:Boolean) : void
      {
         this._showWindowBgForm = param1;
      }
      
      public function get showWindowBg() : Boolean
      {
         return this._showWindowBg;
      }
      
      public function set showWindowBg(param1:Boolean) : void
      {
         this._showWindowBg = param1;
      }
      
      public function get geometry() : IWindowGeometry
      {
         return this._geometry;
      }
      
      public function set geometry(param1:IWindowGeometry) : void
      {
         if(!this._geometry.canOverwrite())
         {
            return;
         }
         this._geometry = param1;
      }
      
      public function get isSourceTracked() : Boolean
      {
         return this._isSourceTracked;
      }
      
      public function set isSourceTracked(param1:Boolean) : void
      {
         this._isSourceTracked = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(this.canCloseFromInputDetails(_loc2_))
         {
            param1.handled = true;
            if(onTryClosingS())
            {
               this.onClosingApproved();
               onWindowCloseS();
            }
            else
            {
               this.onClosingDeclined();
            }
         }
      }
   }
}
