package net.wg.gui.lobby.questsWindow.components
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResizableContainer extends UIComponentEx
   {
      
      private static const INV_AVAILABLE_HEIGHT:String = "invAvHeight";
      
      private static const INV_BLOCK_SIZE:String = "invBlockSize";
       
      
      protected var _blocks:Vector.<IResizableContent> = null;
      
      protected var totalBlocks:int = 0;
      
      private var _data:Array;
      
      private var _isReadyForLayout:Boolean = false;
      
      private var _contentAlign:String = "left";
      
      private var _verticalPadding:int = 0;
      
      private var _availableWidth:Number = 375;
      
      private var _availableHeight:Number = NaN;
      
      private var _bottomPadding:int = 0;
      
      private var _isNumerated:Boolean = false;
      
      public function ResizableContainer()
      {
         this._data = [];
         super();
         this._blocks = new Vector.<IResizableContent>();
      }
      
      public function setData(param1:Array) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function cleanContainer() : void
      {
         invalidateData();
      }
      
      public function get isReadyForLayout() : Boolean
      {
         return this._isReadyForLayout;
      }
      
      public function set isReadyForLayout(param1:Boolean) : void
      {
         this._isReadyForLayout = param1;
      }
      
      public function get data() : Array
      {
         return this._data;
      }
      
      public function set data(param1:Array) : void
      {
         this._data = param1;
      }
      
      public function get verticalPadding() : int
      {
         return this._verticalPadding;
      }
      
      public function set verticalPadding(param1:int) : void
      {
         this._verticalPadding = param1;
      }
      
      public function get availableWidth() : Number
      {
         return this._availableWidth;
      }
      
      public function set availableWidth(param1:Number) : void
      {
         this._availableWidth = param1;
      }
      
      public function get bottomPadding() : int
      {
         return this._bottomPadding;
      }
      
      public function set bottomPadding(param1:int) : void
      {
         this._bottomPadding = param1;
      }
      
      public function get contentAlign() : String
      {
         return this._contentAlign;
      }
      
      public function set contentAlign(param1:String) : void
      {
         this._contentAlign = param1;
      }
      
      public function get isNumerated() : Boolean
      {
         return this._isNumerated;
      }
      
      public function set isNumerated(param1:Boolean) : void
      {
         this._isNumerated = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ResizableBlockEvent.CONTETNT_WAS_CHANGED,this.componentsResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ResizableBlockEvent.CONTETNT_WAS_CHANGED,this.componentsResizeHandler);
         if(this._blocks)
         {
            this.clearBlocks();
            this._blocks = null;
         }
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.createBlocks();
            invalidate(INV_BLOCK_SIZE);
         }
         if(isInvalid(INV_AVAILABLE_HEIGHT) && this._availableHeight)
         {
            this.invalidateAvailableHeight();
         }
         if(isInvalid(INV_BLOCK_SIZE))
         {
            this.layoutBlocks();
         }
      }
      
      private function invalidateAvailableHeight() : void
      {
         var _loc4_:IResizableContent = null;
         var _loc1_:int = -1;
         this.totalBlocks = this._blocks.length;
         var _loc2_:int = 0;
         while(_loc2_ < this.totalBlocks)
         {
            if(this._availableHeight < Math.round(this._blocks[_loc2_].y + this._blocks[_loc2_].height))
            {
               _loc1_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         if(_loc1_ != -1)
         {
            while(this._blocks.length > _loc1_)
            {
               _loc4_ = this._blocks.pop();
               _loc4_.removeEventListener(Event.RESIZE,this.onBlockResizeHandler);
               _loc4_.dispose();
               removeChild(DisplayObject(_loc4_));
            }
         }
         this.totalBlocks = this._blocks.length;
         var _loc3_:Number = Math.round(this.totalBlocks > 0 ? Number(this._blocks[this.totalBlocks - 1].height + this._blocks[this.totalBlocks - 1].y + this.bottomPadding) : Number(0));
         setSize(this.width,_loc3_);
      }
      
      protected function clearBlocks() : void
      {
         var _loc1_:IResizableContent = null;
         for each(_loc1_ in this._blocks)
         {
            _loc1_.removeEventListener(Event.RESIZE,this.onBlockResizeHandler);
            _loc1_.dispose();
            removeChild(DisplayObject(_loc1_));
         }
         this._blocks.splice(0,this._blocks.length);
      }
      
      protected function createBlocks() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IAssertable = App.utils.asserter;
         this.clearBlocks();
         if(this._data && this._data.length)
         {
            this.totalBlocks = this._data.length;
            _loc2_ = 0;
            while(_loc2_ < this.totalBlocks)
            {
               _loc1_.assertNotNull(this._data[_loc2_],"ResizableContainer data element" + Errors.CANT_NULL);
               _loc1_.assert(this._data[_loc2_].hasOwnProperty("linkage"),"Data must have linkage");
               this.addBlock(this._data[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            this.cleanContainer();
         }
      }
      
      protected function addBlock(param1:Object) : IResizableContent
      {
         var _loc2_:IResizableContent = App.utils.classFactory.getComponent(param1.linkage,IResizableContent);
         _loc2_.isReadyForLayout = false;
         _loc2_.availableWidth = this.availableWidth;
         _loc2_.contentAlign = this.contentAlign;
         _loc2_.isNumerated = this.isNumerated;
         _loc2_.setData(param1);
         _loc2_.validateNow();
         _loc2_.addEventListener(Event.RESIZE,this.onBlockResizeHandler);
         this._blocks.push(_loc2_);
         addChild(DisplayObject(_loc2_));
         return _loc2_;
      }
      
      protected function layoutBlocks() : void
      {
         this.totalBlocks = this._blocks.length;
         var _loc1_:int = 0;
         while(_loc1_ < this.totalBlocks)
         {
            if(_loc1_ > 0)
            {
               this._blocks[_loc1_].y = Math.round(this._blocks[_loc1_ - 1].y + this._blocks[_loc1_ - 1].height + this._verticalPadding);
            }
            _loc1_++;
         }
         var _loc2_:Number = Math.round(this.totalBlocks > 0 ? Number(this._blocks[this.totalBlocks - 1].height + this._blocks[this.totalBlocks - 1].y + this.bottomPadding) : Number(0));
         setSize(this.width,_loc2_);
         this.isReadyForLayout = true;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      protected function componentsResizeHandler(param1:ResizableBlockEvent) : void
      {
         if(this.isReadyForLayout)
         {
            invalidate(INV_BLOCK_SIZE);
         }
      }
      
      private function onBlockResizeHandler(param1:Event) : void
      {
         invalidate(INV_BLOCK_SIZE);
      }
      
      public function get availableHeight() : Number
      {
         return this._availableHeight;
      }
      
      public function set availableHeight(param1:Number) : void
      {
         this._availableHeight = param1;
         invalidate(INV_AVAILABLE_HEIGHT);
      }
   }
}
