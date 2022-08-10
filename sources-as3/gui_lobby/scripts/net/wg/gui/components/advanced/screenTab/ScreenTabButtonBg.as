package net.wg.gui.components.advanced.screenTab
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScreenTabButtonBg extends UIComponentEx
   {
       
      
      public var lastLine:Sprite;
      
      public var firstLine:Sprite;
      
      public var selectedBg:MovieClip;
      
      public var bg:MovieClip;
      
      private var _selected:Boolean;
      
      private var lastLineItemVisible:Boolean;
      
      public function ScreenTabButtonBg()
      {
         super();
         stop();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.selectedBg.width = _width;
            this.bg.width = _width;
            this.lastLine.x = _width - this.lastLine.width;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.firstLine.visible = !this._selected;
            this.lastLine.visible = this.lastLineItemVisible && !this._selected;
            this.selectedBg.visible = this._selected;
         }
      }
      
      override protected function onDispose() : void
      {
         this.lastLine = null;
         this.firstLine = null;
         this.selectedBg = null;
         this.bg = null;
         super.onDispose();
      }
      
      public function showLastLineItem(param1:Boolean) : void
      {
         this.lastLineItemVisible = param1;
         invalidateData();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         invalidateData();
      }
   }
}
