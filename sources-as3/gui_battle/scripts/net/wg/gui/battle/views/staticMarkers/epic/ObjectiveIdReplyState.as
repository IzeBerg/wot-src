package net.wg.gui.battle.views.staticMarkers.epic
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ObjectiveIdReplyState extends MovieClip implements IDisposable
   {
      
      private static const REPLIED:String = "replied";
      
      private static const HIGHLIGHT:String = "highlight";
       
      
      public var replied:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      public function ObjectiveIdReplyState()
      {
         super();
         if(this.replied != null)
         {
            this.replied.visible = false;
         }
         if(this.highlight != null)
         {
            this.highlight.visible = false;
         }
      }
      
      public function setActiveState(param1:int, param2:int) : void
      {
         if(param1 == ActionMarkerStates.REPLIED_ME)
         {
            gotoAndStop(REPLIED);
            this.replied.visible = true;
            this.replied.gotoAndStop(param2);
         }
         else if(param1 == ActionMarkerStates.REPLIED_ALLY || param1 == ActionMarkerStates.PING_CREATE_STATE)
         {
            gotoAndStop(HIGHLIGHT);
            this.highlight.visible = true;
            this.highlight.gotoAndStop(param2);
         }
         else
         {
            if(this.replied != null)
            {
               this.replied.visible = false;
            }
            if(this.highlight != null)
            {
               this.highlight.visible = false;
            }
         }
      }
      
      public final function dispose() : void
      {
         stop();
         this.replied = null;
         this.highlight = null;
      }
   }
}
