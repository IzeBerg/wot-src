package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.utils.IFocusHandler;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.managers.FocusHandler;
   import scaleform.clik.managers.InputDelegate;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.FocusManager;
   
   public class FocusHandlerEx implements IFocusHandler
   {
      
      private static var EXCLUDE_KEY_RANGE_MIN:uint = Keyboard.A;
      
      private static var EXCLUDE_KEY_RANGE_MAX:uint = Keyboard.Z;
       
      
      private var _focusHandler:FocusHandler = null;
      
      private var _disposed:Boolean = false;
      
      public function FocusHandlerEx()
      {
         super();
         this._focusHandler = FocusHandler.getInstance();
         this.init();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         InputDelegate.getInstance().removeEventListener(InputEvent.INPUT,this.handleInput);
         this._focusHandler.setFocus(null);
         this._focusHandler = null;
      }
      
      public function getFocus(param1:uint) : InteractiveObject
      {
         return this._focusHandler.getFocus(param1);
      }
      
      public function getModalFocus() : IView
      {
         var _loc1_:Sprite = FocusManager.getModalClip();
         if(_loc1_ != null)
         {
            App.utils.asserter.assert(_loc1_ is IManagedContent,"modal focus must be on ManagedContent only!",InfrastructureException);
            return IManagedContent(_loc1_).sourceView;
         }
         return null;
      }
      
      public function hasModalFocus(param1:IView) : Boolean
      {
         return this.getModalFocus() == param1;
      }
      
      public function input(param1:InputDetails) : void
      {
         this._focusHandler.input(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setFocus(param1:InteractiveObject, param2:uint = 0, param3:Boolean = false) : void
      {
         this.assertIfParentHasNoModalFocus(param1);
         this._focusHandler.setFocus(param1,param2,param3);
      }
      
      public function setModalFocus(param1:IManagedContent) : void
      {
         if(param1 != null)
         {
            FocusManager.setModalClip(Sprite(param1.containerContent));
         }
         else
         {
            FocusManager.setModalClip(null);
            this.setFocus(null);
         }
      }
      
      private function init() : void
      {
         InputDelegate.getInstance().addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
      }
      
      private function assertIfParentHasNoModalFocus(param1:InteractiveObject) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:IManagedContent = null;
         var _loc5_:String = null;
         var _loc2_:InteractiveObject = param1;
         if(_loc2_ != null && this.getModalFocus() != _loc2_)
         {
            App.utils.asserter.assertNotNull(this.getModalFocus(),"current modal focus " + Errors.CANT_NULL);
            _loc3_ = false;
            _loc4_ = null;
            while(_loc2_ != null)
            {
               if(_loc2_ is IAbstractWrapperView)
               {
                  _loc4_ = IAbstractWrapperView(_loc2_).wrapper;
               }
               if(_loc2_ is IWindow)
               {
                  _loc4_ = IWindow(_loc2_);
               }
               if(this.getModalFocus() == _loc2_)
               {
                  _loc3_ = true;
                  break;
               }
               _loc2_ = _loc2_.parent;
            }
            if(!_loc3_ && _loc4_ != null)
            {
               _loc3_ = FocusManager.getModalClip() == _loc4_;
            }
            _loc5_ = "one of parents of \"" + param1 + "\" must have a modal focus!";
            App.utils.asserter.assert(_loc3_,_loc5_);
         }
      }
      
      public function set stage(param1:Stage) : void
      {
         this._focusHandler.stage = param1;
      }
      
      private function handleInput(param1:InputEvent) : void
      {
         var _loc2_:Number = param1.details.code;
         if(_loc2_ < EXCLUDE_KEY_RANGE_MIN || _loc2_ > EXCLUDE_KEY_RANGE_MAX)
         {
            if(param1.details.value != InputValue.KEY_HOLD)
            {
               App.eventLogManager.logUIEventHandleInput(param1.details.value,_loc2_);
            }
         }
      }
   }
}
