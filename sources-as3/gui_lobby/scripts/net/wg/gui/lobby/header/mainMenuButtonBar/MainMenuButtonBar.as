package net.wg.gui.lobby.header.mainMenuButtonBar
{
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.MainMenuButton;
   import net.wg.gui.components.controls.MainMenuButtonSize;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.events.InputEvent;
   
   public class MainMenuButtonBar extends ButtonBar
   {
      
      private static const PREBATTLE:String = "prebattle";
      
      private static const INVALIDATE_RENDERER_SIZE:String = "invalidateRendererSize";
      
      private static const INVALIDATE_RENDERER_TEXT_SIZE:String = "invalidateRendererTextSize";
      
      private static const IMG:String = "img://";
       
      
      [Inspectable(defaultValue="0",verbose="1")]
      public var paddingTop:int = 0;
      
      [Inspectable(defaultValue="0",verbose="1")]
      public var paddingLeft:int = 0;
      
      [Inspectable(defaultValue="0",verbose="1")]
      public var paddingRight:int = 0;
      
      private var _disableNav:Boolean = false;
      
      private var _subItemSelectedIndex:int = -1;
      
      private var _componentVisible:Boolean = true;
      
      private var _rendererSize:uint = 1;
      
      public function MainMenuButtonBar()
      {
         super();
         this.selectedIndex = -1;
      }
      
      override protected function onDispose() : void
      {
         removeAllRenderers();
         super.onDispose();
      }
      
      override protected function updateRenderers() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Button = null;
         var _loc5_:Boolean = false;
         if(_renderers[0] is Class(_itemRendererClass))
         {
            _loc3_ = _dataProvider.length;
            while(_renderers.length > _loc3_)
            {
               this.disposeRenderer(_renderers.pop() as Button);
            }
         }
         else
         {
            while(container.numChildren > 0)
            {
               container.removeChildAt(0);
            }
            _renderers.length = 0;
         }
         var _loc1_:uint = _dataProvider.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc5_ = false;
            if(_loc2_ < _renderers.length)
            {
               _loc4_ = _renderers[_loc2_];
            }
            else
            {
               _loc4_ = Button(App.utils.classFactory.getComponent(_itemRenderer,Button));
               this.setupRenderer(_loc4_,_loc2_);
               _loc5_ = true;
            }
            this.populateRendererData(_loc4_,_loc2_);
            if(_autoSize == TextFieldAutoSize.NONE && _buttonWidth > 0)
            {
               _loc4_.width = Math.round(_buttonWidth);
            }
            else if(_autoSize != TextFieldAutoSize.NONE)
            {
               _loc4_.autoSize = _autoSize;
            }
            _loc4_.validateNow();
            if(_loc5_)
            {
               container.addChildAt(_loc4_,0);
               _renderers.push(_loc4_);
               MainMenuButton(_loc4_).setExternalSize(this._rendererSize);
               invalidate(INVALIDATE_RENDERER_SIZE);
            }
            _loc2_++;
         }
         this.selectedIndex = Math.min(_loc1_ - 1,_selectedIndex);
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         param1.label = itemToLabel(_dataProvider.requestItemAt(param2));
         param1.data = _dataProvider.requestItemAt(param2);
         param1.selected = param2 == selectedIndex;
         var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_dataProvider[param2]);
         param1.enabled = _loc3_.enabled && enabled;
         var _loc4_:MainMenuButton = MainMenuButton(param1);
         if(_loc3_.icon)
         {
            _loc4_.iconType = IMG + _loc3_.icon;
         }
         else
         {
            _loc4_.iconType = null;
         }
         if(_loc3_.textColor)
         {
            _loc4_.textColor = _loc3_.textColor;
         }
         if(_loc3_.textColorOver)
         {
            _loc4_.textColorOver = _loc3_.textColorOver;
         }
         if(_loc3_.tooltip)
         {
            _loc4_.tooltip = _loc3_.tooltip;
         }
         _loc4_.isTooltipSpecial = _loc3_.isTooltipSpecial;
         _loc4_.actionIconStr = _loc3_.actionIcon;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Button = null;
         if(isInvalid(InvalidationType.RENDERERS) || isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SETTINGS) || isInvalid(InvalidationType.SIZE))
         {
            removeChild(container);
            addChild(container);
            this.updateRenderers();
         }
         if(isInvalid(INVALIDATE_RENDERER_TEXT_SIZE))
         {
            for each(_loc1_ in _renderers)
            {
               MainMenuButton(_loc1_).setExternalSize(this._rendererSize);
            }
         }
         if(isInvalid(INVALIDATE_RENDERER_SIZE,InvalidationType.DATA))
         {
            this.updateLayout();
         }
      }
      
      override protected function setupRenderer(param1:Button, param2:uint) : void
      {
         super.setupRenderer(param1,param2);
         param1.addEventListener(Event.RESIZE,this.onRendererResizeHandler);
         ISoundButtonEx(param1).mouseEnabledOnDisabled = true;
      }
      
      public function deselectHeaderButton(param1:String) : void
      {
         var _loc3_:Button = null;
         var _loc2_:FindData = this.findButtonIndex(param1);
         if(_loc2_.index >= 0)
         {
            _loc3_ = _renderers[_loc2_.index] as Button;
            if(_loc3_)
            {
               _loc3_.selected = false;
            }
         }
      }
      
      public function getButtonByValue(param1:String) : MainMenuButton
      {
         var _loc2_:FindData = this.findButtonIndex(param1);
         var _loc3_:int = _loc2_.index >= 0 ? int(_loc2_.index) : (_loc2_.subIndex >= 0 ? int(_loc2_.subIndex) : int(-1));
         if(_loc3_ >= 0)
         {
            return getButtonAt(_loc3_) as MainMenuButton;
         }
         return null;
      }
      
      public function setComponentVisible(param1:Boolean) : void
      {
         if(param1 != this._componentVisible)
         {
            this._componentVisible = param1;
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      public function setCurrent(param1:String) : void
      {
         this.selectedIndex = -1;
         this.enabled = param1 != PREBATTLE;
         var _loc2_:FindData = this.findButtonIndex(param1);
         if(_loc2_.index >= 0)
         {
            this.selectedIndex = _loc2_.index;
         }
         else if(_loc2_.subIndex >= 0)
         {
            this.subItemSelectedIndex = _loc2_.subIndex;
         }
      }
      
      public function setDisableNav(param1:Boolean) : void
      {
         this._disableNav = param1;
         this.enabled = !param1;
      }
      
      public function setButtonsVisibility(param1:Boolean) : void
      {
         var _loc2_:Button = null;
         for each(_loc2_ in _renderers)
         {
            if(_loc2_.visible != param1)
            {
               _loc2_.visible = param1;
            }
         }
      }
      
      protected function disposeRenderer(param1:Button) : void
      {
         if(container.contains(param1))
         {
            container.removeChild(param1);
         }
         param1.removeEventListener(Event.RESIZE,this.onRendererResizeHandler);
         param1.dispose();
      }
      
      protected function updateLayout() : void
      {
         var _loc1_:Button = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = this.paddingRight + spacing;
         var _loc5_:Number = this.paddingLeft;
         var _loc6_:int = _renderers.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc1_ = _renderers[_loc7_];
            _loc4_ = _loc1_.width + spacing;
            _loc3_ += _loc4_;
            _loc7_++;
         }
         if(_loc2_)
         {
            _renderers.length = _loc2_;
         }
         switch(_autoSize)
         {
            case TextFieldAutoSize.NONE:
            case TextFieldAutoSize.LEFT:
               _loc5_ += 0;
               break;
            case TextFieldAutoSize.CENTER:
               _loc5_ += -(_loc3_ >> 1);
               break;
            case TextFieldAutoSize.RIGHT:
               _loc5_ += -_loc3_;
         }
         for each(_loc1_ in _renderers)
         {
            _loc1_.x = _loc5_ | 0;
            _loc1_.y = this.paddingTop ^ 0;
            _loc5_ += _loc1_.width + spacing;
         }
         if(container.hasEventListener(Event.RESIZE))
         {
            container.dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function updateRenderersSize(param1:uint) : void
      {
         if(this._rendererSize == param1)
         {
            return;
         }
         this._rendererSize = param1;
         invalidate(INVALIDATE_RENDERER_TEXT_SIZE);
      }
      
      private function findButtonIndex(param1:String) : FindData
      {
         var _loc3_:HangarMenuTabItemVO = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc7_:uint = 0;
         var _loc2_:int = _dataProvider.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = HangarMenuTabItemVO(_dataProvider[_loc6_]);
            if(param1 == _loc3_.value)
            {
               return new FindData(_loc6_);
            }
            if(_loc3_.subValues != null)
            {
               _loc5_ = _loc3_.subValues;
               _loc4_ = _loc5_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  if(param1 == _loc5_[_loc7_])
                  {
                     return new FindData(-1,_loc6_);
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return new FindData();
      }
      
      private function updateSubItem(param1:Number, param2:String) : void
      {
         if(param1 >= 0)
         {
            MainMenuButton(_renderers[this.subItemSelectedIndex]).setExternalState(param2);
            if(param2 == Values.EMPTY_STR)
            {
               this._subItemSelectedIndex = -1;
            }
         }
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         super.selectedIndex = param1;
         this.updateSubItem(this.subItemSelectedIndex,Values.EMPTY_STR);
      }
      
      public function set isSmallWidth(param1:Boolean) : void
      {
         var _loc2_:uint = !!param1 ? uint(MainMenuButtonSize.SMALL) : uint(MainMenuButtonSize.REGULAR);
         this.updateRenderersSize(_loc2_);
      }
      
      public function get subItemSelectedIndex() : int
      {
         return this._subItemSelectedIndex;
      }
      
      public function set subItemSelectedIndex(param1:int) : void
      {
         this.updateSubItem(this._subItemSelectedIndex,Values.EMPTY_STR);
         this._subItemSelectedIndex = param1;
         this.updateSubItem(this._subItemSelectedIndex,MainMenuButton.SUB_SELECTED);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(!this._disableNav)
         {
            super.handleInput(param1);
         }
      }
      
      private function onRendererResizeHandler(param1:Event) : void
      {
         invalidate(INVALIDATE_RENDERER_SIZE);
      }
   }
}

class FindData
{
    
   
   private var _index:int = -1;
   
   private var _subIndex:int = -1;
   
   function FindData(param1:int = -1, param2:int = -1)
   {
      super();
      this._index = param1;
      this._subIndex = param2;
   }
   
   public function get index() : int
   {
      return this._index;
   }
   
   public function get subIndex() : int
   {
      return this._subIndex;
   }
}
