package net.wg.gui.bootcamp.messageWindow.views
{
   import flash.display.Sprite;
   import net.wg.gui.bootcamp.interfaces.IAnimatedMovieClip;
   import scaleform.clik.constants.InvalidationType;
   
   public class MessageViewLinesFinal extends MessageViewLines
   {
       
      
      public var animContainerReferralDescription:IAnimatedMovieClip = null;
      
      public var dashLine:Sprite = null;
      
      public function MessageViewLinesFinal()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.animContainerReferralDescription.mouseChildren = this.animContainerReferralDescription.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.animContainerReferralDescription.dispose();
         this.animContainerReferralDescription = null;
         this.dashLine = null;
         super.onDispose();
      }
      
      override protected function updateContent() : void
      {
         super.updateContent();
         var _loc1_:String = messageData.referralDescription || "";
         this.animContainerReferralDescription.text = _loc1_;
         this.dashLine.visible = _loc1_ != "";
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = getMessageStateLabel();
            this.animContainerReferralDescription.gotoAndPlay(_loc1_);
         }
      }
   }
}
