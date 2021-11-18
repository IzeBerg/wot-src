package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   
   public class DetailsStatsScrollPane extends ResizableScrollPane
   {
      
      private static const MAX_CONTENT_HEIGHT:Number = 643;
       
      
      public var detailsScrollBar:ScrollBar;
      
      public var topLip:Sprite;
      
      public var bottomLip:Sprite;
      
      private var _detailsStats:DetailsStats;
      
      public function DetailsStatsScrollPane()
      {
         super();
         this._detailsStats = DetailsStats(target);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setOffsetY(y);
         this.topLip.mouseEnabled = false;
         this.bottomLip.mouseEnabled = false;
         scrollStepFactor = 10;
         scrollBar = this.detailsScrollBar;
      }
      
      override protected function applyScrollBarUpdating() : void
      {
         super.applyScrollBarUpdating();
         if(_scrollBar && DisplayObject(_scrollBar).visible)
         {
            this.topLip.visible = _scrollBar.position > 0;
            this.bottomLip.visible = _scrollBar.position < maxScroll;
         }
         else
         {
            this.topLip.visible = this.bottomLip.visible = false;
         }
      }
      
      override protected function applyTargetChanges() : void
      {
         super.applyTargetChanges();
         setChildIndex(this.topLip,numChildren - 1);
         setChildIndex(this.bottomLip,numChildren - 1);
      }
      
      override protected function onDispose() : void
      {
         this.detailsScrollBar = null;
         this.topLip = null;
         this.bottomLip = null;
         this._detailsStats = null;
         super.onDispose();
      }
      
      public function setOffsetY(param1:Number) : void
      {
         y = param1;
         height = MAX_CONTENT_HEIGHT - param1;
         this.detailsScrollBar.height = _height - 2 * this.detailsScrollBar.y;
         this._detailsStats.setPageHeight(_height);
         this.bottomLip.y = _height;
      }
      
      public function get detailsStats() : DetailsStats
      {
         return this._detailsStats;
      }
   }
}
