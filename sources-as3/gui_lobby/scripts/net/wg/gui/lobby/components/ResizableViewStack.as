package net.wg.gui.lobby.components
{
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class ResizableViewStack extends DataViewStack
   {
      
      private static const OFFSET_INVALID:String = "layoutInv";
      
      private static const AVAILABLE_SIZE_INV:String = "availSizeInv";
       
      
      private var availableSize:Point = null;
      
      private var _centerOffset:int = 0;
      
      public function ResizableViewStack()
      {
         super();
      }
      
      override public function show(param1:String, param2:String) : IViewStackContent
      {
         var _loc3_:IResizableContent = IResizableContent(currentView);
         var _loc4_:IViewStackContent = super.show(param1,param2);
         if(_loc3_)
         {
            _loc3_.active = false;
         }
         _loc3_ = IResizableContent(_loc4_);
         _loc3_.active = true;
         if(this.availableSize)
         {
            _loc3_.setViewSize(this.availableSize.x,this.availableSize.y);
         }
         _loc3_.centerOffset = this._centerOffset;
         return _loc4_;
      }
      
      override public function get width() : Number
      {
         return Boolean(this.availableSize) ? Number(this.availableSize.x) : Number(super.width);
      }
      
      override public function get height() : Number
      {
         return Boolean(this.availableSize) ? Number(this.availableSize.y) : Number(super.height);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(AVAILABLE_SIZE_INV))
         {
            if(this.availableSize && currentView)
            {
               IResizableContent(currentView).setViewSize(this.availableSize.x,this.availableSize.y);
            }
         }
         if(isInvalid(OFFSET_INVALID))
         {
            if(currentView)
            {
               IResizableContent(currentView).centerOffset = this._centerOffset;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.availableSize = null;
         super.onDispose();
      }
      
      public function setAvailableSize(param1:Number, param2:Number) : void
      {
         if(this.availableSize == null)
         {
            this.availableSize = new Point();
         }
         this.availableSize.x = param1;
         this.availableSize.y = param2;
         invalidate(AVAILABLE_SIZE_INV);
      }
      
      public function set centerOffset(param1:int) : void
      {
         this._centerOffset = param1;
         invalidate(OFFSET_INVALID);
      }
   }
}
