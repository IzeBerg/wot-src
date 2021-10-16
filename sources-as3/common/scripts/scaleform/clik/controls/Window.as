package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.ResizeEvent;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class Window extends UIComponent
   {
       
      
      [Inspectable(defaultValue="150")]
      public var minWidth:Number = 150;
      
      [Inspectable(defaultValue="500")]
      public var maxWidth:Number = 500;
      
      [Inspectable(defaultValue="150")]
      public var minHeight:Number = 150;
      
      [Inspectable(defaultValue="500")]
      public var maxHeight:Number = 500;
      
      protected var _title:String;
      
      protected var _src:String = "";
      
      protected var _contentPadding:Padding;
      
      protected var _content:DisplayObject;
      
      protected var _dragProps:Array;
      
      public var closeBtn:Button;
      
      public var okBtn:Button;
      
      public var resizeBtn:Button;
      
      public var titleBtn:Button;
      
      public var background:MovieClip;
      
      public var hit:MovieClip;
      
      public function Window()
      {
         super();
         this._contentPadding = new Padding(0,0,0,0);
         hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         this._content = null;
         this._contentPadding = null;
         this._dragProps = null;
         this.hit = null;
         super.onDispose();
      }
      
      [Inspectable(defaultValue="My Window")]
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
         if(this.titleBtn != null && this.titleBtn.initialized)
         {
            this.titleBtn.label = this._title;
         }
      }
      
      [Inspectable(defaultValue="")]
      public function get source() : String
      {
         return this._src;
      }
      
      public function set source(param1:String) : void
      {
         this._src = param1;
         invalidate("source");
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="contentPadding")]
      public function get contentPadding() : Object
      {
         return this._contentPadding;
      }
      
      public function set contentPadding(param1:Object) : void
      {
         this._contentPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
         invalidate("padding");
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function initialize() : void
      {
         tabEnabled = false;
         mouseEnabled = mouseChildren = enabled;
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         initSize();
         if(hitArea != null)
         {
            constraints.addElement("hitArea",hitArea,Constraints.ALL);
         }
         if(this.background != null)
         {
            constraints.addElement("background",this.background,Constraints.ALL);
         }
         if(this.titleBtn != null)
         {
            this.titleBtn.label = this._title || "My Window";
            this.titleBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onWindowStartDrag,false,0,true);
            constraints.addElement("titleBtn",this.titleBtn,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
         }
         if(this.closeBtn != null)
         {
            this.closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
            constraints.addElement("closeBtn",this.closeBtn,Constraints.TOP | Constraints.RIGHT);
         }
         if(this.resizeBtn != null)
         {
            constraints.addElement("resizeBtn",this.resizeBtn,Constraints.BOTTOM | Constraints.RIGHT);
            this.resizeBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onResizeStartDrag,false,0,true);
         }
         if(this.okBtn != null)
         {
            constraints.addElement("okBtn",this.okBtn,Constraints.BOTTOM | Constraints.RIGHT);
            this.okBtn.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("source"))
         {
            this.loadSource();
            this.reflowContent();
         }
         else if(isInvalid("padding"))
         {
            this.reflowContent();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
      
      protected function loadSource() : void
      {
         var _loc1_:Class = null;
         if(this._src != "")
         {
            if(this._content)
            {
               constraints.removeElement("content");
               removeChild(this._content);
            }
            _loc1_ = App.utils.classFactory.getClass(this._src,loaderInfo) as Class;
            if(!_loc1_)
            {
               this._content = null;
               return;
            }
            this._content = DisplayObject(App.utils.classFactory.getComponent(this._src,DisplayObject,null,loaderInfo));
            addChild(this._content);
            constraints.addElement("content",this._content,Constraints.ALL);
            this._content.name = "content";
         }
      }
      
      protected function reflowContent() : void
      {
         if(!this._content)
         {
            return;
         }
         var _loc1_:Padding = this._contentPadding;
         var _loc2_:ConstrainedElement = constraints.getElement("content");
         this._content.x = _loc2_.left = _loc1_.left;
         this._content.y = _loc2_.top = _loc1_.top;
         _loc2_.right = _loc1_.right;
         _loc2_.bottom = _loc1_.bottom;
         this._content.width = _width - _loc1_.horizontal;
         this._content.height = _height - _loc1_.vertical;
         invalidateSize();
      }
      
      protected function onWindowStartDrag(param1:Event) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onWindowStopDrag,false,0,true);
         startDrag();
      }
      
      protected function onWindowStopDrag(param1:Event) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onWindowStopDrag,false);
         stopDrag();
      }
      
      protected function onResizeStartDrag(param1:Event) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onResizeStopDrag,false,0,true);
         this._dragProps = [parent.mouseX - (x + width),parent.mouseY - (y + height)];
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onResizeMouseMove,false,0,true);
      }
      
      protected function onResizeStopDrag(param1:Event) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onResizeMouseMove,false);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onResizeStopDrag,false);
      }
      
      protected function onResizeMouseMove(param1:Event) : void
      {
         var _loc2_:Number = Math.max(this.minWidth,Math.min(this.maxWidth,parent.mouseX - x - this._dragProps[0]));
         var _loc3_:Number = Math.max(this.minHeight,Math.min(this.maxHeight,parent.mouseY - y - this._dragProps[1]));
         if(_loc2_ != _width || _loc3_ != _height)
         {
            setSize(_loc2_,_loc3_);
            dispatchEventAndSound(new ResizeEvent(ResizeEvent.RESIZE,scaleX,scaleY));
         }
      }
      
      protected function onCloseButtonClick(param1:MouseEvent) : void
      {
         parent.removeChild(this);
         dispatchEventAndSound(new ComponentEvent(ComponentEvent.HIDE));
      }
   }
}
