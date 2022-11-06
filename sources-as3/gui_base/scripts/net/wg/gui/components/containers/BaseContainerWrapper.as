package net.wg.gui.components.containers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.gui.tutorial.components.TutorialHintZone;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IContainerWrapper;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IContainerManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.MouseEventEx;
   
   public class BaseContainerWrapper extends UIComponentEx implements IContainerWrapper
   {
       
      
      private var _loadViewVO:LoadViewVO = null;
      
      private var _isFocused:Boolean = true;
      
      private var _allowOnlyLMBClick:Boolean = false;
      
      private var _tutorialHintZones:Dictionary;
      
      public function BaseContainerWrapper()
      {
         this._tutorialHintZones = new Dictionary();
         super();
      }
      
      public function set allowOnlyLMBClick(param1:Boolean) : void
      {
         this._allowOnlyLMBClick = param1;
      }
      
      public function getTutorialHintZone(param1:String) : DisplayObject
      {
         var _loc2_:TutorialHintZone = null;
         if(!(param1 in this._tutorialHintZones))
         {
            _loc2_ = new TutorialHintZone(this);
            _loc2_.name = param1;
            addChild(_loc2_);
            this._tutorialHintZones[param1] = _loc2_;
         }
         return this._tutorialHintZones[param1];
      }
      
      public function removeTutorialHintZone(param1:String) : void
      {
         var _loc2_:TutorialHintZone = null;
         if(param1 in this._tutorialHintZones)
         {
            _loc2_ = this._tutorialHintZones[param1];
            removeChild(_loc2_);
            _loc2_.dispose();
            delete this._tutorialHintZones[param1];
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler);
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:TutorialHintZone = null;
         if(this._loadViewVO != null)
         {
            this._loadViewVO.dispose();
            this._loadViewVO = null;
         }
         removeEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler);
         removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         focusable = false;
         var _loc1_:IContainerManager = App.containerMgr;
         if(this._isFocused && _loc1_)
         {
            _loc1_.updateFocus();
         }
         for each(_loc2_ in this._tutorialHintZones)
         {
            removeChild(_loc2_);
            _loc2_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._tutorialHintZones);
         this._tutorialHintZones = null;
         super.onDispose();
      }
      
      public function as_dispose() : void
      {
         dispose();
      }
      
      public function as_populate() : void
      {
      }
      
      public function dispatchEventToObjet(param1:DisplayObject, param2:String) : void
      {
         if(param1)
         {
            param1.dispatchEvent(new Event(param2));
         }
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
         return false;
      }
      
      public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public function setModalFocus() : void
      {
         if(!_baseDisposed && focusable)
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
      
      public function updateStage(param1:Number, param2:Number) : void
      {
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
      
      public function get as_config() : LoadViewVO
      {
         return this._loadViewVO;
      }
      
      public function set as_config(param1:LoadViewVO) : void
      {
         this.setNewConfig(param1);
      }
      
      public function setAsConfig(param1:Object) : void
      {
         this.setNewConfig(new LoadViewVO(param1));
      }
      
      private function setNewConfig(param1:LoadViewVO) : void
      {
         this._loadViewVO = param1;
         if(StringUtils.isNotEmpty(param1.viewTutorialId))
         {
            App.tutorialMgr.setViewForTutorialId(this,param1.viewTutorialId);
         }
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
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._allowOnlyLMBClick && MouseEventEx(param1).buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(App && !App.stage.focus)
         {
            this.setModalFocus();
         }
      }
      
      private function onFocusOutHandler(param1:FocusEvent) : void
      {
         this._isFocused = false;
      }
      
      private function onFocusInHandler(param1:FocusEvent) : void
      {
         this._isFocused = true;
      }
   }
}
