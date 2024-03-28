package net.wg.gui.components.containers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Loader;
   import flash.geom.Rectangle;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.wulf.IBaseContainerWrapper;
   import net.wg.infrastructure.wulf.IViewWrapper;
   import scaleform.clik.motion.Tween;
   
   public class BaseContainerWrapper extends UIComponentEx implements IBaseContainerWrapper
   {
      
      protected static const FADE_IN_TIME:int = 300;
      
      protected static const FADE_OUT_TIME:int = 150;
       
      
      private var _loadViewVO:LoadViewVO = null;
      
      private var _wrapper:IViewWrapper = null;
      
      private var _tween:Tween = null;
      
      private var _tweenCompleteFunction:Function = null;
      
      public function BaseContainerWrapper(param1:Boolean)
      {
         super();
         name = !!param1 ? "Unbound window" : "Wulf window";
         var _loc2_:Class = !!param1 ? UssWrapper : ViewWrapper;
         this._wrapper = new _loc2_();
         this._wrapper.visible = false;
         addChild(this._wrapper as DisplayObject);
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         App.utils.asserter.assert(!this._wrapper.focused,this._wrapper.name + " has focus on dispose!");
         App.utils.asserter.assert(!hasFocus,this._wrapper.name + " hasFocus on dispose!");
         removeChild(this._wrapper as DisplayObject);
         this._wrapper.dispose();
         this._wrapper = null;
         if(this._loadViewVO != null)
         {
            this._loadViewVO.dispose();
            this._loadViewVO = null;
         }
         super.onDispose();
      }
      
      public function as_dispose() : void
      {
         dispose();
      }
      
      public function as_populate() : void
      {
      }
      
      public function getSubContainers() : Array
      {
         return null;
      }
      
      public function leaveModalFocus() : void
      {
      }
      
      public function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         if(this._wrapper.visible)
         {
            this.clearTween();
            this._tweenCompleteFunction = param2;
            this._tween = new Tween(FADE_OUT_TIME,this,{"alpha":0},{
               "paused":false,
               "onComplete":this.onHidingComplete
            });
            return true;
         }
         return false;
      }
      
      public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         if(this._wrapper.visible)
         {
            this.alpha = 0;
            this.clearTween();
            this._tweenCompleteFunction = param2;
            this._tween = new Tween(FADE_IN_TIME,this,{"alpha":1},{
               "paused":false,
               "onComplete":this.onShowingComplete
            });
            return true;
         }
         this.alpha = 1;
         return false;
      }
      
      public function setAsConfig(param1:Object) : void
      {
         this.setNewConfig(new LoadViewVO(param1));
      }
      
      public function setModalFocus() : void
      {
         if(!_baseDisposed && this.focusable)
         {
            if(!this.isFocused() && !this.trySetFocus(this))
            {
               App.utils.focusHandler.setFocus(this);
            }
         }
         App.utils.focusHandler.setModalFocus(this);
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
      }
      
      public function stopTransition() : void
      {
         this.clearTween();
         this.alpha = 1;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._wrapper.updateParentSize(param1,param2);
      }
      
      private function onHidingComplete(param1:Tween) : void
      {
         this._wrapper.onHidden();
         if(this._tweenCompleteFunction != null)
         {
            this._tweenCompleteFunction(param1);
         }
         this.clearTween();
      }
      
      private function onShowingComplete(param1:Tween) : void
      {
         this._wrapper.onShown();
         if(this._tweenCompleteFunction != null)
         {
            this._tweenCompleteFunction(param1);
         }
         this.clearTween();
      }
      
      private function clearTween() : void
      {
         this._tweenCompleteFunction = null;
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function isFocused() : Boolean
      {
         var _loc1_:InteractiveObject = stage.focus;
         var _loc2_:DisplayObject = _loc1_;
         while(_loc2_ != null && _loc2_ != root)
         {
            if(_loc2_ == this)
            {
               App.utils.focusHandler.setFocus(_loc1_);
               return true;
            }
            _loc2_ = _loc2_.parent;
         }
         return false;
      }
      
      private function trySetFocus(param1:DisplayObjectContainer) : Boolean
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc2_:int = 0;
         while(_loc2_ != param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is DisplayObjectContainer)
            {
               _loc4_ = DisplayObjectContainer(_loc3_);
               if(_loc4_.tabEnabled)
               {
                  App.utils.focusHandler.setFocus(_loc4_);
                  return true;
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ != param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is DisplayObjectContainer)
            {
               _loc4_ = DisplayObjectContainer(_loc3_);
               if(this.trySetFocus(_loc4_))
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function setNewConfig(param1:LoadViewVO) : void
      {
         this._loadViewVO = param1;
         this._wrapper.tutorialId = this._loadViewVO.viewTutorialId;
         this._wrapper.name = this._loadViewVO.name;
      }
      
      override public function get focusable() : Boolean
      {
         return this.visible;
      }
      
      override public function get height() : Number
      {
         return this._wrapper.height;
      }
      
      override public function get width() : Number
      {
         return this._wrapper.width;
      }
      
      public function get as_config() : LoadViewVO
      {
         return this._loadViewVO;
      }
      
      public function set as_config(param1:LoadViewVO) : void
      {
         this.setNewConfig(param1);
      }
      
      public function get loader() : Loader
      {
         return null;
      }
      
      public function set loader(param1:Loader) : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return false;
      }
      
      public function get isModal() : Boolean
      {
         return false;
      }
      
      public function get modalAlpha() : Number
      {
         return 0;
      }
      
      public function get sourceView() : IView
      {
         return this;
      }
      
      public function get containerContent() : IManagedContent
      {
         return this;
      }
      
      public function get hitRect() : Rectangle
      {
         return this._wrapper.hitRect;
      }
      
      public function get tutorialId() : String
      {
         return this._wrapper.tutorialId;
      }
      
      public function set tutorialId(param1:String) : void
      {
         this._loadViewVO.viewTutorialId = param1;
         this._wrapper.tutorialId = param1;
      }
      
      public function get isResizable() : Boolean
      {
         return this._loadViewVO.configVO.isResizable;
      }
      
      public function get wrapper() : IViewWrapper
      {
         return this._wrapper;
      }
      
      public function get isInTransition() : Boolean
      {
         return this._tween != null;
      }
   }
}
