package net.wg.gui.battle.views.staticMarkers.location
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LocationActionMarker extends BaseActionMarker implements IDisposable
   {
      
      public static const ARROW_POSITION:Point = new Point(0,0);
       
      
      public var locationLineElement:MovieClip = null;
      
      public var locationTopElement:MovieClip = null;
      
      public var highlightAnimation:MovieClip = null;
      
      public var clickAnimation:MovieClip = null;
      
      public var hoverShadow:MovieClip = null;
      
      public var creatorNameField:TextField = null;
      
      private var _replyMarkerVisible:Boolean = false;
      
      private var _replyMarkerCount:int = 0;
      
      public const REPLY_POSITION_X:Number = 20;
      
      public const REPLY_POSITION_Y:Number = -1;
      
      public const DISTANCE_POSITION_X:Number = -43;
      
      public const DISTANCE_POSITION_Y:Number = 8;
      
      public const TOP_ELEMENT_HEIGHT:Number = 60;
      
      public const DISTANCE_LINE_HEIGHT:Number = 60;
      
      public function LocationActionMarker()
      {
         super();
         this.hoverShadow.visible = false;
      }
      
      override protected function get getReplyPosition() : Point
      {
         return new Point(this.REPLY_POSITION_X,this.REPLY_POSITION_Y);
      }
      
      override protected function get getArrowPosition() : Point
      {
         return ARROW_POSITION;
      }
      
      override protected function get getDistanceToMarkerPosition() : Point
      {
         return new Point(this.DISTANCE_POSITION_X,this.DISTANCE_POSITION_Y);
      }
      
      override protected function onDispose() : void
      {
         this.locationLineElement = null;
         this.locationTopElement = null;
         this.highlightAnimation = null;
         this.clickAnimation = null;
         this.hoverShadow = null;
         this.creatorNameField = null;
         super.onDispose();
      }
      
      override public function setMarkerReplied(param1:Boolean) : void
      {
         this._replyMarkerVisible = param1;
         invalidateData();
      }
      
      public function triggerClickAnimation() : void
      {
         this.clickAnimation.visible = true;
         this.clickAnimation.alpha = 1;
         this.clickAnimation.play();
      }
      
      override public function setReplyCount(param1:int) : void
      {
         this._replyMarkerCount = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            super.setMarkerReplied(this._replyMarkerVisible);
            super.setReplyCount(this._replyMarkerCount);
         }
      }
      
      public function setActiveState(param1:String) : void
      {
         this.locationTopElement.gotoAndStop(param1);
         this.locationLineElement.gotoAndStop(param1);
      }
      
      public function setCreatorNameVisible(param1:Boolean) : void
      {
         this.creatorNameField.visible = param1;
         if(stickyMarker != null)
         {
            stickyMarker.setTextLabelVisible(!param1);
         }
      }
      
      public function setCreatorNameText(param1:String) : void
      {
         this.creatorNameField.text = param1;
      }
   }
}
