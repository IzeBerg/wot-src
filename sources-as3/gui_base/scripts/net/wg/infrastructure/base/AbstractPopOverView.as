package net.wg.infrastructure.base
{
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.infrastructure.base.interfaces.IAbstractPopOverView;
   import net.wg.infrastructure.base.meta.impl.PopOverViewMeta;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class AbstractPopOverView extends PopOverViewMeta implements IAbstractPopOverView
   {
      
      private static const ARROW_DIRECTION_INV:String = "arrowDirectionInvalid";
      
      private static const ARROW_POSITION_INV:String = "arrowPositionInvalid";
       
      
      private var _arrowDirection:uint = 0;
      
      private var _arrowPosition:int = 0;
      
      public function AbstractPopOverView()
      {
         super();
      }
      
      private function hidePopoverHandler(param1:ComponentEvent) : void
      {
         param1.stopImmediatePropagation();
         App.popoverMgr.hide();
      }
      
      override protected function draw() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         var _loc1_:IWrapper = wrapper;
         if(isInvalid(InvalidationType.SIZE) && _loc1_)
         {
            PopOver(wrapper).invalidateLayout();
         }
         if(isInvalid(ARROW_DIRECTION_INV) && _loc1_)
         {
            PopOver(_loc1_).arrowDirection = this._arrowDirection;
            invalidate(ARROW_DIRECTION_INV);
         }
         if(isInvalid(ARROW_POSITION_INV) && _loc1_)
         {
            PopOver(_loc1_).arrowPosition = this._arrowPosition;
         }
      }
      
      public function get arrowDirection() : uint
      {
         return this._arrowDirection;
      }
      
      public function set arrowDirection(param1:uint) : void
      {
         if(this._arrowDirection != param1)
         {
            this._arrowDirection = param1;
            invalidate(ARROW_DIRECTION_INV);
         }
      }
      
      public function get arrowPosition() : int
      {
         return this._arrowPosition;
      }
      
      public function set arrowPosition(param1:int) : void
      {
         this._arrowPosition = param1;
         invalidate(ARROW_POSITION_INV);
      }
      
      public function as_setArrowDirection(param1:Number) : void
      {
         this.arrowDirection = param1;
      }
      
      public function as_setArrowPosition(param1:Number) : void
      {
         this.arrowPosition = param1;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         if(param1 != null && !hasEventListener(ComponentEvent.HIDE))
         {
            param1.addEventListener(ComponentEvent.HIDE,this.hidePopoverHandler,false,0,true);
         }
         invalidate(ARROW_DIRECTION_INV);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            App.popoverMgr.hide();
         }
      }
      
      public function getWrapperLinkage() : String
      {
         return Linkages.SMART_POPOVER;
      }
      
      override public function get containerContent() : IManagedContent
      {
         return wrapper;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ComponentEvent.HIDE,this.hidePopoverHandler);
         super.onDispose();
      }
   }
}
