package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.MouseEventEx;
   
   public class CoreList extends UIComponent implements ITutorialCustomComponent
   {
       
      
      protected var _selectedIndex:int = -1;
      
      protected var _newSelectedIndex:int = -1;
      
      protected var _dataProvider:IDataProvider;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _itemRenderer:Class;
      
      protected var _itemRendererName:String = "DefaultListItemRenderer";
      
      protected var _renderers:Vector.<IListItemRenderer>;
      
      protected var _usingExternalRenderers:Boolean = false;
      
      protected var _totalRenderers:uint = 0;
      
      protected var _state:String = "default";
      
      protected var _newFrame:String;
      
      public var canCleanDataProvider:Boolean = true;
      
      public var container:Sprite;
      
      public function CoreList()
      {
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         super();
      }
      
      override protected function initialize() : void
      {
         this.dataProvider = new DataProvider();
         if(this.container == null)
         {
            this.container = new Sprite();
            this.container.name = "container";
            addChild(this.container);
         }
         super.initialize();
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
      
      [Inspectable(defaultValue="DefaultListItemRenderer",name="itemRenderer")]
      public function get itemRendererName() : String
      {
         return this._itemRendererName;
      }
      
      public function set itemRendererName(param1:String) : void
      {
         if(_inspector && param1 == "" || param1 == "" || param1 == "DefaultListItemRenderer")
         {
            return;
         }
         var _loc2_:Class = App.utils.classFactory.getClass(param1,loaderInfo);
         if(_loc2_ != null)
         {
            this._itemRendererName = param1;
            this.itemRenderer = _loc2_;
         }
      }
      
      public function get itemRenderer() : Class
      {
         return this._itemRenderer;
      }
      
      public function set itemRenderer(param1:Class) : void
      {
         this._itemRenderer = param1;
         this._itemRendererName = App.utils.classFactory.getClassName(param1);
         this.invalidateRenderers();
      }
      
      [Inspectable(defaultValue="")]
      public function set itemRendererInstanceName(param1:String) : void
      {
         var _loc4_:IListItemRenderer = null;
         if(param1 == null || param1 == "" || parent == null)
         {
            return;
         }
         var _loc2_:uint = 0;
         var _loc3_:Vector.<IListItemRenderer> = new Vector.<IListItemRenderer>();
         while(++_loc2_)
         {
            _loc4_ = parent.getChildByName(param1 + _loc2_) as IListItemRenderer;
            if(_loc4_ == null)
            {
               if(_loc2_ != 0)
               {
                  break;
               }
            }
            else
            {
               _loc3_.push(_loc4_);
            }
         }
         if(_loc3_.length == 0)
         {
            if(componentInspectorSetting)
            {
               return;
            }
            _loc3_ = null;
         }
         this.itemRendererList = _loc3_;
      }
      
      public function set itemRendererList(param1:Vector.<IListItemRenderer>) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._usingExternalRenderers)
         {
            _loc2_ = this._renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.cleanUpRenderer(this.getRendererAt(_loc3_));
               _loc3_++;
            }
         }
         this._usingExternalRenderers = param1 != null;
         this._renderers = param1;
         if(this._usingExternalRenderers)
         {
            _loc2_ = this._renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.setupRenderer(this.getRendererAt(_loc3_));
               _loc3_++;
            }
            this._totalRenderers = this._renderers.length;
         }
         this.invalidateRenderers();
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Object = null;
         if(this._selectedIndex == param1)
         {
            return;
         }
         this._selectedIndex = param1;
         this.invalidateSelectedIndex();
         if(this._selectedIndex > -1)
         {
            _loc2_ = this.getRendererAt(this._selectedIndex);
            _loc3_ = Boolean(this.dataProvider) ? this.dataProvider.requestItemAt(this._selectedIndex) : null;
         }
         if(this.dataProvider)
         {
            dispatchEventAndSound(new ListEvent(ListEvent.INDEX_CHANGE,true,false,this._selectedIndex,-1,-1,_loc2_,_loc3_));
         }
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:IListItemRenderer = null;
         super.enabled = param1;
         this.setState(!!super.enabled ? "default" : "disabled");
         if(this._renderers != null)
         {
            _loc2_ = this._renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this.getRendererAt(_loc3_);
               _loc4_.enabled = this.enabled;
               _loc3_++;
            }
         }
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
      
      public function get availableWidth() : Number
      {
         return _width;
      }
      
      public function get availableHeight() : Number
      {
         return _height;
      }
      
      public function scrollToIndex(param1:uint) : void
      {
      }
      
      public function scrollToSelected() : void
      {
         this.scrollToIndex(this._selectedIndex);
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
         if(this._labelField != null && this._labelField in param1 && param1[this._labelField] != null)
         {
            return param1[this._labelField];
         }
         return param1.toString();
      }
      
      public function getRendererAt(param1:uint, param2:int = 0) : IListItemRenderer
      {
         if(this._renderers == null)
         {
            return null;
         }
         var _loc3_:uint = param1 - param2;
         if(_loc3_ >= this._renderers.length)
         {
            return null;
         }
         return this._renderers[_loc3_] as IListItemRenderer;
      }
      
      public function invalidateRenderers() : void
      {
         invalidate(InvalidationType.RENDERERS);
      }
      
      public function invalidateSelectedIndex() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      public function disposeRenderers() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         if(this._renderers != null)
         {
            _loc1_ = this._renderers.length;
            _loc2_ = _loc1_ - 1;
            while(_loc2_ >= 0)
            {
               _loc3_ = this.getRendererAt(_loc2_);
               if(_loc3_ != null)
               {
                  this.cleanUpRenderer(_loc3_);
                  _loc4_ = _loc3_ as DisplayObject;
                  if(this.container.contains(_loc4_))
                  {
                     this.container.removeChild(_loc4_);
                  }
               }
               this._renderers.splice(_loc2_,1);
               _loc2_--;
            }
         }
         if(this.container != null)
         {
            if(contains(this.container))
            {
               removeChild(this.container);
            }
            this.container = null;
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK CoreList " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         this.disposeRenderers();
         this.cleanUpDataProvider();
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tabEnabled = _focusable && this.enabled;
         tabChildren = false;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false,0,true);
         addEventListener(InputEvent.INPUT,handleInput,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._newFrame)
            {
               gotoAndPlay(this._newFrame);
               this._newFrame = null;
            }
         }
         if(_baseDisposed)
         {
            return;
         }
         if(!this._usingExternalRenderers && isInvalid(InvalidationType.RENDERERS))
         {
            if(this._renderers != null)
            {
               _loc2_ = this._renderers.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = this.getRendererAt(_loc1_);
                  this.cleanUpRenderer(_loc3_);
                  _loc4_ = _loc3_ as DisplayObject;
                  if(this.container.contains(_loc4_))
                  {
                     this.container.removeChild(_loc4_);
                  }
                  _loc1_++;
               }
            }
            this._renderers = new Vector.<IListItemRenderer>();
            invalidateData();
         }
         if(!this._usingExternalRenderers && isInvalid(InvalidationType.SIZE))
         {
            this.rescaleContainer();
            this._totalRenderers = this.calculateRendererTotal(this.availableWidth,this.availableHeight);
            invalidateData();
         }
         if(!this._usingExternalRenderers && isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE))
         {
            this.drawRenderers(this._totalRenderers);
            this.drawLayout();
         }
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.updateSelectedIndex();
         }
         if(this._dataProvider && isInvalid(InvalidationType.DATA))
         {
            this.refreshData();
         }
      }
      
      override protected function changeFocus() : void
      {
         if(_focused || _displayFocus)
         {
            this.setState("focused","default");
         }
         else
         {
            this.setState("default");
         }
      }
      
      protected function refreshData() : void
      {
      }
      
      protected function updateSelectedIndex() : void
      {
      }
      
      protected function rescaleContainer() : void
      {
         removeChild(this.container);
         setActualSize(_width,_height);
         this.container.scaleX = 1 / scaleX;
         this.container.scaleY = 1 / scaleY;
         addChild(this.container);
      }
      
      protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         return param2 / 20 >> 0;
      }
      
      protected function drawLayout() : void
      {
      }
      
      protected function drawRenderers(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:DisplayObject = null;
         if(this._itemRenderer == null)
         {
            return;
         }
         _loc2_ = this._renderers.length;
         while(_loc2_ < param1)
         {
            _loc4_ = this.createRenderer(_loc2_);
            if(_loc4_ == null)
            {
               break;
            }
            this._renderers.push(_loc4_);
            this.container.addChild(_loc4_ as DisplayObject);
            _loc2_++;
         }
         _loc3_ = this._renderers.length;
         _loc2_ = _loc3_ - 1;
         while(_loc2_ >= param1)
         {
            _loc4_ = this.getRendererAt(_loc2_);
            if(_loc4_ != null)
            {
               this.cleanUpRenderer(_loc4_);
               _loc5_ = _loc4_ as DisplayObject;
               if(this.container.contains(_loc5_))
               {
                  this.container.removeChild(_loc5_);
               }
            }
            this._renderers.splice(_loc2_,1);
            _loc2_--;
         }
      }
      
      protected function createRenderer(param1:uint) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = App.utils.classFactory.getComponent(this._itemRendererName,IListItemRenderer,null,loaderInfo) as IListItemRenderer;
         if(_loc2_ == null)
         {
            return null;
         }
         this.setupRenderer(_loc2_);
         return _loc2_;
      }
      
      protected function setupRenderer(param1:IListItemRenderer) : void
      {
         param1.owner = this;
         param1.focusTarget = this;
         param1.tabEnabled = false;
         param1.doubleClickEnabled = true;
         param1.addEventListener(ButtonEvent.PRESS,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(ButtonEvent.CLICK,this.handleItemClick,false,0,true);
         param1.addEventListener(MouseEvent.DOUBLE_CLICK,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.dispatchItemEvent,false,0,true);
         if(this._usingExternalRenderers)
         {
            param1.addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false,0,true);
         }
      }
      
      protected function cleanUpRenderer(param1:IListItemRenderer) : void
      {
         param1.owner = null;
         param1.focusTarget = null;
         param1.doubleClickEnabled = false;
         param1.removeEventListener(ButtonEvent.PRESS,this.dispatchItemEvent);
         param1.removeEventListener(ButtonEvent.CLICK,this.handleItemClick);
         param1.removeEventListener(MouseEvent.DOUBLE_CLICK,this.dispatchItemEvent);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.dispatchItemEvent);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.dispatchItemEvent);
         param1.removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
         this.disposeRenderer(param1);
      }
      
      protected function disposeRenderer(param1:IListItemRenderer) : void
      {
         var _loc2_:IDisposable = param1 as IDisposable;
         if(_loc2_ && !_loc2_.isDisposed())
         {
            _loc2_.dispose();
         }
      }
      
      protected function cleanUpDataProvider() : void
      {
         if(this._dataProvider)
         {
            if(this.canCleanDataProvider)
            {
               this._dataProvider.cleanUp();
            }
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange);
            this._dataProvider = null;
         }
      }
      
      protected function dispatchItemEvent(param1:Event) : Boolean
      {
         var _loc2_:String = null;
         switch(param1.type)
         {
            case ButtonEvent.PRESS:
               _loc2_ = ListEvent.ITEM_PRESS;
               break;
            case ButtonEvent.CLICK:
               _loc2_ = ListEvent.ITEM_CLICK;
               break;
            case MouseEvent.ROLL_OVER:
               _loc2_ = ListEvent.ITEM_ROLL_OVER;
               break;
            case MouseEvent.ROLL_OUT:
               _loc2_ = ListEvent.ITEM_ROLL_OUT;
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc2_ = ListEvent.ITEM_DOUBLE_CLICK;
               break;
            default:
               return true;
         }
         var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
         var _loc4_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc4_ = (param1 as ButtonEvent).controllerIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc4_ = (param1 as MouseEventEx).mouseIdx;
         }
         var _loc5_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc5_ = (param1 as ButtonEvent).buttonIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc5_ = (param1 as MouseEventEx).buttonIdx;
         }
         var _loc6_:Boolean = false;
         if(param1 is ButtonEvent)
         {
            _loc6_ = (param1 as ButtonEvent).isKeyboard;
         }
         var _loc7_:ListEvent = new ListEvent(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,Boolean(this.dataProvider) ? this.dataProvider.requestItemAt(_loc3_.index) : null,_loc4_,_loc5_,_loc6_);
         this.onLogEvent(_loc7_,_loc3_.index);
         return dispatchEventAndSound(_loc7_);
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      protected function handleItemClick(param1:ButtonEvent) : void
      {
         var _loc2_:Number = (param1.currentTarget as IListItemRenderer).index;
         if(isNaN(_loc2_))
         {
            return;
         }
         this.onLogEvent(param1,_loc2_);
         if(this.dispatchItemEvent(param1))
         {
            this.selectedIndex = _loc2_;
         }
      }
      
      protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(!App.contextMenuMgr.isShown())
         {
            this.scrollList(param1.delta > 0 ? int(1) : int(-1));
         }
      }
      
      protected function scrollList(param1:int) : void
      {
      }
      
      protected function setState(... rest) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(rest.length == 1)
         {
            _loc4_ = rest[0].toString();
            if(this._state != _loc4_ && _labelHash[_loc4_])
            {
               this._state = this._newFrame = _loc4_;
               invalidateState();
            }
            return;
         }
         var _loc2_:uint = rest.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = rest[_loc3_].toString();
            if(_labelHash[_loc5_])
            {
               this._state = this._newFrame = _loc5_;
               invalidateState();
               break;
            }
            _loc3_++;
         }
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + ":" + this.itemRendererName;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      private function onLogEvent(param1:Event, param2:uint) : void
      {
         if(this.canLog())
         {
            this.callLogEvent(param1,param2);
         }
      }
      
      protected function canLog() : Boolean
      {
         return true;
      }
      
      protected function callLogEvent(param1:Event, param2:uint) : void
      {
         var _loc3_:DisplayObject = this as DisplayObject;
         App.utils.asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
         App.eventLogManager.logUIEventRenderer(_loc3_,param1,param2);
      }
   }
}
