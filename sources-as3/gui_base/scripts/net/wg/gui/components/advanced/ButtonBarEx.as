package net.wg.gui.components.advanced
{
   import flash.events.Event;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.IGroupedControl;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.exceptions.TypeCastException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.interfaces.IUIComponent;
   import scaleform.clik.ui.InputDetails;
   
   public class ButtonBarEx extends ButtonBar implements IGroupedControl
   {
      
      public static const FORWARD_STEP_INDEX:int = 1;
      
      public static const BACKWARD_STEP_INDEX:int = -1;
      
      public static const TOOLTIP_PROP_NAME:String = "tooltip";
      
      public static const ENABLED_PROP_NAME:String = "enabled";
      
      protected static const INVALID_LAYOUT:String = "invalidLayout";
       
      
      private var _autoSelectBeforeInput:Boolean = true;
      
      private var _paddingHorizontal:Number = 10;
      
      private var _centerTabs:Boolean = false;
      
      protected var _originalContainerX:Number = 0;
      
      public function ButtonBarEx(param1:Boolean = false)
      {
         super();
         this._centerTabs = param1;
      }
      
      override public function toString() : String
      {
         return "[WG ButtonBarEx " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._originalContainerX = container.x;
      }
      
      override protected function setupRenderer(param1:Button, param2:uint) : void
      {
         var _loc3_:SoundButtonEx = null;
         super.setupRenderer(param1,param2);
         param1.autoSize = this.autoSize;
         param1.enabled = this.enabled;
         if(param1 is SoundButtonEx)
         {
            _loc3_ = param1 as SoundButtonEx;
            _loc3_.paddingHorizontal = this.paddingHorizontal;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationType.RENDERERS,InvalidationType.DATA,InvalidationType.SETTINGS,InvalidationType.SIZE,INVALID_LAYOUT);
         super.draw();
         if(_loc1_)
         {
            this.updateContainerPosition();
         }
      }
      
      protected function updateContainerPosition() : void
      {
         var _loc1_:int = this._originalContainerX;
         if(this._centerTabs)
         {
            _loc1_ = _originalWidth - container.width >> 1;
         }
         if(container.x != _loc1_)
         {
            container.x = _loc1_;
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeRenderers();
         super.onDispose();
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc4_:SoundButton = null;
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         if(_loc3_)
         {
            if(param1.hasOwnProperty(TOOLTIP_PROP_NAME) && _loc3_.hasOwnProperty(TOOLTIP_PROP_NAME))
            {
               param1[TOOLTIP_PROP_NAME] = _loc3_.tooltip;
            }
            if(_loc3_.hasOwnProperty(ENABLED_PROP_NAME))
            {
               param1.enabled = _loc3_[ENABLED_PROP_NAME];
               if(param1 is SoundButton)
               {
                  _loc4_ = param1 as SoundButton;
                  _loc4_.mouseEnabledOnDisabled = true;
               }
               else
               {
                  App.utils.asserter.assert(true,"disabled button in ButtonBarEx must be SoundButton or SoundButtonEx",TypeCastException);
               }
            }
         }
         super.populateRendererData(param1,param2);
      }
      
      override protected function updateRenderers() : void
      {
         super.updateRenderers();
         tabEnabled = _focusable && this.enabled;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function disposeRenderers() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Button = null;
         var _loc4_:IDisposable = null;
         var _loc1_:Number = _renderers.length;
         _loc2_ = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = getButtonAt(_loc2_);
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_ as IDisposable;
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
               if(container)
               {
                  if(container.contains(_loc3_))
                  {
                     container.removeChild(_loc3_);
                  }
               }
            }
            _renderers.splice(_loc2_,1);
            _loc2_--;
         }
         if(container)
         {
            this.removeChild(container);
         }
         if(_dataProvider)
         {
            _dataProvider.cleanUp();
         }
      }
      
      protected function getNextEnabledBtnIndex(param1:int, param2:int) : int
      {
         var _loc5_:Button = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc3_:int = Boolean(_renderers) ? int(_renderers.length) : int(0);
         var _loc4_:int = Math.max(0,Math.min(_loc3_ - 1,param1 + param2));
         if(param2 == FORWARD_STEP_INDEX)
         {
            _loc6_ = _loc4_;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = getButtonAt(_loc6_);
               if(_loc7_)
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
               }
               else
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
                  _loc7_ = true;
                  _loc4_ = _loc6_ - 1;
               }
               _loc6_++;
            }
         }
         else if(param2 == BACKWARD_STEP_INDEX)
         {
            _loc6_ = _loc4_;
            while(_loc6_ >= 0)
            {
               _loc5_ = getButtonAt(_loc6_);
               if(_loc7_)
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
               }
               else
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
                  _loc7_ = true;
                  _loc4_ = _loc6_ + 1;
               }
               _loc6_--;
            }
         }
         else
         {
            App.utils.asserter.assert(false,this + ". Invalid step value: " + param2);
         }
         return _loc4_;
      }
      
      override public function get data() : Object
      {
         return selectedItem;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         if(_renderers == null || _renderers.length == 0 || !super.enabled)
         {
            return super.enabled;
         }
         var _loc1_:int = _renderers.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(IUIComponent(_renderers[_loc2_]).enabled)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get autoSelectBeforeInput() : Boolean
      {
         return this._autoSelectBeforeInput;
      }
      
      public function set autoSelectBeforeInput(param1:Boolean) : void
      {
         this._autoSelectBeforeInput = param1;
      }
      
      [Inspectable(defaultValue="10",name="paddingHorizontal")]
      public function get paddingHorizontal() : Number
      {
         return this._paddingHorizontal;
      }
      
      public function set paddingHorizontal(param1:Number) : void
      {
         this._paddingHorizontal = param1;
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function get selectedRenderer() : IListItemRenderer
      {
         if(_selectedIndex >= 0)
         {
            return _renderers[_selectedIndex];
         }
         return null;
      }
      
      [Inspectable(defaultValue="true",type="Boolean")]
      public function get centerTabs() : Boolean
      {
         return this._centerTabs;
      }
      
      public function set centerTabs(param1:Boolean) : void
      {
         this._centerTabs = param1;
         invalidate(INVALID_LAYOUT);
      }
      
      public function get selectedButton() : ISoundButtonEx
      {
         if(_selectedIndex >= 0)
         {
            return _renderers[_selectedIndex];
         }
         return null;
      }
      
      public function get originalContainerX() : Number
      {
         return this._originalContainerX;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1.handled)
         {
            return;
         }
         if(this._autoSelectBeforeInput && _selectedIndex == -1)
         {
            _loc7_ = false;
            _loc8_ = _renderers != null ? int(_renderers.length) : int(-1);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               if(IUIComponent(_renderers[_loc9_]).enabled)
               {
                  selectedIndex = _loc9_;
                  _loc7_ = true;
                  break;
               }
               _loc9_++;
            }
            if(!_loc7_)
            {
               return;
            }
         }
         if(_selectedIndex == -1)
         {
            return;
         }
         var _loc2_:Button = _renderers[_selectedIndex] as Button;
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         if(!_loc4_ || !_loc2_.enabled)
         {
            return;
         }
         var _loc5_:Boolean = false;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.LEFT:
               if(_direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,BACKWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.RIGHT:
               if(_direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,FORWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.UP:
               if(_direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,BACKWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.DOWN:
               if(_direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,FORWARD_STEP_INDEX);
                  _loc5_ = true;
               }
         }
         if(_loc5_)
         {
            _loc6_ = Math.max(0,Math.min(_dataProvider.length - 1,_loc6_));
            if(_loc6_ != _selectedIndex)
            {
               selectedIndex = _loc6_;
               param1.handled = true;
            }
         }
      }
   }
}
