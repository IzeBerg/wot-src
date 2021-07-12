package net.wg.gui.battle.views.actionMarkers
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RepliedMarker extends Sprite implements IDisposable
   {
       
      
      public var replyElement:RepliedMarkerIcon = null;
      
      public function RepliedMarker()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.replyElement.dispose();
         this.replyElement = null;
      }
      
      public function setReplyElementPosition(param1:Point) : void
      {
         this.replyElement.x = param1.x;
         this.replyElement.y = param1.y;
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.replyElement.playIconAnimation();
         this.replyElement.txtLabel.text = param1.toString();
      }
   }
}
