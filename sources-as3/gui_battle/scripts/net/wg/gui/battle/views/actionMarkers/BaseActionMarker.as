package net.wg.gui.battle.views.actionMarkers
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class BaseActionMarker extends BattleUIComponent
   {
       
      
      public var replyMarker:RepliedMarker = null;
      
      public var stickyMarker:StickyMarker = null;
      
      protected var putTextVisible:Boolean = false;
      
      protected var id:int = -1;
      
      public function BaseActionMarker()
      {
         super();
         this.setStickyAndReplyMarkers();
         this.putTextVisible = true;
      }
      
      protected function get getReplyPosition() : Point
      {
         return new Point(0,0);
      }
      
      protected function get getArrowPosition() : Point
      {
         return new Point(0,0);
      }
      
      protected function get getDistanceToMarkerPosition() : Point
      {
         return new Point(0,0);
      }
      
      public function setIdentifier(param1:int) : void
      {
         this.id = param1;
      }
      
      private function setStickyAndReplyMarkers() : void
      {
         var _loc1_:Class = getDefinitionByName(Linkages.REPLIED_MARKER_UI) as Class;
         this.replyMarker = new _loc1_();
         if(this.replyMarker)
         {
            addChild(this.replyMarker);
         }
         this.replyMarker.visible = false;
         this.replyMarker.setReplyElementPosition(this.getReplyPosition);
         var _loc2_:Class = getDefinitionByName(Linkages.STICKY_MARKER_UI) as Class;
         this.stickyMarker = new _loc2_();
         if(this.stickyMarker)
         {
            addChild(this.stickyMarker);
         }
         this.stickyMarker.visible = false;
         this.stickyMarker.setTextLabelVisible(this.putTextVisible);
         this.stickyMarker.setTextLabelPosition(this.getDistanceToMarkerPosition);
         this.stickyMarker.setArrowVisible(true);
         this.stickyMarker.setArrowPosition(this.getArrowPosition);
      }
      
      public function setTextLabelEnabled(param1:Boolean) : void
      {
         this.stickyMarker.setTextLabelEnabled(param1);
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         if(this.replyMarker != null)
         {
            this.replyMarker.visible = param1;
         }
      }
      
      public function setReplyCount(param1:int) : void
      {
         if(this.replyMarker != null)
         {
            this.replyMarker.setReplyCount(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         removeChild(this.replyMarker);
         this.replyMarker.dispose();
         this.replyMarker = null;
         removeChild(this.stickyMarker);
         this.stickyMarker.dispose();
         this.stickyMarker = null;
         super.onDispose();
      }
   }
}
