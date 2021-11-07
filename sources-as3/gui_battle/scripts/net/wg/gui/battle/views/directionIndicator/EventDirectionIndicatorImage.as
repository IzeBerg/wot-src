package net.wg.gui.battle.views.directionIndicator
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventDirectionIndicatorImage extends Sprite implements IDisposable
   {
       
      
      public var eventFull:DisplayObject;
      
      public var eventNotFull:DisplayObject;
      
      public function EventDirectionIndicatorImage()
      {
         super();
         this.eventFull.visible = false;
         this.eventNotFull.visible = true;
      }
      
      public function dispose() : void
      {
         this.eventFull = null;
         this.eventNotFull = null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         this.eventFull.visible = param1;
         this.eventNotFull.visible = !param1;
      }
   }
}
