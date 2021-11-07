package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.controls.helpers.TextLoadingStyle;
   import scaleform.clik.core.UIComponent;
   
   public class TextLoading extends UIComponent
   {
      
      private static const TF_GAP:Number = 0;
      
      private static const STATE_DEFAULT_STATE:String = "default";
      
      private static const STATE_LOADING_NAME:String = "loadingName";
      
      private static const STATE_LOADING_RATING:String = "loadingRating";
       
      
      public var loadingAnimation:InviteIndicator = null;
      
      public var textField:TextField = null;
      
      private var currentState:String = "";
      
      public function TextLoading()
      {
         super();
         this.setState(STATE_DEFAULT_STATE);
      }
      
      override protected function onDispose() : void
      {
         this.loadingAnimation.dispose();
         this.loadingAnimation = null;
         this.textField = null;
         this.currentState = null;
         super.onDispose();
      }
      
      public function getLoadingStyle() : String
      {
         switch(this.currentState)
         {
            case STATE_LOADING_NAME:
               return TextLoadingStyle.LOADING_STYLE_NAME;
            case STATE_LOADING_RATING:
               return TextLoadingStyle.LOADING_STYLE_RATING;
            default:
               return TextLoadingStyle.LOADING_STYLE_NONE;
         }
      }
      
      public function setLoadingStyle(param1:String) : void
      {
         switch(param1)
         {
            case TextLoadingStyle.LOADING_STYLE_NAME:
               this.setState(STATE_LOADING_NAME);
               break;
            case TextLoadingStyle.LOADING_STYLE_RATING:
               this.setState(STATE_LOADING_RATING);
               break;
            default:
               this.setState(STATE_DEFAULT_STATE);
         }
      }
      
      private function setState(param1:String) : void
      {
         if(this.currentState == param1)
         {
            return;
         }
         switch(param1)
         {
            case STATE_DEFAULT_STATE:
            default:
               this.loadingAnimation.visible = false;
               this.textField.visible = false;
               this.loadingAnimation.stop();
               break;
            case STATE_LOADING_NAME:
               this.loadingAnimation.visible = true;
               this.textField.visible = true;
               this.textField.text = CYBERSPORT.TEXTLOADING_LOADING;
               this.textField.x = this.loadingAnimation.x + this.loadingAnimation.width * 0.5 + TF_GAP;
               this.loadingAnimation.gotoAndPlay(1);
               break;
            case STATE_LOADING_RATING:
               this.loadingAnimation.visible = true;
               this.textField.visible = false;
               this.textField.x = 0;
               this.loadingAnimation.gotoAndPlay(1);
         }
         this.currentState = param1;
      }
   }
}
