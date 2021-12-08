package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonBarEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.ui.InputDetails;
   
   public class ButtonBar extends UIComponent implements ITutorialCustomComponent
   {
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
       
      
      protected var _autoSize:String = "none";
      
      protected var _buttonWidth:Number = 0;
      
      protected var _dataProvider:IDataProvider;
      
      protected var _direction:String = "horizontal";
      
      protected var _group:ButtonGroup;
      
      protected var _itemRenderer:String = "Button";
      
      protected var _itemRendererClass:Class;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _renderers:Array;
      
      protected var _spacing:Number = 0;
      
      protected var _selectedIndex:Number = -1;
      
      private var _enableOversize:Boolean = false;
      
      public var container:MovieClip;
      
      public function ButtonBar()
      {
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.dataProvider = new DataProvider();
         this._renderers = [];
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
            this._dataProvider = null;
         }
         if(this._group)
         {
            this._group.removeEventListener(ButtonEvent.CLICK,this.handleButtonGroupChange,false);
            this._group.dispose();
            this._group = null;
         }
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         if(this.container)
         {
            removeChild(this.container);
         }
         this.container = null;
         super.onDispose();
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         var _loc2_:Number = 0;
         while(_loc2_ < this._renderers.length)
         {
            if(this._itemRendererClass)
            {
               (this._renderers[_loc2_] as this._itemRendererClass).enabled = param1;
            }
            else
            {
               (this._renderers[_loc2_] as UIComponent).enabled = param1;
            }
            _loc2_++;
         }
      }
      
      [Inspectable(defaultValue="true")]
      override public function get focusable() : Boolean
      {
         return _focusable;
      }
      
      override public function set focusable(param1:Boolean) : void
      {
         super.focusable = param1;
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
         }
         this._dataProvider = param1;
         if(this._dataProvider == null)
         {
            return;
         }
         this._dataProvider.addEventListener(Event.CHANGE,this.handleDataChange,false,0,true);
         invalidateData();
      }
      
      [Inspectable(defaultValue="Button",name="itemRenderer")]
      public function set itemRendererName(param1:String) : void
      {
         var classRef:Class = null;
         var value:String = param1;
         if(this._itemRenderer == value)
         {
            return;
         }
         if(_inspector && value == "Button" || value == "")
         {
            return;
         }
         try
         {
            classRef = App.utils.classFactory.getClass(value,loaderInfo);
         }
         catch(error:*)
         {
            throw new Error("The class " + value + " cannot be found in your library. Please ensure it exists.");
         }
         if(classRef != null)
         {
            this._itemRenderer = value;
            this._itemRendererClass = classRef;
            invalidate();
         }
      }
      
      [Inspectable(defaultValue="0")]
      public function get spacing() : Number
      {
         return this._spacing;
      }
      
      public function set spacing(param1:Number) : void
      {
         this._spacing = param1;
         this.invalidateSettings();
      }
      
      [Inspectable(defaultValue="horizontal",type="list",enumeration="horizontal,vertical")]
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
         this.invalidateSettings();
      }
      
      [Inspectable(defaultValue="none",type="String",enumeration="none,left,center,right")]
      public function get autoSize() : String
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         if(param1 == this._autoSize)
         {
            return;
         }
         this._autoSize = param1;
         var _loc2_:Number = 0;
         while(_loc2_ < this._renderers.length)
         {
            (this._renderers[_loc2_] as this._itemRendererClass).autoSize = this._autoSize;
            _loc2_++;
         }
         this.invalidateSettings();
      }
      
      [Inspectable(defaultValue="0")]
      public function get buttonWidth() : Number
      {
         return this._buttonWidth;
      }
      
      public function set buttonWidth(param1:Number) : void
      {
         this._buttonWidth = param1;
         invalidate();
      }
      
      [Inspectable(defaultValue="false")]
      public function get enableOversize() : Boolean
      {
         return this._enableOversize;
      }
      
      public function set enableOversize(param1:Boolean) : void
      {
         this._enableOversize = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc3_:Button = null;
         if(param1 == this._selectedIndex)
         {
            return;
         }
         var _loc2_:int = this._selectedIndex;
         if(_loc2_ >= 0)
         {
            _loc3_ = this._renderers[_loc2_] as Button;
            if(_loc3_)
            {
               _loc3_.selected = false;
            }
         }
         this._selectedIndex = param1;
         if(this._selectedIndex >= 0)
         {
            _loc3_ = this._renderers[this._selectedIndex] as Button;
            if(_loc3_)
            {
               _loc3_.selected = true;
            }
            dispatchEventAndSound(new IndexEvent(IndexEvent.INDEX_CHANGE,true,true,this._selectedIndex,_loc2_,this._dataProvider[this._selectedIndex]));
         }
      }
      
      public function get selectedItem() : Object
      {
         return Boolean(this._dataProvider) ? this._dataProvider.requestItemAt(this._selectedIndex) : null;
      }
      
      public function get data() : Object
      {
         return Boolean(this.selectedItem) ? this.selectedItem.data : null;
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         this._labelField = param1;
         invalidateData();
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         this._labelFunction = param1;
         invalidateData();
      }
      
      public function invalidateSettings() : void
      {
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function itemToLabel(param1:Object) : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(this._labelFunction != null)
         {
            return this._labelFunction(param1);
         }
         if(param1 is String)
         {
            return param1 as String;
         }
         if(this._labelField != null && param1[this._labelField] != null)
         {
            return param1[this._labelField];
         }
         return param1.toString();
      }
      
      public function getButtonAt(param1:int) : Button
      {
         if(param1 >= 0 && param1 < this._renderers.length)
         {
            return this._renderers[param1];
         }
         return null;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc6_:Number = NaN;
         if(param1.handled)
         {
            return;
         }
         var _loc2_:Button = this._renderers[this._selectedIndex] as Button;
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
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:Boolean = false;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.LEFT:
               if(this._direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this._selectedIndex - 1;
                  _loc5_ = true;
               }
               break;
            case NavigationCode.RIGHT:
               if(this._direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this._selectedIndex + 1;
                  _loc5_ = true;
               }
               break;
            case NavigationCode.UP:
               if(this._direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this._selectedIndex - 1;
                  _loc5_ = true;
               }
               break;
            case NavigationCode.DOWN:
               if(this._direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this._selectedIndex + 1;
                  _loc5_ = true;
               }
         }
         if(_loc5_)
         {
            _loc6_ = Math.max(0,Math.min(this._dataProvider.length - 1,_loc6_));
            if(_loc6_ != this._selectedIndex)
            {
               this.selectedIndex = _loc6_;
               param1.handled = true;
            }
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK ButtonBar " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tabEnabled = _focusable && this.enabled;
         if(this._group == null)
         {
            this._group = new ButtonGroup(name + "Group",this);
         }
         this._group.addEventListener(ButtonEvent.CLICK,this.handleButtonGroupChange,false,0,true);
         if(this.container == null)
         {
            this.container = new MovieClip();
            this.container.name = "container";
            this.container.mouseEnabled = false;
            addChild(this.container);
         }
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.RENDERERS,InvalidationType.DATA,InvalidationType.SETTINGS,InvalidationType.SIZE))
         {
            this.rescaleContainer();
            this.updateRenderers();
         }
      }
      
      protected function refreshData() : void
      {
         if(this._dataProvider)
         {
            this.selectedIndex = Math.min(this._dataProvider.length - 1,this._selectedIndex);
            this._dataProvider.requestItemRange(0,this._dataProvider.length - 1,this.populateData);
         }
      }
      
      protected function rescaleContainer() : void
      {
         removeChild(this.container);
         setActualSize(_width,_height);
         this.container.scaleX = 1 / scaleX;
         this.container.scaleY = 1 / scaleY;
         addChild(this.container);
      }
      
      protected function updateRenderers() : void
      {
         var _loc4_:Button = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:Button = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:int = -1;
         if(this._renderers[0] is this._itemRendererClass)
         {
            while(this._renderers.length > this._dataProvider.length)
            {
               _loc6_ = this._renderers.length - 1;
               if(this.container.contains(this._renderers[_loc6_]))
               {
                  if(this._renderers[_loc6_] is IDisposable)
                  {
                     IDisposable(this._renderers[_loc6_]).dispose();
                  }
                  this.container.removeChild(this._renderers[_loc6_]);
               }
               this._renderers.splice(_loc6_--,1);
            }
         }
         else
         {
            this.removeAllRenderers();
         }
         var _loc5_:uint = 0;
         while(_loc5_ < this._dataProvider.length && _loc3_ == -1)
         {
            _loc7_ = false;
            if(_loc5_ < this._renderers.length)
            {
               _loc4_ = this._renderers[_loc5_];
            }
            else
            {
               _loc4_ = Button(App.utils.classFactory.getComponent(this._itemRenderer,Button,null,loaderInfo));
               this.setupRenderer(_loc4_,_loc5_);
               _loc7_ = true;
            }
            this.populateRendererData(_loc4_,_loc5_);
            if(this._autoSize == TextFieldAutoSize.NONE && this._buttonWidth > 0)
            {
               _loc4_.width = this._buttonWidth;
            }
            else if(this._autoSize != TextFieldAutoSize.NONE)
            {
               _loc4_.autoSize = this._autoSize;
            }
            _loc4_.validateNow();
            if(this._direction == DIRECTION_HORIZONTAL)
            {
               if(this._enableOversize || Math.round(_width) >= Math.round(_loc4_.width + this._spacing + _loc1_))
               {
                  _loc4_.y = 0;
                  _loc4_.x = _loc1_;
                  _loc1_ += _loc4_.width + this._spacing;
               }
               else
               {
                  _loc3_ = _loc5_;
                  _loc4_ = null;
               }
            }
            else if(this._enableOversize || _height > _loc4_.height + this._spacing + _loc2_)
            {
               _loc4_.x = 0;
               _loc4_.y = _loc2_;
               _loc2_ += _loc4_.height + this._spacing;
            }
            else
            {
               _loc3_ = _loc5_;
               _loc4_ = null;
            }
            if(_loc7_ && _loc4_ != null)
            {
               _loc4_.group = this._group;
               this.container.addChild(_loc4_);
               this._renderers.push(_loc4_);
            }
            _loc5_++;
         }
         if(_loc3_ > -1)
         {
            _loc8_ = this._renderers.length - 1;
            while(_loc8_ >= _loc3_)
            {
               _loc9_ = this._renderers[_loc8_];
               if(_loc9_)
               {
                  if(this.container.contains(_loc9_))
                  {
                     this.container.removeChild(_loc9_);
                  }
                  this._renderers.splice(_loc8_,1);
               }
               _loc8_--;
            }
         }
         if(!this.enabled)
         {
            for each(_loc4_ in this._renderers)
            {
               _loc4_.enabled = false;
            }
         }
         this.selectedIndex = Math.min(this._dataProvider.length - 1,this._selectedIndex);
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      public function removeAllRenderers() : void
      {
         var _loc1_:DisplayObject = null;
         while(this.container.numChildren > 0)
         {
            _loc1_ = this.container.removeChildAt(0);
            if(_loc1_ is IDisposable)
            {
               IDisposable(_loc1_).dispose();
            }
         }
         this._renderers.length = 0;
      }
      
      protected function populateData(param1:Array) : void
      {
         var _loc3_:Button = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._renderers.length)
         {
            _loc3_ = this._renderers[_loc2_] as Button;
            this.populateRendererData(_loc3_,_loc2_);
            _loc3_.validateNow();
            _loc2_++;
         }
      }
      
      protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc3_:Object = this._dataProvider.requestItemAt(param2);
         param1.label = this.itemToLabel(_loc3_);
         param1.data = _loc3_;
         param1.selected = param2 == this.selectedIndex;
         param1.invalidate(InvalidationType.DATA);
      }
      
      protected function setupRenderer(param1:Button, param2:uint) : void
      {
         param1.owner = this;
         param1.focusable = false;
         param1.focusTarget = this;
         param1.toggle = true;
         param1.allowDeselect = false;
      }
      
      protected function handleButtonGroupChange(param1:Event) : void
      {
         if(this._group.selectedIndex != this.selectedIndex)
         {
            this.selectedIndex = this._group.selectedIndex;
            dispatchEventAndSound(new ButtonBarEvent(ButtonBarEvent.BUTTON_SELECT,false,true,this._selectedIndex,param1.target as Button));
         }
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      override protected function changeFocus() : void
      {
         var _loc1_:Button = this._renderers[this._selectedIndex] as Button;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.displayFocus = _focused > 0;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + ":" + this._itemRenderer;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
   }
}
