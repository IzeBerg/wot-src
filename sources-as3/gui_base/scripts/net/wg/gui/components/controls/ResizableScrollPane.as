package net.wg.gui.components.controls
{
   import flash.events.Event;
   import net.wg.gui.interfaces.IContentSize;
   import scaleform.clik.utils.Padding;
   
   public class ResizableScrollPane extends ScrollPane
   {
       
      
      public var contentPaddings:Padding = null;
      
      public function ResizableScrollPane()
      {
         super();
         this.contentPaddings = new Padding();
      }
      
      override public function getContentHeight() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:IContentSize = null;
         if(_target)
         {
            _loc1_ = 0;
            _loc2_ = _target as IContentSize;
            if(_loc2_)
            {
               _loc1_ = _loc2_.contentHeight;
            }
            else
            {
               _loc1_ = _target.height;
            }
            return _loc1_ + this.contentPaddings.top + this.contentPaddings.bottom;
         }
         return 0;
      }
      
      override protected function applyTargetChanges() : void
      {
         if(target)
         {
            target.removeEventListener(Event.RESIZE,this.onTargetResizeHandler);
            target.addEventListener(Event.RESIZE,this.onTargetResizeHandler,false,0,true);
         }
         super.applyTargetChanges();
      }
      
      override protected function onDispose() : void
      {
         if(target)
         {
            target.removeEventListener(Event.RESIZE,this.onTargetResizeHandler);
         }
         this.contentPaddings = null;
         super.onDispose();
      }
      
      override protected function applyScrollBarUpdating() : void
      {
         super.applyScrollBarUpdating();
         _target.y += this.contentPaddings.top;
      }
      
      private function onTargetResizeHandler(param1:Event) : void
      {
         if(isSmoothScroll)
         {
            _scrollPosition = Math.max(0,Math.min(maxScroll,_scrollPosition));
         }
         else
         {
            _scrollPosition = Math.max(0,Math.min(maxScroll,Math.round(_scrollPosition)));
         }
         invalidateSize();
      }
   }
}
