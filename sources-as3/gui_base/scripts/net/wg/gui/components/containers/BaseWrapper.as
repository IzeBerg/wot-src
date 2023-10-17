package net.wg.gui.components.containers
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.gui.tutorial.components.TutorialHintZone;
   import net.wg.infrastructure.wulf.IBaseContainerWrapper;
   import net.wg.infrastructure.wulf.IViewWrapper;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BaseWrapper extends Sprite implements IViewWrapper
   {
      
      private static const SHOWN_EVENT:String = "onShownEvent";
      
      private static const HIDDEN_EVENT:String = "onHiddenEvent";
      
      private static const FOCUS_IN_EVENT:String = "onFocusInEvent";
      
      private static const FOCUS_OUT_EVENT:String = "onFocusOutEvent";
      
      private static const UPDATE_CONTAINER_EVENT:String = "updateContainerSize";
       
      
      private var _focused:Boolean = false;
      
      private var _containerWrapper:IBaseContainerWrapper;
      
      private var _disposed:Boolean = false;
      
      private var _tutorialId:String = "";
      
      private var _tutorialHintZones:Dictionary;
      
      public function BaseWrapper()
      {
         this._tutorialHintZones = new Dictionary();
         super();
         addEventListener(FocusEvent.FOCUS_IN,this.onFocusHandler);
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusHandler);
         visible = false;
      }
      
      public function caretPosChanged(param1:Number, param2:Number) : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:TutorialHintZone = null;
         App.utils.asserter.assert(!this._focused,name + " is focused on dispose!");
         removeEventListener(FocusEvent.FOCUS_IN,this.onFocusHandler);
         removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusHandler);
         for each(_loc1_ in this._tutorialHintZones)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._tutorialHintZones);
         this._tutorialHintZones = null;
         this._containerWrapper = null;
         this._disposed = true;
      }
      
      public function freezeUntilResize() : void
      {
      }
      
      public function getContainerWrapper() : IBaseContainerWrapper
      {
         return this._containerWrapper;
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
      
      public function hide(param1:Boolean) : void
      {
         if(!visible)
         {
            DebugUtils.LOG_ERROR("hide() " + name + " is already invisible");
            return;
         }
         if(!param1 || !this._containerWrapper || !this._containerWrapper.playHideTween(this,null))
         {
            if(this._containerWrapper && this._containerWrapper.isInTransition)
            {
               this._containerWrapper.stopTransition();
            }
            this.onHidden();
         }
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         var _loc3_:DisplayObject = this;
         if(hitArea)
         {
            _loc3_ = hitArea;
         }
         return _loc3_.hitTestPoint(param1,param2);
      }
      
      public function inputEnded() : void
      {
      }
      
      public function inputStarted(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function onHidden() : void
      {
         visible = false;
         if(this._containerWrapper)
         {
            this._containerWrapper.visible = false;
            if(this._focused)
            {
               this._focused = false;
               dispatchEvent(new Event(FOCUS_OUT_EVENT));
            }
         }
         App.utils.asserter.assert(!this._focused,name + " is focused on hide!");
         dispatchEvent(new Event(HIDDEN_EVENT));
      }
      
      public function onShown() : void
      {
         dispatchEvent(new Event(SHOWN_EVENT));
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
      
      public function setContainerWrapper(param1:IBaseContainerWrapper) : void
      {
         this._containerWrapper = param1;
      }
      
      public function setCursor(param1:String) : void
      {
      }
      
      public function setHitAreaPaddings(param1:int, param2:int, param3:int, param4:int) : void
      {
      }
      
      public function setScale(param1:Number) : void
      {
      }
      
      public function setSize(param1:uint, param2:uint) : void
      {
      }
      
      public function setTexture(param1:BitmapData) : void
      {
      }
      
      public function show(param1:Boolean) : void
      {
         if(visible && !(this._containerWrapper && this._containerWrapper.isInTransition))
         {
            return;
         }
         if(this._containerWrapper)
         {
            this._containerWrapper.visible = true;
         }
         visible = true;
         if(!param1 || !this._containerWrapper || !this._containerWrapper.playShowTween(this,null))
         {
            if(this._containerWrapper && this._containerWrapper.isInTransition)
            {
               this._containerWrapper.stopTransition();
            }
            this.onShown();
         }
      }
      
      public function updateParentSize(param1:Number, param2:Number) : void
      {
         dispatchEvent(new Event(UPDATE_CONTAINER_EVENT));
      }
      
      protected function focusChanged(param1:Boolean) : void
      {
      }
      
      private function testIsFocused() : Boolean
      {
         if(!App.instance)
         {
            return false;
         }
         var _loc1_:DisplayObject = App.instance.stage.focus;
         while(_loc1_ != null && _loc1_ != stage)
         {
            if(_loc1_ == this)
            {
               return true;
            }
            _loc1_ = _loc1_.parent;
         }
         return false;
      }
      
      public function get hitRect() : Rectangle
      {
         return new Rectangle();
      }
      
      public function get tutorialId() : String
      {
         return this._tutorialId;
      }
      
      public function set tutorialId(param1:String) : void
      {
         this._tutorialId = param1;
         if(StringUtils.isNotEmpty(this._tutorialId))
         {
            App.tutorialMgr.setViewForTutorialId(this,this._tutorialId);
         }
      }
      
      public function get isResizable() : Boolean
      {
         return true;
      }
      
      public function get drawDebug() : Boolean
      {
         return false;
      }
      
      public function set drawDebug(param1:Boolean) : void
      {
      }
      
      public function get focused() : Boolean
      {
         return this._focused;
      }
      
      private function onFocusHandler(param1:FocusEvent) : void
      {
         var _loc2_:Boolean = this.testIsFocused();
         if(this._focused == _loc2_)
         {
            return;
         }
         this._focused = _loc2_;
         this.focusChanged(this._focused);
         dispatchEvent(new Event(!!this._focused ? FOCUS_IN_EVENT : FOCUS_OUT_EVENT));
      }
   }
}
