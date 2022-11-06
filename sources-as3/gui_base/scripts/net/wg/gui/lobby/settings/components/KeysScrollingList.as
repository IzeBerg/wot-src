package net.wg.gui.lobby.settings.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.ScrollingListPx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.MouseEventEx;
   
   public class KeysScrollingList extends ScrollingListPx
   {
       
      
      public function KeysScrollingList()
      {
         super();
         scrollPosition = 0;
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         var _loc2_:Function = super.getChildByName;
         if(_loc2_(param1))
         {
            return _loc2_(param1);
         }
         if(container)
         {
            return container.getChildByName(param1);
         }
         return null;
      }
      
      override public function scrollToIndex(param1:uint) : void
      {
         if(this.isSelected())
         {
            return;
         }
         super.scrollToIndex(param1);
      }
      
      override public function toString() : String
      {
         return "[Wargaming KeysScrollingList " + name + "]";
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            createScrollBar();
            invalidate(SCROLL_POSITION_INV);
         }
         if(isInvalid(InvalidationType.SIZE,SCROLL_POSITION_INV))
         {
            drawScrollBar();
            _loc1_ = maskObject.graphics;
            _loc1_.beginFill(0,1);
            _loc1_.drawRect(0,0,_width,_height);
            _loc1_.endFill();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
         }
         if(!_usingExternalRenderers && isInvalid(InvalidationType.RENDERERS,InvalidationType.DATA))
         {
            if(_renderers == null)
            {
               _renderers = new Vector.<IListItemRenderer>();
               if(_dataProvider)
               {
                  this.drawRenderers(_dataProvider.length);
               }
            }
            else
            {
               this.updateDataProvider();
            }
         }
         if(isInvalid(SCROLL_UPDATE_INV))
         {
            applyScrollBarUpdating();
         }
      }
      
      override protected function createRendererByDataIndex(param1:int) : void
      {
         var _loc2_:IListItemRenderer = this.createRenderer(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:DisplayObject = _loc2_ as DisplayObject;
         App.utils.asserter.assertNotNull(_loc3_,"renderer must be DisplayObject");
         container.addChild(_loc3_);
         _renderers.push(_loc2_);
         var _loc4_:Object = _dataProvider[param1];
         _loc2_.name = _loc4_.id;
         _loc2_.setListData(new ListData(param1,itemToLabel(_loc4_),false));
         _loc2_.setData(_loc4_);
         _loc2_.owner = this;
         _loc2_.validateNow();
         totalHeight += _loc4_.rendererYOffset;
         _loc2_.y = totalHeight;
         totalHeight += Math.round(_loc2_.height);
      }
      
      override protected function createRenderer(param1:uint) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = super.createRenderer(param1);
         if(_loc2_)
         {
            this.setupRenderer(_loc2_);
         }
         return _loc2_;
      }
      
      override protected function drawRenderers(param1:Number) : void
      {
         if(_itemRenderer == null)
         {
            return;
         }
         totalHeight = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.createRendererByDataIndex(_loc2_);
            _loc2_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function setupRenderer(param1:IListItemRenderer) : void
      {
         param1.owner = this;
         param1.focusTarget = this;
         param1.tabEnabled = false;
         param1.doubleClickEnabled = true;
         param1.addEventListener(ButtonEvent.PRESS,this.onPressHandler,false,0,true);
         param1.addEventListener(ButtonEvent.CLICK,this.onClickHandler,false,0,true);
         param1.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
         param1.addEventListener(KeyInputEvents.CHANGE,this.onChangeHandler,false,0,true);
         if(_usingExternalRenderers)
         {
            param1.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
         }
      }
      
      override protected function cleanUpRenderer(param1:IListItemRenderer) : void
      {
         param1.owner = null;
         param1.focusTarget = null;
         param1.doubleClickEnabled = false;
         param1.removeEventListener(ButtonEvent.PRESS,this.onPressHandler);
         param1.removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         param1.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClickHandler);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         param1.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         param1.removeEventListener(KeyInputEvents.CHANGE,this.onChangeHandler);
      }
      
      override protected function scrollList(param1:int) : void
      {
         if(this.isSelected())
         {
            return;
         }
         super.scrollList(param1);
      }
      
      public function keysWasChanged() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = dataProvider.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(!dataProvider[_loc3_].header && dataProvider[_loc3_].key != dataProvider[_loc3_].keyDefault)
            {
               _loc1_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function restoreDefault() : void
      {
         var _loc3_:ListEventEx = null;
         var _loc1_:uint = dataProvider.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            if(!dataProvider[_loc2_].header && dataProvider[_loc2_].key != dataProvider[_loc2_].keyDefault)
            {
               dataProvider[_loc2_].key = dataProvider[_loc2_].keyDefault;
               _loc3_ = new ListEventEx(ListEventEx.ITEM_TEXT_CHANGE,false,true,0,0,0,null,dataProvider[_loc2_],dataProvider[_loc2_].key);
               dispatchEvent(_loc3_);
            }
            _loc2_++;
         }
         dataProvider.invalidate();
      }
      
      public function updateDataProvider() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Object = null;
         if(_dataProvider && _renderers)
         {
            _loc1_ = _renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = getRendererAt(_loc2_);
               _loc4_ = _dataProvider[_loc2_];
               _loc3_.setListData(new ListData(_loc2_,itemToLabel(_loc4_),false));
               _loc3_.setData(_loc4_);
               _loc2_++;
            }
         }
      }
      
      private function isSelected() : Boolean
      {
         var _loc3_:KeysItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = getRendererAt(_loc2_) as KeysItemRenderer;
            App.utils.asserter.assertNotNull(_loc3_,"getRendererAt(i) must be KeysItemRenderer");
            if(_loc3_.isSelected())
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override protected function dispatchItemEvent(param1:Event) : Boolean
      {
         var _loc2_:String = null;
         switch(param1.type)
         {
            case ButtonEvent.PRESS:
               _loc2_ = ListEventEx.ITEM_PRESS;
               break;
            case ButtonEvent.CLICK:
               _loc2_ = ListEventEx.ITEM_CLICK;
               break;
            case MouseEvent.ROLL_OVER:
               _loc2_ = ListEventEx.ITEM_ROLL_OVER;
               break;
            case MouseEvent.ROLL_OUT:
               _loc2_ = ListEventEx.ITEM_ROLL_OUT;
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc2_ = ListEventEx.ITEM_DOUBLE_CLICK;
               break;
            case KeyInputEvents.CHANGE:
               _loc2_ = ListEventEx.ITEM_TEXT_CHANGE;
               break;
            default:
               return true;
         }
         var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
         App.utils.asserter.assertNotNull(_loc3_,"event.currentTarget must be IListItemRenderer");
         var _loc4_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc4_ = ButtonEvent(param1).controllerIdx;
         }
         else if(param1 is KeyInputEvents)
         {
            _loc4_ = KeyInputEvents(param1).keyCode;
         }
         else if(param1 is MouseEventEx)
         {
            _loc4_ = MouseEventEx(param1).mouseIdx;
         }
         var _loc5_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc5_ = ButtonEvent(param1).buttonIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc5_ = MouseEventEx(param1).buttonIdx;
         }
         var _loc6_:Boolean = false;
         if(param1 is ButtonEvent)
         {
            _loc6_ = ButtonEvent(param1).isKeyboard;
         }
         var _loc7_:ListEventEx = new ListEventEx(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,dataProvider[_loc3_.index],_loc4_,_loc5_,_loc6_);
         if(_loc2_ != ListEventEx.ITEM_TEXT_CHANGE)
         {
            callLogEvent(_loc7_,_loc3_.index);
         }
         return dispatchEvent(_loc7_);
      }
      
      private function onPressHandler(param1:ButtonEvent) : void
      {
         this.dispatchItemEvent(param1);
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         handleItemClick(param1);
      }
      
      private function onDoubleClickHandler(param1:MouseEvent) : void
      {
         this.dispatchItemEvent(param1);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.dispatchItemEvent(param1);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.dispatchItemEvent(param1);
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         handleMouseWheel(param1);
      }
      
      private function onChangeHandler(param1:KeyInputEvents) : void
      {
         this.dispatchItemEvent(param1);
      }
   }
}
