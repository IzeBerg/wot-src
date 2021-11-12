package net.wg.gui.battle.views.actionMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StickyMarker extends Sprite implements IDisposable
   {
       
      
      public var arrow:MovieClip = null;
      
      public var txtLabel:TextField = null;
      
      public var targetHighlight:MovieClip = null;
      
      public function StickyMarker()
      {
         super();
         this.arrow.visible = false;
         this.targetHighlight.visible = false;
         this.txtLabel.visible = false;
      }
      
      public final function dispose() : void
      {
         this.arrow = null;
         this.txtLabel = null;
         this.targetHighlight = null;
      }
      
      public function setArrowPosition(param1:Point) : void
      {
         this.arrow.x = param1.x;
         this.arrow.y = param1.y;
      }
      
      public function setArrowVisible(param1:Boolean) : void
      {
         this.arrow.visible = param1;
      }
      
      public function setTextLabelEnabled(param1:Boolean) : void
      {
         this.txtLabel.alpha = !!param1 ? Number(1) : Number(0);
      }
      
      public function setTextLabelPosition(param1:Point) : void
      {
         this.txtLabel.x = param1.x;
         this.txtLabel.y = param1.y;
      }
      
      public function setTextLabelVisible(param1:Boolean) : void
      {
         this.txtLabel.visible = param1;
      }
   }
}
