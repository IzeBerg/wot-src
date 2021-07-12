package net.wg.gui.lobby.profile.components
{
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ResizableContent extends UIComponentEx implements IResizableContent
   {
       
      
      protected var currentDimension:Point = null;
      
      private var _centerOffset:int = 0;
      
      private var isActive:Boolean = false;
      
      public function ResizableContent()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID) && this.currentDimension)
         {
            this.applyResizing();
         }
         if(isInvalid(ResizableInvalidationTypes.ACTIVE_INVALID))
         {
            this.applyActivation();
         }
      }
      
      override protected function onDispose() : void
      {
         this.currentDimension = null;
         super.onDispose();
      }
      
      public function applyResizing() : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         if(!this.currentDimension)
         {
            this.currentDimension = new Point();
         }
         this.currentDimension.x = param1;
         this.currentDimension.y = param2;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function applyActivation() : void
      {
      }
      
      public function get active() : Boolean
      {
         return this.isActive;
      }
      
      public function set active(param1:Boolean) : void
      {
         this.isActive = param1;
         invalidate(ResizableInvalidationTypes.ACTIVE_INVALID);
      }
      
      public function get centerOffset() : int
      {
         return this._centerOffset;
      }
      
      public function set centerOffset(param1:int) : void
      {
         this._centerOffset = param1;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }
   }
}
