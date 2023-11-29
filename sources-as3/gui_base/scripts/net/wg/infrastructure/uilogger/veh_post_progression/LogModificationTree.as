package net.wg.infrastructure.uilogger.veh_post_progression
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class LogModificationTree extends UILogger
   {
      
      private static const BACK_BUTTON:String = "backButton";
      
      private static const ESC_PRESSED:String = "escPressed";
      
      private static const TO_PREVIEW:String = "toPreview";
      
      private static const FROM_MINIMUM:String = "from_minimum";
       
      
      private var _resizeLogged:Boolean = false;
      
      private var _exitLogged:Boolean = false;
      
      public function LogModificationTree()
      {
         super(Constants.FEATURE,Constants.GROUP_MODIFICATIONS_TREE);
      }
      
      public function enterScreen() : void
      {
         startAction(Constants.ACTION_CLOSE);
      }
      
      public function exitScreenWithBackButton() : void
      {
         this.logExit(BACK_BUTTON);
      }
      
      public function exitScreenWithEscButton() : void
      {
         this.logExit(ESC_PRESSED);
      }
      
      public function exitScreenWithToPreviewButton() : void
      {
         this.logExit(TO_PREVIEW);
      }
      
      override public function dispose() : void
      {
         if(!this._exitLogged)
         {
            this.logExit(Values.EMPTY_STR);
         }
         super.dispose();
      }
      
      public function logResize() : void
      {
         if(this._resizeLogged)
         {
            return;
         }
         var _loc1_:Object = {
            "parent_screen":Constants.GROUP_MODIFICATIONS_TREE,
            "additional_info":FROM_MINIMUM
         };
         log(Constants.RESIZE,LogLevels.INFO,_loc1_);
         this._resizeLogged = true;
      }
      
      private function logExit(param1:String) : void
      {
         this._exitLogged = true;
         var _loc2_:Object = {
            "parent_screen":Constants.GROUP_MODIFICATIONS_TREE,
            "additional_info":(param1 == Values.EMPTY_STR ? null : param1)
         };
         stopAction(Constants.ACTION_CLOSE,LogLevels.INFO,_loc2_);
      }
   }
}
